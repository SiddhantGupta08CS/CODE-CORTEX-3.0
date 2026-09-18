import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

sys.path.insert(0, str(ROOT / "src"))

from predict import predict_heart, predict_stroke




heart_patient = {
    "age": 52,
    "sex": 1,
    "cp": 1,
    "trestbps": 130,
    "chol": 220,
    "fbs": 0,
    "restecg": 1,
    "thalach": 150,
    "exang": 0,
    "oldpeak": 1.0,
    "slope": 1,
    "ca": 0,
    "thal": 2
}


stroke_patient = {
    "gender": "Male",
    "age": 52,
    "hypertension": 0,
    "heart_disease": 0,
    "ever_married": "Yes",
    "work_type": "Private",
    "Residence_type": "Urban",
    "avg_glucose_level": 110.0,
    "bmi": 25.0,
    "smoking_status": "never smoked"
}




heart_prediction, heart_probability = predict_heart(
    heart_patient
)



stroke_prediction, stroke_probability = predict_stroke(
    stroke_patient
)




print("\n==========================================")
print("          HEALTH AI TEST")
print("==========================================")

print("\nHEART MODEL")
print("------------------------------------------")

print(
    f"Prediction: {heart_prediction}"
)

print(
    f"Model score: {heart_probability * 100:.2f}%"
)


print("\nSTROKE MODEL")
print("------------------------------------------")

print(
    f"Prediction: {stroke_prediction}"
)

print(
    f"Model score: {stroke_probability * 100:.2f}%"
)


print("\n==========================================")
print("             TEST COMPLETE")
print("==========================================")