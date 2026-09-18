import pandas as pd
import joblib

from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score, classification_report

df = pd.read_csv("data/heart.csv")

print("Dataset Loaded!")
print("Dataset shape:", df.shape)


X = df.drop("target", axis=1)
Y = df["target"]


X_train, X_test, Y_train, Y_test = train_test_split(
    X,
    Y,
    test_size=0.20,
    random_state=42,
    stratify=Y
)

model = RandomForestClassifier(
    n_estimators=300,
    random_state=42,
    class_weight="balanced"
)

print("Training model...")

model.fit(X_train, Y_train)

print("Training Complete!")


predictions = model.predict(X_test)

accuracy = accuracy_score(
    Y_test,
    predictions
)

print("Accuracy:", accuracy)

print("\nClassification Report:")
print(
    classification_report(
        Y_test,
        predictions
    )
)

joblib.dump(
    model,
    "models/heart_model.joblib"
)

print("\nModel Saved Successfully!")
print("Location: models/heart_model.joblib")

