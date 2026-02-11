#!/usr/bin/env python3

import os
import subprocess
import sys

from pix2text import Pix2Text

PIPE_PATH = "/tmp/pix2text_pipe"


def setup_pipe():
    if not os.path.exists(PIPE_PATH):
        os.mkfifo(PIPE_PATH)


def notify(title, message, level="normal"):
    subprocess.run(
        [
            "notify-send",
            title,
            message,
            "-u",
            level,
            "-t",
            "1000",
            "-h",
            "string:x-canonical-private-synchronous:ocr",
            "-h",
            "int:transient:1",
        ]
    )


def copy_to_clipboard(text):
    for flag in ["-b", "-p"]:
        p = subprocess.Popen(["xsel", flag, "-i"], stdin=subprocess.PIPE)
        p.communicate(input=text.encode("utf-8"))


def main():
    setup_pipe()
    notify("Pix2Text OCR", "Starting daemon...", "low")

    try:
        p2t = Pix2Text(
            device="cpu",
            analyzer_config={"model_name": "mfd"},  # math formula detection model
        )
        notify("Pix2Text OCR", "Loaded!", "low")
    except Exception as e:
        notify("Pix2Text OCR Error", str(e), "critical")
        sys.exit(1)

    while True:
        with open(PIPE_PATH, "r") as pipe:
            filename = pipe.read().strip()
            if not filename or not os.path.exists(filename):
                continue

            try:
                # This is optimized for line by line text+formula recognition, e.g. slide screenshots.
                # will still jumble text especially if before inline formulae so ALWAYS proof-read.
                result_text = p2t.recognize(
                    filename,
                    return_text=True,
                    auto_line_break=False,
                    # if overlap above embed_ratio_thresh, text and formula are considered to be in the same line
                    embed_ratio_threshold=0.01,
                    det_text_bbox_max_width_expand_ratio=0.02, # super narrow, less faulty line jumbles
                    det_text_bbox_max_height_expand_ratio=0.05, # super narrow, less faulty line jumbles
                )

                if result_text:
                    final_text = result_text.strip()
                    copy_to_clipboard(final_text)
                    notify("Pix2Text OCR", "Copied!", "normal")

                if os.path.exists(filename):
                    os.remove(filename)

            except Exception as e:
                notify("Pix2Text OCR Failed", str(e), "critical")


if __name__ == "__main__":
    main()
