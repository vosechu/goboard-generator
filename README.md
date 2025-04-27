# Copy of the source from micans.org goboard generator

I've used the boards and these generators from https://micans.org/goboards for years, but my paper copies have gotten too stained to bear, so I needed to generate new ones. Unfortunately, 5x5 and 7x7 weren't supported out of the box, so I needed to make a couple changes. Additionally, I wanted to add some docs and instructions for converting to pdf on a mac.

## Generating Go Boards

### Small Boards (A4 paper)

To generate a 5x5 board on A4 paper with center star point:
```
./gb-TEMPLATE --papersize=A4 --size=5 --hhh="[3 3]" > gb5a4.ps
```

To generate a 7x7 board on A4 paper with four star points:
```
./gb-TEMPLATE --papersize=A4 --size=7 --hh="3 5" > gb7a4.ps
```

To generate a 9x9 board on A4 paper with standard star points:
```
./gb-TEMPLATE --papersize=A4 --size=9 --hh="3 7" --hhh="[5 5]" > gb9a4.ps
```

### Large Boards (A3/A2 paper)

To generate a 13x13 board on A3 paper:
```
./gb-TEMPLATE --papersize=A3 --size=13 --hh="4 7 10" > gb13a3.ps
```

To generate a 19x19 board on A2 paper:
```
./gb-TEMPLATE --papersize=A2 --size=19 --hh="4 10 16" > gb19a2.ps
```

## Board Backgrounds and Customization

### Using Wood Grain or Image Backgrounds

You can add a wood grain or other image background to your board using the `--grain` option. The `/grains` folder contains several ready-to-use backgrounds:

- `kaya.ps`: Traditional kaya wood grain, classic for Go boards.
- `agathis.ps`: Agathis wood grain, a light and even texture.
- `katsura.ps`: Katsura wood grain, another traditional Go board wood.

**Example:**
```
./gb-TEMPLATE --papersize=A3 --size=13 --grain=grains/kaya.ps > gb13a3.ps
```

#### Using Your Own PNG/JPG as a Grain Background

The `--grain` option requires a PostScript file, not a PNG or JPG. To use your own image:

1. **Install Netpbm tools** (if not already installed):
   ```sh
   brew install netpbm
   ```
2. **Convert your image to PNM:**
   ```sh
   pngtopnm mywood.png > mywood.pnm
   # or for JPG:
   jpegtopnm mywood.jpg > mywood.pnm
   ```
3. **Convert PNM to PostScript:**
   ```sh
   pnmtops mywood.pnm > grains/mywood.ps
   ```
4. **Use the new grain:**
   ```sh
   ./gb-TEMPLATE --papersize=A3 --size=13 --grain=grains/mywood.ps > boards/gb13a3-mywood.ps
   ```

You can control the size and cropping of the background with:
- `--set=bgsize=14` (background size in grid units)
- `--set=clipsize=14` (visible part of the background in grid units)

**Example with size/crop:**
```
./gb-TEMPLATE --papersize=A3 --size=13 --grain=grains/mywood.ps --set=bgsize=14 --set=clipsize=13 > boards/gb13a3-mywood.ps
```

### Simple Colored Backgrounds

- Gray background: `--set=graybg=0.8` (value between 0 [black] and 1 [white])
- Colored background: `--set=colorbg="0.9 0.8 0.7"` (RGB values between 0 and 1)

**Example:**
```
./gb-TEMPLATE --papersize=A4 --size=9 --set=graybg=0.8 > gb9a4.ps
./gb-TEMPLATE --papersize=A4 --size=9 --set=colorbg="0.9 0.8 0.7" > gb9a4.ps
```

### Custom Text

Add custom text to the left or right border:
- `--set=txtlft="Left text"`
- `--set=txtrgt="Right text"`

**Example:**
```
./gb-TEMPLATE --papersize=A4 --size=9 --set=txtlft="My Club" --set=txtrgt="2024" > gb9a4.ps
```

### Fonts and Font Size

- Change font: `--set=fontname=/Courier-Bold`
- Change font size: `--set=fontsize=0.3` (in grid units)

**Example:**
```
./gb-TEMPLATE --papersize=A4 --size=9 --set=fontname=/Courier-Bold --set=fontsize=0.3 > gb9a4.ps
```
List available fonts:
```
./gb-TEMPLATE --list-fonts
```

### Line and Star Point Colors

- Change color: `--set=colorlines=Gray` or `--set=colorlines="0.5 0.5 0.5"` (custom RGB)

**Example:**
```
./gb-TEMPLATE --papersize=A4 --size=9 --set=colorlines="0.5 0.5 0.5" > gb9a4.ps
```
List available color names:
```
./gb-TEMPLATE --list-colors
```

### Crop Marks

Add crop marks to help with cutting:
- `--set=cropdx=0.5` (vertical crop lines, in grid units)
- `--set=cropdy=0.5` (horizontal crop lines, in grid units)

**Example:**
```
./gb-TEMPLATE --papersize=A4 --size=9 --set=cropdx=0.5 --set=cropdy=0.5 > gb9a4.ps
```

## Converting to PDF

The above commands generate PostScript (.ps) files. To convert them to PDF, you'll need Ghostscript installed:

```
# Install Ghostscript (if not already installed)
brew install ghostscript

# Convert PostScript to PDF
gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER -sOutputFile=gb5a4.pdf gb5a4.ps
```
