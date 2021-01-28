import os
import requests
import wget
from bs4 import BeautifulSoup

# NOT TO BE USED
# Download File -   Downloads all the images in link and saves them in File format
# Rename File   -   Renames every file in the directory to .jpg format

# Requires Link containing images and folder name
# Outputs .jpg images


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
        "https://www.google.com/search?q=strawberry+images+fresh&tbm=isch&ved=2ahUKEwiqvL2R_73uAhWpS30KHQ32AmwQ2-cCegQIABAA&oq=strawberry+images+fresh&gs_lcp=CgNpbWcQAzIGCAAQCBAeMgYIABAIEB46AggAOgQIABBDUKEXWK8fYP8haABwAHgAgAGHAYgB2wWSAQMwLjaYAQCgAQGqAQtnd3Mtd2l6LWltZ8ABAQ&sclient=img&ei=t1gSYOqEBKmX9QON7IvgBg&bih=731&biw=1536"
    ).content

    parser = BeautifulSoup(results, "html.parser")

    path = "Images"
    category = "Strawberry"
    temppath = str(path + "\\" + category)

    # download_file(count=81)
    rename_file()
