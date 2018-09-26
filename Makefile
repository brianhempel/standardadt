all: index.html

index.html: index.md
	multimarkdown index.md > index.html
