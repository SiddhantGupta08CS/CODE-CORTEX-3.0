from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import sys
from pathlib import Path




ROOT = Path(__file__).resolve().parents[1]

sys.path.insert(0, str(ROOT / "src"))


from health_assessment import assess_health




app = FastAPI(
    title="Cardio Guardian",
    description="AI-based health assessment API",
    version="1.0"
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=False,
    allow_methods=["*"],
    allow_headers=["*"],
)



class PatientData(BaseModel):

    # Common information
    age: int

    # Stroke information
    gender: str
    hypertension: int
    heart_disease: int
    ever_married: str
    work_type: str
    Residence_type: str
    avg_glucose_level: float
    bmi: float
    smoking_status: str

    # Heart information
    sex: int
    cp: int
    trestbps: float
    chol: float
    fbs: int
    restecg: int
    thalach: float
    exang: int
    oldpeak: float
    slope: int
    ca: int
    thal: int




@app.get("/")
def home():

    return {
        "message": "Health AI API is running"
    }



@app.post("/assess")
def assess(patient: PatientData):

    # Convert API input into heart model format

    heart_patient = {

        "age": patient.age,
        "sex": patient.sex,
        "cp": patient.cp,
        "trestbps": patient.trestbps,
        "chol": patient.chol,
        "fbs": patient.fbs,
        "restecg": patient.restecg,
        "thalach": patient.thalach,
        "exang": patient.exang,
        "oldpeak": patient.oldpeak,
        "slope": patient.slope,
        "ca": patient.ca,
        "thal": patient.thal
    }


    # Convert API input into stroke model format

    stroke_patient = {

        "gender": patient.gender,
        "age": patient.age,
        "hypertension": patient.hypertension,
        "heart_disease": patient.heart_disease,
        "ever_married": patient.ever_married,
        "work_type": patient.work_type,
        "Residence_type": patient.Residence_type,
        "avg_glucose_level": patient.avg_glucose_level,
        "bmi": patient.bmi,
        "smoking_status": patient.smoking_status
    }


    # Run both models

    result = assess_health(
        heart_patient,
        stroke_patient
    )


    return result