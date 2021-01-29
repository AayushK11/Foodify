import cv2
import numpy as np
from sklearn.datasets import load_files
from sklearn.model_selection import train_test_split
from keras.utils.np_utils import to_categorical as tcg

# AUTO CALLED FROM MODEL_GENERATION

# Load Dataset takes the path as an input and returns 3 lists -> Image path, Target Label, Target Index
# File to Image converts each path to an image and resizes to 48x48. -> Returns Image List
# Input Handler converts image list to array and converts it to float32 and divides pixels by 32
# Output Handler converts target index to array and performs one hot encoding


def load_dataset(path):
    data = load_files(path)
    filenames = np.array(data["filenames"])
    target = np.array(data["target"])
    target_label = np.array(data["target_names"])
    return filenames, target, target_label


def file_to_image(input_array):
    images = []
    for file in input_array:
        image = cv2.imread(filename=file)
        image = cv2.resize(image, (48, 48), interpolation=cv2.INTER_AREA)
        images.append(image)
    return images


def input_handler(xtr, xte):
    xtr = np.array(xtr)
    xte = np.array(xte)

    xtr = xtr.astype("float32") / 32
    xte = xte.astype("float32") / 32

    return xtr, xte


def output_handler(ytr, yte):
    ytr = np.array(ytr)
    yte = np.array(yte)

    ytr = tcg(ytr)
    yte = tcg(yte)

    return ytr, yte


def preprocess_handler():
    filenames, targets, target_label = load_dataset("Images")
    xtr, xte, ytr, yte = train_test_split(filenames, targets)

    xtr = file_to_image(xtr)
    xte = file_to_image(xte)

    xtr, xte = input_handler(xtr, xte)
    ytr, yte = output_handler(ytr, yte)

    return xtr, ytr, xte, yte


preprocess_handler()