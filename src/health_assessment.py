from predict import predict_heart, predict_stroke


def assess_health(heart_patient, stroke_patient):
    """
    Run both health models and return a combined assessment.
    """

   

    heart_prediction, heart_probability = predict_heart(
        heart_patient
    )



    stroke_prediction, stroke_probability = predict_stroke(
        stroke_patient
    )



    if heart_prediction == 1:
        heart_assessment = "Higher model-estimated risk category"
    else:
        heart_assessment = "Lower model-estimated risk category"


    if stroke_prediction == 1:
        stroke_assessment = "Higher model-estimated risk category"
    else:
        stroke_assessment = "Lower model-estimated risk category"


    

    if heart_prediction == 1 or stroke_prediction == 1:

        overall_assessment = (
            "One or more models returned a higher "
            "model-estimated risk category."
        )

    else:

        overall_assessment = (
            "The models returned lower "
            "model-estimated risk categories."
        )


  

    return {
        "heart": {
            "prediction": int(heart_prediction),
            "score": float(heart_probability),
            "assessment": heart_assessment
        },

        "stroke": {
            "prediction": int(stroke_prediction),
            "score": float(stroke_probability),
            "assessment": stroke_assessment
        },

        "overall": overall_assessment
    }