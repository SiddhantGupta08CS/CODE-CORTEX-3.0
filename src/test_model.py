import sys
from pathlib import Path

# Add project root and src to Python's search path
ROOT = Path(__file__).resolve().parents[1]

sys.path.insert(0, str(ROOT))
sys.path.insert(0, str(ROOT / "src"))

from predict import predict_heart
from reports.report_generator import generate_report

patient = {
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

prediction, probability = predict_heart(patient)


print("\n==============================")
print("AI MODEL RESULT")
print("==============================")

print("Prediction:", prediction)
print(
    "Model score:",
    f"{probability * 100:.2f}%"
)

report = generate_report(
    patient,
    prediction,
    probability
)

print(report)

report_path = ROOT / "patient_report.txt"

with open(report_path, "w") as file:
    file.write(report)


print("\nReport saved to:")
print(report_path)