import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClothingPage extends StatefulWidget {
  final TextEditingController controller13;
  final TextEditingController controller14;
  final TextEditingController controller15;

  ClothingPage({Key? key, required this.controller13, required this.controller14, required this.controller15}) : super(key: key);

  @override
  _ClothingPageState createState() => _ClothingPageState();
}


class _ClothingPageState extends State<ClothingPage> {
  late TextEditingController _controller13;
  late TextEditingController _controller14;
  late TextEditingController _controller15;
  late SharedPreferences _prefs;
  bool _prefsInitialized = false;
  String carbonFootprintResult = ""; // To display carbon footprint calculation results.

  @override
  void initState() {
    super.initState();
    _controller13 = TextEditingController();
    _controller14 = TextEditingController();
    _controller15 = TextEditingController();
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
      _controller13.text = _prefs.getString('Clothing_q13') ?? '';
      _controller14.text = _prefs.getString('Clothing_q14') ?? '';
      _controller15.text = _prefs.getString('Clothing_q15') ?? '';
    });
  }

  _saveData(String key, String value) {
    _prefs.setString(key, value);
  }

  @override
  void dispose() {
    _controller13.dispose();
    _controller14.dispose();
    _controller15.dispose();
    super.dispose();
  }

  void calculateCarbonFootprint() {
    double q13 = double.tryParse(_controller13.text) ?? 0;
    double q14 = double.tryParse(_controller14.text) ?? 0;
    double q15 = double.tryParse(_controller15.text) ?? 0;
    double result = (q13 * 12000) + (q14 * 260) + (q15 * 0.72);
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
            buildQuestion("How many new clothes did you purchase today?", _controller13, 'Clothing_q13'),
            buildQuestion("How many times do you machine wash clothes today?", _controller14, 'Clothing_q14'),
            buildQuestion("How many grams of laundry detergent (liquid) did you use today?", _controller15, 'Clothing_q15'),
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
