import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransportationPage extends StatefulWidget {
  final TextEditingController controller4;
  final TextEditingController controller5;
  final TextEditingController controller6;

  TransportationPage({Key? key, required this.controller4, required this.controller5, required this.controller6}) : super(key: key);

  @override
  _TransportationPageState createState() => _TransportationPageState();
}


class _TransportationPageState extends State<TransportationPage> {
  late TextEditingController _controller4;
  late TextEditingController _controller5;
  late TextEditingController _controller6;
  late SharedPreferences _prefs;
  bool _prefsInitialized = false;
  String carbonFootprintResult = ""; // To display carbon footprint calculation results.

  @override
  void initState() {
    super.initState();
    _controller4 = TextEditingController();
    _controller5 = TextEditingController();
    _controller6 = TextEditingController();
    _initializePrefs();
  }

  _initializePrefs() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _prefsInitialized = true;
    });
  }

  _loadSavedData() {
    if (!_prefsInitialized) return; // Check if _prefs has been initialized
    setState(() {
      _controller4.text = _prefs.getString('transportation_q4') ?? '';
      _controller5.text = _prefs.getString('transportation_q5') ?? '';
      _controller6.text = _prefs.getString('transportation_q6') ?? '';
    });
  }

  _saveData(String key, String value) {
    _prefs.setString(key, value);
  }

  @override
  void dispose() {
    _controller4.dispose();
    _controller5.dispose();
    _controller6.dispose();
    super.dispose();
  }

  void calculateCarbonFootprint() {
    double q4 = double.tryParse(_controller4.text) ?? 0;
    double q5 = double.tryParse(_controller5.text) ?? 0;
    double q6 = double.tryParse(_controller6.text) ?? 0;
    double result = (q4 * 36) + (q5 * 69) + (q6 * 270);
    String formattedResult = result.toStringAsFixed(2);
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

  @override
  Widget build(BuildContext context) {
    _loadSavedData(); // Call loadSavedData here
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildQuestion("How many kilometers did you travel by subway today?", _controller4, 'transportation_q4'),
            buildQuestion("How many kilometers did you travel by bus today?", _controller5, 'transportation_q5'),
            buildQuestion("How many kilometers did you travel by private car today?", _controller6, 'transportation_q6'),
            SizedBox(height: 30),
            
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
}
