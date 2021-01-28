import os

os.environ["TF_CPP_MIN_LOG_LEVEL"] = "3"
from data_pre_processing import *
import matplotlib.pyplot as plt
from keras.layers.convolutional import Conv2D, MaxPooling2D
from tensorflow.keras.layers import BatchNormalization, Dense, Dropout, Flatten
from tensorflow.keras.models import Sequential


def create_model(xtr, ytr, xte, yte):
    model = Sequential()

    model.add(BatchNormalization())
    model.add(Conv2D(filters=32, kernel_size=(3, 3), padding="Same", activation="relu"))
    model.add(MaxPooling2D(pool_size=(3, 3)))
    model.add(Dropout(0.5))

    model.add(BatchNormalization())
    model.add(Conv2D(filters=64, kernel_size=(3, 3), padding="Same", activation="relu"))
    model.add(MaxPooling2D(pool_size=(4, 4)))
    model.add(Dropout(0.35))

    model.add(Flatten())
    model.add(Dense(128, activation="relu"))
    model.add(Dropout(0.35))
    model.add(Dense(yte.shape[1], activation="softmax"))

    model.compile(
        optimizer="Adam", loss="categorical_crossentropy", metrics=["accuracy"]
    )

    history = model.fit(
        x=xtr, y=ytr, batch_size=16, epochs=500, validation_data=(xte, yte)
    )

    model.evaluate(xte, yte)

    plot_graph(history)

    model_json = model.to_json()
    with open("Model/CNN_Model.json", "w") as json_file:
        json_file.write(model_json)
    model.save_weights("Model/CNN_Weights.h5")


def plot_graph(history):
    plt.plot(history.history["loss"])
    plt.plot(history.history["val_loss"])
    plt.legend(["Train", "Test"], loc="upper left")
    plt.title("Model Loss Graph - Click 2 Cook")
    plt.xlabel("Epochs")
    plt.ylabel("Loss")
    plt.savefig("Model/CNN_Loss.png")
    plt.close()

    plt.plot(history.history["accuracy"])
    plt.plot(history.history["val_accuracy"])
    plt.legend(["Train", "Test"], loc="upper left")
    plt.title("Model Accuracy Graph - Click 2 Cook")
    plt.xlabel("Epochs")
    plt.ylabel("Accuracy")
    plt.savefig("Model/CNN_Accuracy.png")
    plt.close()


if __name__ == "__main__":
    xtr, ytr, xte, yte = preprocess_handler()
    create_model(xtr, ytr, xte, yte)