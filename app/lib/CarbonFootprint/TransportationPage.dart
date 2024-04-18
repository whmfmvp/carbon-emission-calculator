import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransportationPage extends StatefulWidget {
  final String category;

  TransportationPage({Key? key, required this.category}) : super(key: key);

  @override
  _TransportationPageState createState() => _TransportationPageState();
}

class _TransportationPageState extends State<TransportationPage> {
  late TextEditingController _controller4;
  late TextEditingController _controller5;
  late TextEditingController _controller6;
  late SharedPreferences _prefs;
  String carbonFootprintResult = "";  // To display carbon footprint calculation results.

  @override
  void initState() {
    super.initState();
    _controller4 = TextEditingController();
    _controller5 = TextEditingController();
    _controller6 = TextEditingController();
    _loadSavedData();
  }

  _loadSavedData() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _controller4.text = _prefs.getString('${widget.category}_q4') ?? '';
      _controller5.text = _prefs.getString('${widget.category}_q5') ?? '';
      _controller6.text = _prefs.getString('${widget.category}_q6') ?? '';
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
    double result = (q4 * 0.1) + (q5 * 45.72) + (q6 * 3.5);
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
          buildQuestion("How many plastic bags did you use?", _controller4),
          buildQuestion("How many sets of disposable tableware did you use?", _controller5),
          buildQuestion("How many grams of paper products did you use?", _controller6),
          SizedBox(height: 30),
          // Button for last page
          buildButton("Last Page", Colors.grey, () => Navigator.pop(context)),
          SizedBox(height: 10), // Space between the button

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
        primary: color,
        shape: StadiumBorder(),  // Rounded edges
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Padding inside button
      ),
    );
  }
}
