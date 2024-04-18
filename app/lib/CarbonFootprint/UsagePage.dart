import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsagePage extends StatefulWidget {
  final String category;

  UsagePage({Key? key, required this.category}) : super(key: key);

  @override
  _UsagePageState createState() => _UsagePageState();
}

class _UsagePageState extends State<UsagePage> {
  late TextEditingController _controller1;
  late TextEditingController _controller2;
  late TextEditingController _controller3;
  late TextEditingController _controller4;
  late TextEditingController _controller5;
  late TextEditingController _controller6;
  late SharedPreferences _prefs;
  String carbonFootprintResult = "";  // To display carbon footprint calculation results.

  @override
  void initState() {
    super.initState();
    _controller1 = TextEditingController();
    _controller2 = TextEditingController();
    _controller3 = TextEditingController();
    _controller4 = TextEditingController();
    _controller5 = TextEditingController();
    _controller6 = TextEditingController();
    _loadSavedData();
  }

  _loadSavedData() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _controller1.text = _prefs.getString('${widget.category}_q1') ?? '';
      _controller2.text = _prefs.getString('${widget.category}_q2') ?? '';
      _controller3.text = _prefs.getString('${widget.category}_q3') ?? '';
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
    _controller4.dispose();
    _controller5.dispose();
    _controller6.dispose();
    super.dispose();
  }

  void calculateCarbonFootprint() {
    double q1 = double.tryParse(_controller1.text) ?? 0;
    double q2 = double.tryParse(_controller2.text) ?? 0;
    double q3 = double.tryParse(_controller3.text) ?? 0;
    double q4 = double.tryParse(_controller4.text) ?? 0;
    double q5 = double.tryParse(_controller5.text) ?? 0;
    double q6 = double.tryParse(_controller6.text) ?? 0;
    double result = (q1 * 0.1) + (q2 * 45.72) + (q3 * 3.5) + (q4 * 0.1) + (q5 * 45.72) + (q6 * 3.5);
    String formattedResult = result.toStringAsFixed(2);

  setState(() {
    carbonFootprintResult = "Your Carbon Footprint is $formattedResult grams!";
  });
  }

  @override
Widget build(BuildContext context) {
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildQuestion("How many plastic bags did you use?", _controller1),
          buildQuestion("How many sets of disposable tableware did you use?", _controller2),
          buildQuestion("How many grams of paper products did you use?", _controller3),
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


  Widget buildQuestion(String question, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(question, style: TextStyle(fontSize: 16)),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter your answer here'
          ),
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
        shape: StadiumBorder(),  // Rounded edges
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Padding inside button
      ),
    );
  }
}
