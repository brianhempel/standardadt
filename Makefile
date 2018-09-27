all: index.html

index.html: index.md
	multimarkdown index.md > index.html
	ruby math_to_svg.rb index.html

# Auto-rebuild on file save. Requires fswatch (install with your fav. package manager).
watch:
	fswatch -o *.md -l 0.1 | xargs -n1 -I{} make

clean:
	rm *.html
