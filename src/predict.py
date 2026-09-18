import joblib
import pandas as pd


# Load the trained heart disease model
model = joblib.load("models/heart_model.joblib")


def predict_heart(patient):

    # Convert patient dictionary into a DataFrame
    data = pd.DataFrame([patient])

    # Get prediction
    prediction = model.predict(data)[0]

    # Get probability for class 1
    probability = model.predict_proba(data)[0][1]

    return prediction, probability



