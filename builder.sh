source $stdenv/setup
mkdir $out

unset PATH
for p in $buildInputs; do
  export PATH=$p/bin${PATH:+:}$PATH
done

cp -r $src/* $out
cd $out
echo $TITLEPAGE > $out/titlepage.tex
cat $out/titlepage.tex
pdflatex main.tex
#find . -type f ! -name 'latex.out/*.pdf' -delete
