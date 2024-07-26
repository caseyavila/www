#!/usr/bin/env python3

import os

ROOT = "root"
DOCS = "docs"
EXTRAS = "extras"
TEMPLATES = "templates"
HEADER = f"{TEMPLATES}/header.html"
FOOTER = f"{TEMPLATES}/footer.html"

def src_to_doc(path):
    return DOCS + path[len(ROOT):]

def compile_page(path):
    with open(path, "r") as in_file, open(src_to_doc(path), "w") as out_file:
        for line in in_file:
            match line:
                case "<!--- header --->\n":
                    with open(HEADER, "r") as header:
                        out_file.write(header.read())
                case "<!--- footer --->\n":
                    with open(FOOTER, "r") as footer:
                        out_file.write(footer.read())
                case _:
                    out_file.write(line)

def compile_dir(directory):
    os.system(f"mkdir -p {src_to_doc(directory)}");
    for file in os.scandir(directory):
        if file.is_file():
            compile_page(file.path)
        else:
            compile_dir(file.path)
        print(file.path)

compile_dir(ROOT)
os.system(f"cp -r {EXTRAS}/* {DOCS}");
