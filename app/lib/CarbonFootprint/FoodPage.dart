import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data_provider.dart';

class FoodPage extends StatefulWidget {
  final TextEditingController controller7;
  final TextEditingController controller8;
  final TextEditingController controller9;

  FoodPage({Key? key, required this.controller7, required this.controller8, required this.controller9}) : super(key: key);

  @override
  _FoodPageState createState() => _FoodPageState();
}


class _FoodPageState extends State<FoodPage> {
  late TextEditingController _controller7;
  late TextEditingController _controller8;
  late TextEditingController _controller9;
  late SharedPreferences _prefs;
  bool _prefsInitialized = false;
  String carbonFootprintResult = ""; // To display carbon footprint calculation results.

  @override
  void initState() {
    super.initState();
    _controller7 = TextEditingController();
    _controller8 = TextEditingController();
    _controller9 = TextEditingController();
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
      _controller7.text = _prefs.getString('Housing_q7') ?? '';
      _controller8.text = _prefs.getString('Housing_q8') ?? '';
      _controller9.text = _prefs.getString('Housing_q9') ?? '';
    });
  }

  _saveData(String key, String value) {
    _prefs.setString(key, value);
  }

  @override
  void dispose() {
    _controller7.dispose();
    _controller8.dispose();
    _controller9.dispose();
    super.dispose();
  }

  void calculateCarbonFootprint() {
    double q7 = double.tryParse(_controller7.text) ?? 0;
    double q8 = double.tryParse(_controller8.text) ?? 0;
    double q9 = double.tryParse(_controller9.text) ?? 0;
    double result = (q7 * 2) + (q8 * 36.4) + (q9 * 220);
    String formattedResult = result.toStringAsFixed(2);

    setState(() {
      carbonFootprintResult = "Your Carbon Footprint is $formattedResult grams!";
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
            buildQuestion("How many grams of food did you eat today?", _controller7, 'Housing_q7'),
            buildQuestion("How many grams of meat did you eat today?", _controller8, 'Housing_q8'),
            buildQuestion("How many bottles of beer did you drink today?", _controller9, 'Housing_q9'),
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
}
