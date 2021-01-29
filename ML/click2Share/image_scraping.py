import os

import requests
import wget
from bs4 import BeautifulSoup

# DO NOT RUN

# Same as the image scraping file in Click 2 Cook.
# Scrapes 100 images, 20 at a time into the folder called Images and converts it into jpg format


def download_file(count):
    for i in parser.find_all("img", class_="t0fcAb"):
        filename = str(path + "\\" + category + "\\" + str(count))
        src = i["src"]
        file = wget.download(url=src, out=filename)
        count += 1


def rename_file():
    for _, filename in enumerate(os.listdir(temppath)):
        dst = temppath + "\\" + filename + ".jpg"
        src = temppath + "\\" + filename
        os.rename(src, dst)


if __name__ == "__main__":
    results = requests.get(
        "https://www.google.com/search?q=noodles+images+homemade&tbm=isch&chips=q:noodles+homemade,g_1:indian:UtFAm6vhPys%3D&hl=en&sa=X&ved=2ahUKEwjvh4mypsDuAhVRmUsFHTbaD-kQ4lYoAHoECAEQGA&biw=1522&bih=731"
    ).content

    parser = BeautifulSoup(results, "html.parser")

    path = "Images"
    category = "Noodles"
    temppath = str(path + "\\" + category)

    # download_file(count=81)
    rename_file()
