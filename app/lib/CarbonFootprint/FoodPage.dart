import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FoodPage extends StatefulWidget {
  final TextEditingController controller10;
  final TextEditingController controller11;
  final TextEditingController controller12;

  FoodPage({Key? key, required this.controller10, required this.controller11, required this.controller12}) : super(key: key);

  @override
  _FoodPageState createState() => _FoodPageState();
}


class _FoodPageState extends State<FoodPage> {
  late TextEditingController _controller10;
  late TextEditingController _controller11;
  late TextEditingController _controller12;
  late SharedPreferences _prefs;
  bool _prefsInitialized = false;
  String carbonFootprintResult = ""; // To display carbon footprint calculation results.

  @override
  void initState() {
    super.initState();
    _controller10 = TextEditingController();
    _controller11 = TextEditingController();
    _controller12 = TextEditingController();
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
      _controller10.text = _prefs.getString('Food_q10') ?? '';
      _controller11.text = _prefs.getString('Food_q11') ?? '';
      _controller12.text = _prefs.getString('Food_q12') ?? '';
    });
  }

  _saveData(String key, String value) {
    _prefs.setString(key, value);
  }

  @override
  void dispose() {
    _controller10.dispose();
    _controller11.dispose();
    _controller12.dispose();
    super.dispose();
  }

  void calculateCarbonFootprint() {
    double q10 = double.tryParse(_controller10.text) ?? 0;
    double q11 = double.tryParse(_controller11.text) ?? 0;
    double q12 = double.tryParse(_controller12.text) ?? 0;
    double result = (q10 * 2) + (q11 * 36.4) + (q12 * 220);
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
            buildQuestion("How many grams of food did you eat today?", _controller10, 'Food_q10'),
            buildQuestion("How many grams of meat did you eat today?", _controller11, 'Food_q11'),
            buildQuestion("How many bottles of beer did you drink today?", _controller12, 'Food_q12'),
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
