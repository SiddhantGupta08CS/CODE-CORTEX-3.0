import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

sys.path.insert(0, str(ROOT))
sys.path.insert(0, str(ROOT / "src"))

from health_assessment import assess_health
from reports.report_generator import generate_health_report




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



patient = {
    "age": 52,
    "gender": "Male"
}




report = generate_health_report(
    patient,
    assessment
)




print(report)




report_path = ROOT / "patient_health_report.txt"

with open(report_path, "w") as file:
    file.write(report)


print(
    f"\nReport saved to: {report_path}"
)