# Website
If you want to view the rendered site, visit [caseyavila.com](https://caseyavila.com/)

## Features
- Fast: Other than fonts, each page just is an html file and css file.
- Simple: Each page is generated before hosting by a POSIX-compliant shell script. Source for pages are in `src`; the final "compiled" site is in `docs`.

## How to Use
- To make the website, run `./make`. You may need to mark the file as executable: `chmod +x make`.
- The `make` script has different `page_types`, which is determined by an html comment on the first line of the page's source. This will determine how the page is generated.
