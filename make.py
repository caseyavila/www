#!/usr/bin/env python3

import os

ROOT = "root"
DOCS = "docs"
EXTRAS = "extras"
TEMPLATES = "templates"

def src_to_doc(path):
    return DOCS + path[len(ROOT):]

def compile_page(in_file, out_file):
    for line in in_file:
        if line.strip().startswith("<!--- ") and line.endswith(" --->\n"):
            template = line.strip()[6:-5]
            with open(f"{TEMPLATES}/{template}", "r") as template_file:
                compile_page(template_file, out_file)
        else:
            out_file.write(line)

def compile_dir(directory):
    os.system(f"mkdir -p {src_to_doc(directory)}");
    for file in os.scandir(directory):
        if file.is_file():
            if file.name.endswith(".html"):
                with open(file.path, "r") as in_file, open(src_to_doc(file.path), "w") as out_file:
                    compile_page(in_file, out_file)
            else:
                os.system(f"cp {file.path} {src_to_doc(file.path)}")
            print(file.path)
        elif file.is_dir():
            compile_dir(file.path)

compile_dir(ROOT)
os.system(f"cp -r {EXTRAS}/* {DOCS}");
