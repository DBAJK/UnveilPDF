import fitz  # PyMuPDF

def is_pdf_image_based(file_path):
    try:
        doc = fitz.open(file_path)
        for page_num in range(len(doc)):
            page = doc[page_num]
            images = page.get_images(full=True)
            if images:  # 이미지가 객체가 하나라도 있으면 OCR 필요
                print(f"이미지 객체 감지됨 (페이지 {page_num + 1}) → OCR 대상")
                return True
        print("이미지 없음 → 텍스트 기반 PDF로 판단됨")
        return False
    except Exception as e:
        print(f"오류: {e}")
        return True  

# 사용 예시
pdf_path = r"C:\Users\admin\Downloads\2023531014_김재경_PBL+OJT+회의록(9주차).pdf" # 파일 경로 가져오기
is_image = is_pdf_image_based(pdf_path)
print("OCR 대상인가?", is_image)
