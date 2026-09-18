import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

sys.path.insert(0, str(ROOT / "src"))

from health_assessment import assess_health




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




assessment = assess_health(
    heart_patient,
    stroke_patient
)



print("\n==========================================")
print("        COMBINED HEALTH ASSESSMENT")
print("==========================================")


print("\nHEART")
print("------------------------------------------")

print(
    "Assessment:",
    assessment["heart"]["assessment"]
)

print(
    f"Model score: "
    f"{assessment['heart']['score'] * 100:.2f}%"
)


print("\nSTROKE")
print("------------------------------------------")

print(
    "Assessment:",
    assessment["stroke"]["assessment"]
)

print(
    f"Model score: "
    f"{assessment['stroke']['score'] * 100:.2f}%"
)


print("\nOVERALL")
print("------------------------------------------")

print(
    assessment["overall"]
)


print("\n==========================================")
print("             TEST COMPLETE")
print("==========================================")