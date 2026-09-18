from datetime import datetime

def generate_report(patient, prediction, probability):

    if prediction == 1:
        assessment = "Higher model-estimated risk category"
    else:
        assessment = "Lower model-estimated risk category"

    report = f"""
==================================================
              AI HEALTH ASSESSMENT
==================================================

Generated:
{datetime.now().strftime("%d-%m-%Y %H:%M")}


PATIENT INFORMATION
--------------------------------------------------

Age: {patient["age"]}
Sex: {patient["sex"]}


CARDIOVASCULAR MODEL ASSESSMENT
--------------------------------------------------

Model assessment:
{assessment}

Model score:
{probability * 100:.2f}%


INPUT PARAMETERS
--------------------------------------------------

Chest-pain type: {patient["cp"]}
Resting blood pressure: {patient["trestbps"]}
Cholesterol: {patient["chol"]}
Fasting blood sugar: {patient["fbs"]}
Resting ECG: {patient["restecg"]}
Maximum heart rate: {patient["thalach"]}
Exercise-induced angina: {patient["exang"]}
ST depression: {patient["oldpeak"]}
Slope: {patient["slope"]}
Major vessels: {patient["ca"]}
Thalassemia category: {patient["thal"]}


IMPORTANT
--------------------------------------------------

This is an AI-based model assessment using the
provided dataset.

It is NOT a medical diagnosis and should not be
used by itself to make treatment decisions.

Professional medical evaluation should be sought
when appropriate.


EMERGENCY SUPPORT
--------------------------------------------------

If the patient experiences an actual emergency,
activate the application's SOS workflow and seek
professional emergency assistance.

==================================================
                 END OF REPORT
==================================================
"""

    return report