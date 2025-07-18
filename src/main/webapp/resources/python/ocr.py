from PIL import Image
from pytesseract import *
import pytesseract
pytesseract.pytesseract.tesseract_cmd = r'C:\Program Files\Tesseract-OCR\tesseract.exe'

filename = 'src/main/webapp/resources/image/picture3.png'
image = Image.open(filename)

text = image_to_string(image, lang='kor+eng')
print(text)
