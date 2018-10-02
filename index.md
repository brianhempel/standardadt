---
Title: Standard Algebraic Data Types
---

# Standard Algebraic Data Types

Algebraic data types let you express not only your data, but also its shape and its variants.

Real world data typically has a shape, too, often called a _schema_.

However, most popular formats are *data-only*. For example, when working with JSON, humans can *usually* guess the schema by looking at a few example JSON objects. But what if there are other possible variations not illustrated by the examples? You have to go to the docs to learn about variations and details. But even then, the documentation may be incomplete or ambiguous, and computers can't read documentation so there's no guarantee that the actual API follows the documentation.

Instead, Standard ADT schemas are:

1. **Unambiguous.** ADTs express variants. Will this field be ever be `null`? ADTs tell you. Perhaps the API lists both registered users and anonymous users in the same response—what fields are available on each kind?  ADTs make it clear.
2. **Enforceable.** An API that publishes a standard ADT schema can and should verify that all its responses match the schema. You can trust the API will do what it says and will not break your code.
3. **Readable.** Standard ADT schemas can be read by humans or computers. You can understand the data and appropriate classes or data types in your language of choice can be automatically generated from an ADT schema, as can the code to transform Standard ADT responses into objects in your language.

A standard ADT response always contains the schema _and_ the data. So you, and you computer, can interpret what you have received.

## Schema

Basic types are:

| Type                                                         | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `int`                                                        | Arbitrary precision integer.                                 |
| `intN` `uIntN` e.g. `int32` `uInt64`                         | Signed/unsigned integers of various power-of-two sizes. Equivalent to `int` with a refinement of $-2^{N-1} \le n < 2^{N-1}$ for signed and $0 \le n < 2^N$ for unsigned integers. |
| `rational = Rational { numerator : Int, denominator : Int }` | Arbitrary precision rational number.                         |
| `float32` `float64` `float128`                               | IEEE floating point numbers of various sizes.                |
| `bool = True &#124; False`                                   | Booleans, `True` or `False`.                                 |
| `charUTF8`                                                   | A single UTF-8 character.                                    |
| `list<a>`                                                    | A list containing elements of some type `a`.                 |
| `stringUTF8`                                                 | $\equiv$ `list<charUTF8>`                                    |
| <code>optional<a> = Some { element : a } &#124; None</code>  | Optionally contains a value of some type `a`, or no value. In other words, this field may be `null`. |

Refinements:

### Example

The Standard ADT schema, expressed in Standard ADT:

```elm
baseType = Int -- Sizes specified by refinements.
         | Rational
         | Float32 | Float64 | Float128
         | CharUTF8

refinement = Variable typeName
           | And refinement refinement
           | Or refinement refinement
           | Bool bool
           | Application
           | Function

type = Alias typeName
     | BaseType baseType
     | ForAll list<typeName> type
     | Application type list<type>
     | Record list<recordField>
     | Variants list<variant>
     | Refined type list<refinement>

recordField = { name : typeName
              , type : type }

variant = { name               : variantName
          , args               : list<recordField>
          , optionalRefinement : optional<refinement> }

typeName    = { string : stringUTF8 | string =~ /\A[a-z][A-Za-z0-9_]*\z/ }
varName     = { string : stringUTF8 | string =~ /\A[a-z][A-Za-z0-9_]*\z/ }
variantName = { string : stringUTF8 | string =~ /\A[A-Z][A-Za-z0-9_]*\z/ }

typeDefinition = TypeDefinition { name : typeName, type : type }

schemaRoot = SchemaRoot { definitions : list<typeDefinition>, objectType : typeName }

schemaRoot
```





## Data

Data looks like