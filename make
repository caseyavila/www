#!/usr/bin/env python3

import os

ROOT = "root"
DOCS = "docs"
EXTRAS = "extras"
TEMPLATES = "templates"

def src_to_doc(path):
    return DOCS + path[len(ROOT):]

def compile_page(path):
    with open(path, "r") as in_file, open(src_to_doc(path), "w") as out_file:
        for line in in_file:
            if line.startswith("<!--- ") and line.endswith(" --->\n"):
                with open(f"{TEMPLATES}/{line[6:-6]}", "r") as template:
                    out_file.write(template.read())
            else:
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
