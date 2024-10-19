# Website
If you want to view the rendered site, visit [caseyavila.com](https://caseyavila.com/)

## Features
- Fast: Unless the page is doing something fancy, each page just is an html
  file, css file, and some fonts.
- Simple: Each page is generated before hosting by an extremely simple python
  script (<35 lines!). Source for pages are in `root`.

## How to Use
- To make the website, run `./make`. You may need to mark the file as
  executable: `chmod +x make`.
- Pages can reference templates (located in `templates/`) with HTML comments
  containing extra hyphens. For example, notice how `index.html` features
  `<!--- header.html --->` and `<!--- footer.html --->` comments at the
  beginning and end respectively.
