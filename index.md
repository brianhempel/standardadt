---
Title: Standard Algebraic Data Types
---

# Standard Algebraic Data Types

Algebraic data types let you express not only your data, but also its shape and its variations.

Real world data, has a shape, also called a _schema_.

A JSON file is data-only. Humans learn by example, so you can _usually_ guess the schema by looking at a JSON object. But what if there are other possible variations? You have to go to the docs to learn about variations and details. But even then, the documentation may be incomplete or ambiguous, and computers can't read documentation so there's no guarantee that the actual API follows the documentation.

The explicit schemas of Standard ADT are:

1. **Unambiguous.** ADTs express variants. Will this field be ever be `null`? ADTs tell you. Perhaps the API  lists both registered users and anonymous users in the same response—what fields are available on each kind?  ADTs make it clear.
2. **Machine-enforcable.** An API that publishes a standard ADT schema can and should verify that all its responses match the schema. You can trust the API will do what it says and will not break your code.
3. **Machine-readable.** Appropriate classes or data types in your language of choice can be automatically generated from an ADT schema, as can the code to transform Standard ADT responses into objects in your language.

## Schema

Primitives are:

| Primitive                                                    | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `Int`                                                        | Arbitrary precision integer.                                 |
| `Int8` `Int16` `Int32` `Int64` `Int128` `UInt8` `UInt16` `UInt32` `UInt64` `UInt128` | Signed/unsigned integers of various sizes.                   |
| `Rational { numerator: Int, denominator: Int }`              | Arbitrary precision rational number. (Useful for arbitrary precision decimals.) |
| `Float32` `Float64`                                          | IEEE 32-bit and 64-bit floating point numbers.               |
| `CharUTF8`                                                   | A single UTF-8 character.                                    |
| `List a`                                                     | A list containing elements of some type `a`.                 |
| `StringUTF8`                                                 | $\equiv$ `List CharUTF8`                                     |

Refinements:

## Data

Data looks like