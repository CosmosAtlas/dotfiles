#!/usr/bin/env python

from PyPDF2 import PdfFileWriter, PdfFileReader
import sys

if len(sys.argv) != 2:
    print('No input file')
    sys.exit()

with open(sys.argv[1], 'rb') as f:
    pdf_reader = PdfFileReader(f)
    out = PdfFileWriter()

    page_num = pdf_reader.getNumPages()
    print("Document has %s pages." % page_num)

    for i in range(page_num):
        page = pdf_reader.getPage(i)
        page.trimBox.lowerLeft = (25, 50)
        page.trimBox.upperRight = (570, 792)
        page.cropBox.lowerLeft = (25, 50)
        page.cropBox.upperRight = (570, 792)
        out.addPage(page)

    with open("out.pdf", "wb") as f:
        out.write(f)
