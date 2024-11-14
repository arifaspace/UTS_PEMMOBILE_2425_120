import 'package:flutter/material.dart';

class BMIPage extends StatefulWidget {
  @override
  _BMIPageState createState() => _BMIPageState();
}

class _BMIPageState extends State<BMIPage> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  String result = "";
  String bmiCategory = "";
  double bmi = 0.0;

  String? gender = "Male"; // Default gender to Male

  void _calculateBMI() {
    double height =
        double.parse(heightController.text) / 100; // Convert height to meters
    double weight = double.parse(weightController.text);
    bmi = weight / (height * height);

    // Determine BMI category
    if (bmi < 18.5) {
      bmiCategory = "Underweight";
    } else if (bmi >= 18.5 && bmi < 24.9) {
      bmiCategory = "Normal weight";
    } else if (bmi >= 25 && bmi < 29.9) {
      bmiCategory = "Overweight";
    } else {
      bmiCategory = "Obesity";
    }

    setState(() {
      result = "BMI: ${bmi.toStringAsFixed(2)}\nCategory: $bmiCategory";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI Calculator"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Return to dashboard
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Radio button for gender selection
            Row(
              children: [
                Text("Select Gender: "),
                Radio<String>(
                  value: "Male",
                  groupValue: gender,
                  onChanged: (String? value) {
                    setState(() {
                      gender = value;
                    });
                  },
                ),
                Text("Male"),
                Radio<String>(
                  value: "Female",
                  groupValue: gender,
                  onChanged: (String? value) {
                    setState(() {
                      gender = value;
                    });
                  },
                ),
                Text("Female"),
              ],
            ),
            // Input height in cm
            TextField(
              controller: heightController,
              decoration: InputDecoration(labelText: 'Enter height (cm)'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            // Input weight
            TextField(
              controller: weightController,
              decoration: InputDecoration(labelText: 'Enter weight (kg)'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 20),
            // Button to calculate BMI
            ElevatedButton(
              onPressed: _calculateBMI,
              child: Text("Calculate BMI"),
            ),
            SizedBox(height: 20),
            // Displaying BMI result
            Text(
              result,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
