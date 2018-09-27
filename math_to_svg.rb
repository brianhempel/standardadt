USAGE = 'Converts math in <span class="math">...</span> to inline SVG. Usage: $ ruby math_to_svg.rb file.html'

path = ARGV[0] || (STDERR.puts USAGE; exit 1)

`mkdir -p tmp`

new_html =
  File.read(path).gsub(/<span class="math">\\\(([\s\S]*?)\\\)<\/span>/) do |match_str|
    latex_str = $1.gsub("&lt;", "<").gsub("&gt;", ">")
    latex_doc = %Q|\\documentclass{standalone}\n\\usepackage{amsmath}\n\\begin{document}\n$#{latex_str}$\n\\end{document}|

    File.write("tmp/tmp.tex", latex_doc)

    if system("pdflatex -output-format=dvi -interaction=nonstopmode -output-directory=tmp tmp/tmp.tex")
      if system("dvisvgm --output=tmp/tmp.svg --no-fonts  tmp/tmp.dvi")
        File.read("tmp/tmp.svg")
      else
        match_str
      end
    else
      match_str
    end
  end

`rm -r tmp`

File.write(path, new_html)
