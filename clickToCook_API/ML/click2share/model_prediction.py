from keras.models import model_from_json
import numpy as np
import cv2
import os
from django.conf import settings

os.environ["TF_CPP_MIN_LOG_LEVEL"] = "3"


BASE_DIR = settings.BASE_DIR

# from data_pre_process import *

# Load Model                -> Loads Model and Weights
# Load Image                -> Reads Image from the path
# Predict                   -> Resizes Image to 48x48, divides pixels by 32, and predicts
# Model Prediction Handler  -> Handles the Module
# Classes Available         -> ['Burger', 'Noodles', 'Pav Bhaji', 'Pizza', 'Rice', 'Sandwich']


def load_model():
    json_file = open(BASE_DIR / "ML" / "click2share" / "Model" /
                     "CNN_Model.json", "r")
    loaded_model_json = json_file.read()
    json_file.close()
    model = model_from_json(loaded_model_json)
    model.load_weights(BASE_DIR / "ML" / "click2share" / "Model" /
                       "CNN_Weights.h5")
    return model


def load_image(path):
    image = cv2.imread(path)
    return image


def predict(model, image):
    requiredsize = (48, 48)
    image = cv2.resize(image, requiredsize, interpolation=cv2.INTER_AREA)

    image = image.astype("float32") / 32
    image = image.reshape(-1, 48, 48, 3)

    output = model.predict(image)
    index = np.argmax(output)
    confidence = output[0][index] * 100

    return index, confidence


# def model_prediction_handler():
#     model = load_model()
#     tlab = ["Burger", "Noodles", "Pav Bhaji", "Pizza", "Rice", "Sandwich"]

#     for i in os.listdir("Private Test"):
#         path = os.path.join("Private Test", i)
#         image = load_image(path)
#         index, confidence = predict(model, image)
#         print(i, tlab[index], "%.2f" % confidence)


def predict_img(img):
    tlab = ["Burger", "Noodles", "Pav Bhaji", "Pizza", "Rice", "Sandwich"]
    model = load_model()
    image = load_image(img)
    index, confidence = predict(model, image)
    print(">>> Confidence: " + "%.2f" % confidence)
    return tlab[index]


# model_prediction_handler()
