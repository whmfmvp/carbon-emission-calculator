import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsagePage extends StatefulWidget {
  final TextEditingController controller1;
  final TextEditingController controller2;
  final TextEditingController controller3;
  final TextEditingController controller4;
  final TextEditingController controller5;
  final TextEditingController controller6;

  UsagePage({
    Key? key,
    required this.controller1,
    required this.controller2,
    required this.controller3,
    required this.controller4,
    required this.controller5,
    required this.controller6,
  }) : super(key: key);

  @override
  _UsagePageState createState() => _UsagePageState();
}

class _UsagePageState extends State<UsagePage> {
  late SharedPreferences _prefs;
  bool _prefsInitialized = false;
  String carbonFootprintResult = ""; // To display carbon footprint calculation results.

  @override
  void initState() {
    super.initState();
    _initializePrefs();
  }

  _initializePrefs() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _prefsInitialized = true;
      _loadSavedData(); // Call loadSavedData here
    });
  }

  _loadSavedData() {
    if (!_prefsInitialized) return; // Check if _prefs has been initialized
    setState(() {
      widget.controller1.text = _prefs.getString('usage_q1') ?? '';
      widget.controller2.text = _prefs.getString('usage_q2') ?? '';
      widget.controller3.text = _prefs.getString('usage_q3') ?? '';
      widget.controller4.text = _prefs.getString('transportation_q4') ?? '';
      widget.controller5.text = _prefs.getString('transportation_q5') ?? '';
      widget.controller6.text = _prefs.getString('transportation_q6') ?? '';

      // Add debug prints to check if values are set correctly
      print("controller1: ${widget.controller1.text}");
      print("controller2: ${widget.controller2.text}");
      print("controller3: ${widget.controller3.text}");
      print("controller4: ${widget.controller4.text}");
      print("controller5: ${widget.controller5.text}");
      print("controller6: ${widget.controller6.text}");
    });
  }

  _saveData(String key, String value) {
    _prefs.setString(key, value);
  }

  @override
  Widget build(BuildContext context) {
    if (!_prefsInitialized) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildQuestion("How many plastic bags did you use?", widget.controller1, 'usage_q1'),
            buildQuestion("How many sets of disposable tableware did you use?", widget.controller2, 'usage_q2'),
            buildQuestion("How many grams of paper products did you use?", widget.controller3, 'usage_q3'),
            SizedBox(height: 30),
            // Button for last page
            buildButton("Last Page", Colors.grey, () => Navigator.pop(context)),
            SizedBox(height: 10), // Space between the buttons
            // Button to calculate the carbon footprint
            buildButton("Calculate Your Carbon Footprint", Colors.green, calculateCarbonFootprint),
            if (carbonFootprintResult.isNotEmpty) Text(carbonFootprintResult),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildQuestion(String question, TextEditingController controller, String prefsKey) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(question, style: TextStyle(fontSize: 16)),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          onChanged: (value) => _saveData(prefsKey, value),
          decoration: InputDecoration(
              border: OutlineInputBorder(), hintText: 'Enter your answer here'),
        ),
        SizedBox(height: 20), // Adds space between questions
      ],
    );
  }

  Widget buildButton(String text, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: StadiumBorder(), // Rounded edges
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Padding inside button
      ),
    );
  }

  void calculateCarbonFootprint() {
    double q1 = double.tryParse(widget.controller1.text) ?? 0;
    double q2 = double.tryParse(widget.controller2.text) ?? 0;
    double q3 = double.tryParse(widget.controller3.text) ?? 0;
    double q4 = double.tryParse(widget.controller4.text) ?? 0; // Access controller4, controller5, and controller6 from widget
    double q5 = double.tryParse(widget.controller5.text) ?? 0;
    double q6 = double.tryParse(widget.controller6.text) ?? 0;
    double result = (q1 * 0.1) +
        (q2 * 45.72) +
        (q3 * 3.5) +
        (q4 * 36) +
        (q5 * 69) +
        (q6 * 270);
    String formattedResult;
  if (result >= 1000) {
    double kilograms = result / 1000;
    formattedResult = "Your Carbon Footprint is ${kilograms.toStringAsFixed(2)} kilograms!";
  } else {
    formattedResult = "Your Carbon Footprint is ${result.toStringAsFixed(2)} grams!";
  }

  setState(() {
    carbonFootprintResult = formattedResult;
  });
}
}
