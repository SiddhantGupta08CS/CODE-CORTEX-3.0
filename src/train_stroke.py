import pandas as pd
import joblib

from pathlib import Path

from sklearn.model_selection import train_test_split
from sklearn.compose import ColumnTransformer
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import OneHotEncoder
from sklearn.impute import SimpleImputer
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import (
    accuracy_score,
    classification_report,
    confusion_matrix,
    roc_auc_score,
    average_precision_score
)

ROOT = Path(__file__).resolve().parents[1]

DATA_PATH = ROOT / "data" / "stroke_prediction.csv"

MODEL_PATH = ROOT / "models" / "stroke_model.joblib"

print("Loading stroke dataset...")

df = pd.read_csv(DATA_PATH)

print(f"Dataset shape: {df.shape}")

if "id" in df.columns:
    df = df.drop(columns=["id"])


target_column = "stroke"

X = df.drop(columns=[target_column])
y = df[target_column]

categorical_columns = X.select_dtypes(
    include=["object"]
).columns.tolist()

numerical_columns = X.select_dtypes(
    exclude=["object"]
).columns.tolist()


print("\nCategorical columns:")
print(categorical_columns)

print("\nNumerical columns:")
print(numerical_columns)

numerical_pipeline = Pipeline(
    steps=[
        ("imputer", SimpleImputer(strategy="median"))
    ]
)


categorical_pipeline = Pipeline(
    steps=[
        ("imputer", SimpleImputer(strategy="most_frequent")),
        ("encoder", OneHotEncoder(
            handle_unknown="ignore",
            sparse_output=False
        ))
    ]
)


preprocessor = ColumnTransformer(
    transformers=[
        (
            "numerical",
            numerical_pipeline,
            numerical_columns
        ),
        (
            "categorical",
            categorical_pipeline,
            categorical_columns
        )
    ]
)


model = RandomForestClassifier(
    n_estimators=400,
    class_weight="balanced",
    random_state=42,
    n_jobs=-1
)


pipeline = Pipeline(
    steps=[
        ("preprocessor", preprocessor),
        ("model", model)
    ]
)

X_train, X_test, y_train, y_test = train_test_split(
    X,
    y,
    test_size=0.20,
    random_state=42,
    stratify=y
)


print("\nTraining model...")

pipeline.fit(X_train, y_train)


y_pred = pipeline.predict(X_test)

y_probability = pipeline.predict_proba(X_test)[:, 1]

accuracy = accuracy_score(y_test, y_pred)

roc_auc = roc_auc_score(
    y_test,
    y_probability
)

average_precision = average_precision_score(
    y_test,
    y_probability
)

confusion = confusion_matrix(
    y_test,
    y_pred
)


print("\n==========================================")
print("          STROKE MODEL RESULTS")
print("==========================================")

print(f"\nAccuracy: {accuracy:.4f}")

print(f"ROC-AUC: {roc_auc:.4f}")

print(
    f"Average Precision: {average_precision:.4f}"
)

print("\nConfusion Matrix:")
print(confusion)

print("\nClassification Report:")
print(
    classification_report(
        y_test,
        y_pred,
        zero_division=0
    )
)

MODEL_PATH.parent.mkdir(
    parents=True,
    exist_ok=True
)

joblib.dump(
    pipeline,
    MODEL_PATH
)


print("\n==========================================")
print("Model saved successfully!")
print("==========================================")

print(f"\nSaved to:")
print(MODEL_PATH)