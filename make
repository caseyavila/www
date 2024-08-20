#!/usr/bin/env python3

import os

ROOT = "root"
DOCS = "docs"
EXTRAS = "extras"
TEMPLATES = "templates"

def src_to_doc(path):
    return DOCS + path[len(ROOT):]

def process_invoc(invoc, in_file, out_file, args):
    match invoc[0]:
        case "scripts":
            for arg in args:
                out_file.write(f"<script src=\"{arg}\" defer></script>\n")
        case _:
            with open(f"{TEMPLATES}/{invoc[0]}", "r") as template:
                compile_page(template, out_file, invoc[1:])

def compile_page(in_file, out_file, args):
    for line in in_file:
        if line.strip().startswith("<!--- ") and line.endswith(" --->\n"):
            invoc = line.strip()[6:-5].split(" ")
            process_invoc(invoc, in_file, out_file, args)
        else:
            out_file.write(line)

def compile_dir(directory):
    os.system(f"mkdir -p {src_to_doc(directory)}");
    for file in os.scandir(directory):
        if file.is_file() and not file.name.startswith("."):
            with open(file.path, "r") as in_file, open(src_to_doc(file.path), "w") as out_file:
                compile_page(in_file, out_file, [])
                print(file.path)
        elif file.is_dir():
            compile_dir(file.path)

compile_dir(ROOT)
os.system(f"cp -r {EXTRAS}/* {DOCS}");
