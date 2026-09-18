import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const HealthAIApp());
}

class HealthAIApp extends StatelessWidget {
  const HealthAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Health AI',

      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),

      home: const HomeScreen(),
    );
  }
}


// ==================================================
// HOME SCREEN
// ==================================================

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'Health AI',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              const SizedBox(height: 40),

              // --------------------------------------
              // TITLE
              // --------------------------------------

              const Text(
                'Your Health,\nIntelligently Assessed.',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'AI-powered health assessment and '
                'emergency support in one place.',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 50),

              // --------------------------------------
              // HEALTH ASSESSMENT CARD
              // --------------------------------------

              Card(
                elevation: 3,

                child: Padding(
                  padding: const EdgeInsets.all(20),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      const Icon(
                        Icons.health_and_safety,
                        size: 42,
                      ),

                      const SizedBox(height: 15),

                      const Text(
                        'Health Assessment',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        'Enter your health information '
                        'to receive model-based '
                        'assessments.',
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,

                        child: ElevatedButton(
                          onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const PatientProfileScreen(),
    ),
  );
},

                          child: const Text(
                            'Start Assessment',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              // --------------------------------------
              // DISCLAIMER
              // --------------------------------------

              const Text(
                'Health AI provides model-based '
                'assessments for demonstration and '
                'research purposes. It is not a '
                'medical diagnosis.',
                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================================================
// PATIENT PROFILE SCREEN
// ==================================================

class PatientProfileScreen extends StatefulWidget {
  const PatientProfileScreen({super.key});

  @override
  State<PatientProfileScreen> createState() =>
      _PatientProfileScreenState();
}


class _PatientProfileScreenState
    extends State<PatientProfileScreen> {

  final TextEditingController ageController =
      TextEditingController();

  String gender = "Male";

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Patient Profile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(24),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              const Text(
                "Patient Information",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Enter the patient's basic information "
                "to continue with the assessment.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 35),

              // --------------------------------------
              // AGE
              // --------------------------------------

              TextField(
                controller: ageController,

                keyboardType:
                    TextInputType.number,

                decoration: const InputDecoration(
                  labelText: "Age",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),

              const SizedBox(height: 20),

              // --------------------------------------
              // GENDER
              // --------------------------------------

              DropdownButtonFormField<String>(

                initialValue: gender,

                decoration: const InputDecoration(
                  labelText: "Gender",
                  border: OutlineInputBorder(),
                  prefixIcon:
                      Icon(Icons.people),
                ),

                items: const [

                  DropdownMenuItem(
                    value: "Male",
                    child: Text("Male"),
                  ),

                  DropdownMenuItem(
                    value: "Female",
                    child: Text("Female"),
                  ),

                  DropdownMenuItem(
                    value: "Other",
                    child: Text("Other"),
                  ),

                ],

                onChanged: (value) {

                  if (value != null) {
                    setState(() {
                      gender = value;
                    });
                  }

                },
              ),

              const SizedBox(height: 35),

              // --------------------------------------
              // CONTINUE BUTTON
              // --------------------------------------

              SizedBox(
                width: double.infinity,

                child: ElevatedButton(

                  onPressed: () {

                    if (ageController.text.isEmpty) {

                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Please enter the patient's age.",
                          ),
                        ),
                      );

                      return;
                    }

                    // We will connect this to
                    // the health information screen.

                    Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => HealthInformationScreen(
      age: int.parse(ageController.text),
      gender: gender,
    ),
  ),
);
                  },

                  child: const Padding(
                    padding: EdgeInsets.all(14),

                    child: Text(
                      "Continue",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================================================
// HEALTH INFORMATION SCREEN
// ==================================================

class HealthInformationScreen extends StatefulWidget {
  final int age;
  final String gender;

  const HealthInformationScreen({
    super.key,
    required this.age,
    required this.gender,
  });

  @override
  State<HealthInformationScreen> createState() =>
      _HealthInformationScreenState();
}


class _HealthInformationScreenState
    extends State<HealthInformationScreen> {

  // ------------------------------------------------
  // STROKE MODEL INPUTS
  // ------------------------------------------------

  String hypertension = "No";

  String heartDisease = "No";

  String everMarried = "Yes";

  String workType = "Private";

  String residenceType = "Urban";

  String smokingStatus = "never smoked";

  final TextEditingController glucoseController =
      TextEditingController(text: "110");

  final TextEditingController bmiController =
      TextEditingController(text: "25");


  // ------------------------------------------------
  // HEART MODEL INPUTS
  // ------------------------------------------------

  int sex = 1;

  int chestPainType = 1;

  final TextEditingController bloodPressureController =
      TextEditingController(text: "130");

  final TextEditingController cholesterolController =
      TextEditingController(text: "220");

  int fastingBloodSugar = 0;

  int restingECG = 1;

  final TextEditingController maxHeartRateController =
      TextEditingController(text: "150");

  int exerciseAngina = 0;

  final TextEditingController stDepressionController =
      TextEditingController(text: "1.0");

  int slope = 1;

  int majorVessels = 0;

  int thalassemia = 2;


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Health Information",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(24),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              // ======================================
              // INTRODUCTION
              // ======================================

              const Text(
                "Health Information",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Provide the available health information "
                "for the AI assessment.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 30),


              // ======================================
              // STROKE INFORMATION
              // ======================================

              const Text(
                "General Health",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),


              // Hypertension

              DropdownButtonFormField<String>(
                initialValue: hypertension,

                decoration: const InputDecoration(
                  labelText: "Hypertension",
                  border: OutlineInputBorder(),
                ),

                items: const [

                  DropdownMenuItem(
                    value: "No",
                    child: Text("No"),
                  ),

                  DropdownMenuItem(
                    value: "Yes",
                    child: Text("Yes"),
                  ),

                ],

                onChanged: (value) {

                  if (value != null) {

                    setState(() {
                      hypertension = value;
                    });

                  }

                },
              ),

              const SizedBox(height: 16),


              // Heart disease

              DropdownButtonFormField<String>(
                initialValue: heartDisease,

                decoration: const InputDecoration(
                  labelText: "Previous Heart Disease",
                  border: OutlineInputBorder(),
                ),

                items: const [

                  DropdownMenuItem(
                    value: "No",
                    child: Text("No"),
                  ),

                  DropdownMenuItem(
                    value: "Yes",
                    child: Text("Yes"),
                  ),

                ],

                onChanged: (value) {

                  if (value != null) {

                    setState(() {
                      heartDisease = value;
                    });

                  }

                },
              ),

              const SizedBox(height: 16),


              // Ever married

              DropdownButtonFormField<String>(
                initialValue: everMarried,

                decoration: const InputDecoration(
                  labelText: "Ever Married",
                  border: OutlineInputBorder(),
                ),

                items: const [

                  DropdownMenuItem(
                    value: "Yes",
                    child: Text("Yes"),
                  ),

                  DropdownMenuItem(
                    value: "No",
                    child: Text("No"),
                  ),

                ],

                onChanged: (value) {

                  if (value != null) {

                    setState(() {
                      everMarried = value;
                    });

                  }

                },
              ),

              const SizedBox(height: 16),


              // Work type

              DropdownButtonFormField<String>(
                initialValue: workType,

                decoration: const InputDecoration(
                  labelText: "Work Type",
                  border: OutlineInputBorder(),
                ),

                items: const [

                  DropdownMenuItem(
                    value: "Private",
                    child: Text("Private"),
                  ),

                  DropdownMenuItem(
                    value: "Self-employed",
                    child: Text("Self-employed"),
                  ),

                  DropdownMenuItem(
                    value: "Govt_job",
                    child: Text("Government"),
                  ),

                  DropdownMenuItem(
                    value: "children",
                    child: Text("Children"),
                  ),

                  DropdownMenuItem(
                    value: "Never_worked",
                    child: Text("Never worked"),
                  ),

                ],

                onChanged: (value) {

                  if (value != null) {

                    setState(() {
                      workType = value;
                    });

                  }

                },
              ),

              const SizedBox(height: 16),


              // Residence

              DropdownButtonFormField<String>(
                initialValue: residenceType,

                decoration: const InputDecoration(
                  labelText: "Residence Type",
                  border: OutlineInputBorder(),
                ),

                items: const [

                  DropdownMenuItem(
                    value: "Urban",
                    child: Text("Urban"),
                  ),

                  DropdownMenuItem(
                    value: "Rural",
                    child: Text("Rural"),
                  ),

                ],

                onChanged: (value) {

                  if (value != null) {

                    setState(() {
                      residenceType = value;
                    });

                  }

                },
              ),

              const SizedBox(height: 16),


              // Smoking

              DropdownButtonFormField<String>(
                initialValue: smokingStatus,

                decoration: const InputDecoration(
                  labelText: "Smoking Status",
                  border: OutlineInputBorder(),
                ),

                items: const [

                  DropdownMenuItem(
                    value: "never smoked",
                    child: Text("Never smoked"),
                  ),

                  DropdownMenuItem(
                    value: "formerly smoked",
                    child: Text("Formerly smoked"),
                  ),

                  DropdownMenuItem(
                    value: "smokes",
                    child: Text("Currently smokes"),
                  ),

                  DropdownMenuItem(
                    value: "Unknown",
                    child: Text("Unknown"),
                  ),

                ],

                onChanged: (value) {

                  if (value != null) {

                    setState(() {
                      smokingStatus = value;
                    });

                  }

                },
              ),

              const SizedBox(height: 16),


              // Glucose

              TextField(
                controller: glucoseController,

                keyboardType:
                    TextInputType.number,

                decoration: const InputDecoration(
                  labelText: "Average Glucose Level",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 16),


              // BMI

              TextField(
                controller: bmiController,

                keyboardType:
                    const TextInputType.numberWithOptions(
                      decimal: true,
                    ),

                decoration: const InputDecoration(
                  labelText: "BMI",
                  border: OutlineInputBorder(),
                ),
              ),


              const SizedBox(height: 40),


              // ======================================
              // CARDIOVASCULAR INFORMATION
              // ======================================

              const Text(
                "Cardiovascular Information",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),


              // Sex

              DropdownButtonFormField<int>(
                initialValue: sex,

                decoration: const InputDecoration(
                  labelText: "Sex",
                  border: OutlineInputBorder(),
                ),

                items: const [

                  DropdownMenuItem(
                    value: 0,
                    child: Text("Female"),
                  ),

                  DropdownMenuItem(
                    value: 1,
                    child: Text("Male"),
                  ),

                ],

                onChanged: (value) {

                  if (value != null) {

                    setState(() {
                      sex = value;
                    });

                  }

                },
              ),

              const SizedBox(height: 16),


              // Chest pain

              DropdownButtonFormField<int>(
                initialValue: chestPainType,

                decoration: const InputDecoration(
                  labelText: "Chest Pain Type",
                  border: OutlineInputBorder(),
                ),

                items: const [

                  DropdownMenuItem(
                    value: 0,
                    child: Text("Type 0"),
                  ),

                  DropdownMenuItem(
                    value: 1,
                    child: Text("Type 1"),
                  ),

                  DropdownMenuItem(
                    value: 2,
                    child: Text("Type 2"),
                  ),

                  DropdownMenuItem(
                    value: 3,
                    child: Text("Type 3"),
                  ),

                ],

                onChanged: (value) {

                  if (value != null) {

                    setState(() {
                      chestPainType = value;
                    });

                  }

                },
              ),

              const SizedBox(height: 16),


              // Blood pressure

              TextField(
                controller:
                    bloodPressureController,

                keyboardType:
                    TextInputType.number,

                decoration: const InputDecoration(
                  labelText: "Resting Blood Pressure",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 16),


              // Cholesterol

              TextField(
                controller:
                    cholesterolController,

                keyboardType:
                    TextInputType.number,

                decoration: const InputDecoration(
                  labelText: "Cholesterol",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 16),


              // Fasting blood sugar

              DropdownButtonFormField<int>(
                initialValue: fastingBloodSugar,

                decoration: const InputDecoration(
                  labelText:
                      "Fasting Blood Sugar > 120 mg/dl",
                  border: OutlineInputBorder(),
                ),

                items: const [

                  DropdownMenuItem(
                    value: 0,
                    child: Text("No"),
                  ),

                  DropdownMenuItem(
                    value: 1,
                    child: Text("Yes"),
                  ),

                ],

                onChanged: (value) {

                  if (value != null) {

                    setState(() {
                      fastingBloodSugar = value;
                    });

                  }

                },
              ),

              const SizedBox(height: 16),


              // Resting ECG

              DropdownButtonFormField<int>(
                initialValue: restingECG,

                decoration: const InputDecoration(
                  labelText: "Resting ECG",
                  border: OutlineInputBorder(),
                ),

                items: const [

                  DropdownMenuItem(
                    value: 0,
                    child: Text("Normal"),
                  ),

                  DropdownMenuItem(
                    value: 1,
                    child: Text("ST-T abnormality"),
                  ),

                  DropdownMenuItem(
                    value: 2,
                    child: Text("Other"),
                  ),

                ],

                onChanged: (value) {

                  if (value != null) {

                    setState(() {
                      restingECG = value;
                    });

                  }

                },
              ),

              const SizedBox(height: 16),


              // Maximum heart rate

              TextField(
                controller:
                    maxHeartRateController,

                keyboardType:
                    TextInputType.number,

                decoration: const InputDecoration(
                  labelText: "Maximum Heart Rate",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 16),


              // Exercise angina

              DropdownButtonFormField<int>(
                initialValue: exerciseAngina,

                decoration: const InputDecoration(
                  labelText: "Exercise-Induced Angina",
                  border: OutlineInputBorder(),
                ),

                items: const [

                  DropdownMenuItem(
                    value: 0,
                    child: Text("No"),
                  ),

                  DropdownMenuItem(
                    value: 1,
                    child: Text("Yes"),
                  ),

                ],

                onChanged: (value) {

                  if (value != null) {

                    setState(() {
                      exerciseAngina = value;
                    });

                  }

                },
              ),

              const SizedBox(height: 16),


              // ST depression

              TextField(
                controller:
                    stDepressionController,

                keyboardType:
                    const TextInputType.numberWithOptions(
                      decimal: true,
                    ),

                decoration: const InputDecoration(
                  labelText: "ST Depression",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 16),


              // Slope

              DropdownButtonFormField<int>(
                initialValue: slope,

                decoration: const InputDecoration(
                  labelText: "Slope",
                  border: OutlineInputBorder(),
                ),

                items: const [

                  DropdownMenuItem(
                    value: 0,
                    child: Text("Type 0"),
                  ),

                  DropdownMenuItem(
                    value: 1,
                    child: Text("Type 1"),
                  ),

                  DropdownMenuItem(
                    value: 2,
                    child: Text("Type 2"),
                  ),

                ],

                onChanged: (value) {

                  if (value != null) {

                    setState(() {
                      slope = value;
                    });

                  }

                },
              ),

              const SizedBox(height: 16),


              // Major vessels

              DropdownButtonFormField<int>(
                initialValue: majorVessels,

                decoration: const InputDecoration(
                  labelText: "Major Vessels",
                  border: OutlineInputBorder(),
                ),

                items: const [

                  DropdownMenuItem(
                    value: 0,
                    child: Text("0"),
                  ),

                  DropdownMenuItem(
                    value: 1,
                    child: Text("1"),
                  ),

                  DropdownMenuItem(
                    value: 2,
                    child: Text("2"),
                  ),

                  DropdownMenuItem(
                    value: 3,
                    child: Text("3"),
                  ),

                  DropdownMenuItem(
                    value: 4,
                    child: Text("4"),
                  ),

                ],

                onChanged: (value) {

                  if (value != null) {

                    setState(() {
                      majorVessels = value;
                    });

                  }

                },
              ),

              const SizedBox(height: 16),


              // Thalassemia

              DropdownButtonFormField<int>(
                initialValue: thalassemia,

                decoration: const InputDecoration(
                  labelText: "Thalassemia Category",
                  border: OutlineInputBorder(),
                ),

                items: const [

                  DropdownMenuItem(
                    value: 0,
                    child: Text("0"),
                  ),

                  DropdownMenuItem(
                    value: 1,
                    child: Text("1"),
                  ),

                  DropdownMenuItem(
                    value: 2,
                    child: Text("2"),
                  ),

                  DropdownMenuItem(
                    value: 3,
                    child: Text("3"),
                  ),

                ],

                onChanged: (value) {

                  if (value != null) {

                    setState(() {
                      thalassemia = value;
                    });

                  }

                },
              ),

              const SizedBox(height: 40),


              // ======================================
              // ANALYZE BUTTON
              // ======================================

              SizedBox(
                width: double.infinity,

                child: ElevatedButton(

                  onPressed: () async {
  try {
    final response = await http.post(
      Uri.parse("http://127.0.0.1:8000/assess"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        // -----------------------------
        // STROKE MODEL INPUTS
        // -----------------------------
        "age": widget.age,
        "gender": widget.gender,
        "hypertension": hypertension == "Yes" ? 1 : 0,
        "heart_disease": heartDisease == "Yes" ? 1 : 0,
        "ever_married": everMarried,
        "work_type": workType,
        "Residence_type": residenceType,
        "avg_glucose_level":
            double.parse(glucoseController.text),
        "bmi":
            double.parse(bmiController.text),
        "smoking_status": smokingStatus,

        // -----------------------------
        // HEART MODEL INPUTS
        // -----------------------------
        "sex": sex,
        "cp": chestPainType,
        "trestbps":
            double.parse(bloodPressureController.text),
        "chol":
            double.parse(cholesterolController.text),
        "fbs": fastingBloodSugar,
        "restecg": restingECG,
        "thalach":
            double.parse(maxHeartRateController.text),
        "exang": exerciseAngina,
        "oldpeak":
            double.parse(stDepressionController.text),
        "slope": slope,
        "ca": majorVessels,
        "thal": thalassemia,
      }),
    );

    if (response.statusCode == 200) {
  final result = jsonDecode(response.body);

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ResultsScreen(
        result: result,
      ),
    ),
  );
} else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Server error: ${response.statusCode}",
          ),
        ),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Connection error: $e"),
      ),
    );
  }
},

                  child: const Padding(
                    padding: EdgeInsets.all(14),

                    child: Text(
                      "Analyze Health",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}


// ==================================================
// RESULTS SCREEN
// ==================================================

class ResultsScreen extends StatelessWidget {
  final Map<String, dynamic> result;

  const ResultsScreen({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    final heart = result["heart"];
    final stroke = result["stroke"];
    final overall = result["overall"];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Health Assessment",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              const Text(
                "Assessment Results",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Your results are based on the trained "
                "machine-learning models.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 30),

              // --------------------------------------
              // HEART RESULT
              // --------------------------------------

              Card(
                elevation: 3,

                child: Padding(
                  padding: const EdgeInsets.all(20),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      const Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            size: 30,
                          ),

                          SizedBox(width: 12),

                          Text(
                            "Cardiovascular Assessment",
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Text(
                        heart["assessment"],
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        "Model score: "
                        "${(heart["score"] * 100).toStringAsFixed(2)}%",
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // --------------------------------------
              // STROKE RESULT
              // --------------------------------------

              Card(
                elevation: 3,

                child: Padding(
                  padding: const EdgeInsets.all(20),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      const Row(
                        children: [
                          Icon(
                            Icons.psychology,
                            size: 30,
                          ),

                          SizedBox(width: 12),

                          Text(
                            "Stroke Assessment",
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Text(
                        stroke["assessment"],
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        "Model score: "
                        "${(stroke["score"] * 100).toStringAsFixed(2)}%",
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // --------------------------------------
              // OVERALL ASSESSMENT
              // --------------------------------------

              Card(
                elevation: 3,

                child: Padding(
                  padding: const EdgeInsets.all(20),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      const Text(
                        "Overall Model Assessment",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      Text(
                        overall,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // --------------------------------------
              // DISCLAIMER
              // --------------------------------------

              const Text(
                "Important: These results are model-based "
                "assessments and are not a medical diagnosis. "
                "They should not be interpreted as definitive "
                "probabilities of developing a disease.",
                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 25),

              // --------------------------------------
              // REPORT BUTTON
              // --------------------------------------

              SizedBox(
                width: double.infinity,

                child: ElevatedButton(
                  onPressed: () {

                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Detailed report coming next!",
                        ),
                      ),
                    );

                  },

                  child: const Padding(
                    padding: EdgeInsets.all(14),

                    child: Text(
                      "View Detailed Report",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // --------------------------------------
              // SOS BUTTON
              // --------------------------------------

              SizedBox(
                width: double.infinity,

                child: OutlinedButton(
                  onPressed: () {

                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Emergency support coming next!",
                        ),
                      ),
                    );

                  },

                  child: const Padding(
                    padding: EdgeInsets.all(14),

                    child: Text(
                      "Emergency Support",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}