import joblib
import pandas as pd
from pathlib import Path




ROOT = Path(__file__).resolve().parents[1]

HEART_MODEL_PATH = ROOT / "models" / "heart_model.joblib"
STROKE_MODEL_PATH = ROOT / "models" / "stroke_model.joblib"




heart_model = joblib.load(HEART_MODEL_PATH)
stroke_model = joblib.load(STROKE_MODEL_PATH)




def predict_heart(patient):
    """
    Predict heart disease risk category.

    Returns:
        prediction: 0 or 1
        probability: model-estimated probability
    """

    data = pd.DataFrame([patient])

    prediction = heart_model.predict(data)[0]

    probability = heart_model.predict_proba(data)[0][1]

    return prediction, probability



def predict_stroke(patient):
    """
    Predict stroke risk category.

    Returns:
        prediction: 0 or 1
        probability: model-estimated probability
    """

    data = pd.DataFrame([patient])

    prediction = stroke_model.predict(data)[0]

    probability = stroke_model.predict_proba(data)[0][1]

    return prediction, probability