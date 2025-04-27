all: ps pdf

ps:
	# Small boards (A4)
	./gb-TEMPLATE --papersize=A4 --size=5 --hhh="[3 3]" > boards/gb5a4.ps
	./gb-TEMPLATE --papersize=A4 --size=7 --hh="3 5" > boards/gb7a4.ps
	./gb-TEMPLATE --papersize=A4 --size=9 --hh="3 7" --hhh="[5 5]" > boards/gb9a4.ps
	# Large boards (A3/A2)
	./gb-TEMPLATE --papersize=A3 --size=13 --hh="4 7 10" > boards/gb13a3.ps
	./gb-TEMPLATE --papersize=A2 --size=19 --hh="4 10 16" > boards/gb19a2.ps

pdf:
	# Convert all PS files to PDF
	gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER -sOutputFile=boards/gb5a4.pdf boards/gb5a4.ps
	gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER -sOutputFile=boards/gb7a4.pdf boards/gb7a4.ps
	gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER -sOutputFile=boards/gb9a4.pdf boards/gb9a4.ps
	gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER -sOutputFile=boards/gb13a3.pdf boards/gb13a3.ps
	gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER -sOutputFile=boards/gb19a2.pdf boards/gb19a2.ps

clean:
	rm -f *.ps *.pdf boards/*.ps boards/*.pdf test/*.ps test/*.pdf

test: clean
	# Test various backgrounds
	./gb-TEMPLATE --papersize=A4 --size=9 --grain=grains/kaya.ps --set=txtlft="Test: Kaya Grain 9x9" > test/test-kaya-a4-9x9.ps
	./gb-TEMPLATE --papersize=A3 --size=13 --grain=grains/agathis.ps --set=txtlft="Test: Agathis Grain 13x13" > test/test-agathis-a3-13x13.ps
	./gb-TEMPLATE --papersize=A2 --size=19 --grain=grains/katsura.ps --set=txtlft="Test: Katsura Grain 19x19" > test/test-katsura-a2-19x19.ps
	# Test colored backgrounds
	./gb-TEMPLATE --papersize=A4 --size=5 --set=graybg=0.8 --set=txtlft="Test: Gray Background" > test/test-graybg-a4-5x5.ps
	./gb-TEMPLATE --papersize=A4 --size=7 --set=colorbg="0.9 0.8 0.7" --set=txtlft="Test: Custom Color Background" > test/test-colorbg-a4-7x7.ps
	# Test custom text and font
	./gb-TEMPLATE --papersize=A4 --size=5 --set=txtlft="Test: Custom Font & Text" --set=txtrgt="Right Border" --set=fontname=/Courier-Bold --set=fontsize=0.3 > test/test-textfont-a4-5x5.ps
	# Test custom line color
	./gb-TEMPLATE --papersize=A4 --size=9 --set=colorlines="0.5 0.2 0.2" --set=txtlft="Test: Custom Line Color" > test/test-linecolor-a4-9x9.ps
	# Test crop marks
	./gb-TEMPLATE --papersize=A4 --size=9 --set=cropdx=0.5 --set=cropdy=0.5 --set=txtlft="Test: Crop Marks" > test/test-cropmarks-a4-9x9.ps
	@echo "Converting test PS files to PDF..."
	@for f in test/test-*.ps; do \
		echo "Converting $$f to $${f%.ps}.pdf"; \
		gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER -sOutputFile=$${f%.ps}.pdf $$f; \
	done
