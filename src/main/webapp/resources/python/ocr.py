import sys
import pytesseract
from pdf2image import convert_from_path
from pathlib import Path
import sys
import re


def run_ocr_on_pdf(pdf_path):
    try:
        if not Path(pdf_path).is_file():
            print(f"[ERROR] 파일이 존재하지 않음: {pdf_path}")
            return

        print(f"[INFO] PDF 파일 변환 중: {pdf_path}")
        images = convert_from_path(pdf_path, dpi=300, poppler_path=r"D:\\tools\\poppler-24.08.0\\Library\bin")

        ocr = ""
        for i, image in enumerate(images):
            print(f"[INFO] 페이지 {i + 1} OCR 처리 중...")
            text = pytesseract.image_to_string(image, lang='eng+kor')
            ocr += f"\n--- Page {i + 1} ---\n{text}"
            text = re.sub(r'[^\x00-\x7F가-힣\s]', '', text)
            sys.stdout.reconfigure(encoding='utf-8')
        print(ocr)
    except Exception as e:
        print(f"[ERROR] OCR 처리 중 예외 발생: {e}")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("사용법: python ocr_script.py <PDF_파일_경로>")
    else:
        result = run_ocr_on_pdf(sys.argv[1])
        print(result) 