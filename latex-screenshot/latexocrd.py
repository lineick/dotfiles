#!/usr/bin/env python3

# LatexOCR Daemon

import os
import sys
import time
import subprocess
from PIL import Image

# 1. Define the Pipe (Communication Channel)
PIPE_PATH = "/tmp/latex_ocr_pipe"

def setup_pipe():
    if not os.path.exists(PIPE_PATH):
        os.mkfifo(PIPE_PATH)

def notify(title, message, level="normal"):
    subprocess.run([
        "notify-send", title, message,
        "-u", level, "-h", "int:transient:1", "-t", "2000"
    ])

def copy_to_clipboard(text):
    # Copy to both clipboard (Ctrl+V) and primary (Middle Click)
    p = subprocess.Popen(['xsel', '-b', '-i'], stdin=subprocess.PIPE)
    p.communicate(input=text.encode('utf-8'))
    p = subprocess.Popen(['xsel', '-p', '-i'], stdin=subprocess.PIPE)
    p.communicate(input=text.encode('utf-8'))

def main():
    setup_pipe()
    
    # 2. Load the Model (This takes time, but only runs once!)
    notify("LaTeX OCR", "Daemon starting... (Loading Model)", "low")
    try:
        from pix2tex.cli import LatexOCR
        model = LatexOCR()
        notify("LaTeX OCR", "Daemon Ready! Snip away.", "low")
    except Exception as e:
        notify("LaTeX OCR Error", str(e), "critical")
        sys.exit(1)

    print("Daemon is running and listening...")

    # 3. Main Loop: Wait for filenames
    while True:
        with open(PIPE_PATH, "r") as pipe:
            # This blocks until a filename is written to the pipe
            filename = pipe.read().strip()
            
            if not filename or not os.path.exists(filename):
                continue

            try:
                # Run Inference
                img = Image.open(filename)
                latex_code = model(img)
                
                # Copy & Notify
                copy_to_clipboard(latex_code)
                notify("LaTeX OCR", "Copied!", "normal")
                
                # Cleanup image
                os.remove(filename)
                
            except Exception as e:
                notify("LaTeX OCR Failed", str(e), "critical")

if __name__ == "__main__":
    main()
