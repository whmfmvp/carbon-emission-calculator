import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class UsagePage extends StatefulWidget {
  final TextEditingController controller4;
  final TextEditingController controller5;
  final TextEditingController controller6;

  UsagePage({Key? key, required this.controller4, required this.controller5, required this.controller6}) : super(key: key);

  @override
  _UsagePageState createState() => _UsagePageState();
}

class _UsagePageState extends State<UsagePage> {
  late TextEditingController _controller1;
  late TextEditingController _controller2;
  late TextEditingController _controller3;
  late SharedPreferences _prefs;
  bool _prefsInitialized = false;
  String carbonFootprintResult = ""; // To display carbon footprint calculation results.

  @override
  void initState() {
    super.initState();
    _controller1 = TextEditingController();
    _controller2 = TextEditingController();
    _controller3 = TextEditingController();
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
      _controller1.text = _prefs.getString('usage_q1') ?? '';
      _controller2.text = _prefs.getString('usage_q2') ?? '';
      _controller3.text = _prefs.getString('usage_q3') ?? '';
    });
  }

  _saveData(String key, String value) {
    _prefs.setString(key, value);
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  void calculateCarbonFootprint() {
    double q1 = double.tryParse(_controller1.text) ?? 0;
    double q2 = double.tryParse(_controller2.text) ?? 0;
    double q3 = double.tryParse(_controller3.text) ?? 0;
    double q4 = double.tryParse(widget.controller4.text) ?? 0; // Access controller4, controller5, and controller6 from widget
    double q5 = double.tryParse(widget.controller5.text) ?? 0;
    double q6 = double.tryParse(widget.controller6.text) ?? 0;
    double result = (q1 * 0.1) +
        (q2 * 45.72) +
        (q3 * 3.5) +
        (q4 * 0.1) +
        (q5 * 45.72) +
        (q6 * 3.5);
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
            buildQuestion("How many plastic bags did you use?", _controller1, 'usage_q1'),
            buildQuestion("How many sets of disposable tableware did you use?", _controller2, 'usage_q2'),
            buildQuestion("How many grams of paper products did you use?", _controller3, 'usage_q3'),
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
