import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsagePage extends StatefulWidget {
  final TextEditingController controller1;
  final TextEditingController controller2;
  final TextEditingController controller3;
  final TextEditingController controller4;
  final TextEditingController controller5;
  final TextEditingController controller6;
  final TextEditingController controller7;
  final TextEditingController controller8;
  final TextEditingController controller9;
  final TextEditingController controller10;
  final TextEditingController controller11;
  final TextEditingController controller12;
  final TextEditingController controller13;
  final TextEditingController controller14;
  final TextEditingController controller15;

  UsagePage({
    Key? key,
    required this.controller1,
    required this.controller2,
    required this.controller3,
    required this.controller4,
    required this.controller5,
    required this.controller6,
    required this.controller7,
    required this.controller8,
    required this.controller9,
    required this.controller10,
    required this.controller11,
    required this.controller12,
    required this.controller13,
    required this.controller14,
    required this.controller15,
  }) : super(key: key);

  @override
  _UsagePageState createState() => _UsagePageState();
}

class _UsagePageState extends State<UsagePage> {
  late SharedPreferences _prefs;
  bool _prefsInitialized = false;
  String carbonFootprintResult = ""; 
  String OverallcarbonFootprintResult = ""; 

  @override
  void initState() {
    super.initState();
    _initializePrefs();
  }

  _initializePrefs() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _prefsInitialized = true;
      _loadSavedData(); 
    });
  }

  _loadSavedData() {
    if (!_prefsInitialized) return; 
    setState(() {
      widget.controller1.text = _prefs.getString('usage_q1') ?? '';
      widget.controller2.text = _prefs.getString('usage_q2') ?? '';
      widget.controller3.text = _prefs.getString('usage_q3') ?? '';
      widget.controller4.text = _prefs.getString('transportation_q4') ?? '';
      widget.controller5.text = _prefs.getString('transportation_q5') ?? '';
      widget.controller6.text = _prefs.getString('transportation_q6') ?? '';
      widget.controller7.text = _prefs.getString('Housing_q7') ?? '';
      widget.controller8.text = _prefs.getString('Housing_q8') ?? '';
      widget.controller9.text = _prefs.getString('Housing_q9') ?? '';
      widget.controller10.text = _prefs.getString('Food_q10') ?? '';
      widget.controller11.text = _prefs.getString('Food_q11') ?? '';
      widget.controller12.text = _prefs.getString('Food_q12') ?? '';
      widget.controller13.text = _prefs.getString('Clothing_q13') ?? '';
      widget.controller14.text = _prefs.getString('Clothing_q14') ?? '';
      widget.controller15.text = _prefs.getString('Clothing_q15') ?? '';

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
            
            buildButton("Calculate Your Carbon Footprint", Colors.green, calculateCarbonFootprint),
            if (carbonFootprintResult.isNotEmpty) Text(carbonFootprintResult),
            SizedBox(height: 20),
            
            buildButton("Calculate Your Overall Carbon Footprint", Colors.green, OverallCarbonFootprint),
            if (OverallcarbonFootprintResult.isNotEmpty) Text(OverallcarbonFootprintResult),
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
        SizedBox(height: 20), 
      ],
    );
  }

  Widget buildButton(String text, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: StadiumBorder(), 
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), 
      ),
    );
  }

void calculateCarbonFootprint() {
    double q1 = double.tryParse(widget.controller1.text) ?? 0;
    double q2 = double.tryParse(widget.controller2.text) ?? 0;
    double q3 = double.tryParse(widget.controller3.text) ?? 0;
    double result = (q1 * 0.1) + (q2 * 45.72) + (q3 * 3.5);
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

  void OverallCarbonFootprint() {
    double q1 = double.tryParse(widget.controller1.text) ?? 0;
    double q2 = double.tryParse(widget.controller2.text) ?? 0;
    double q3 = double.tryParse(widget.controller3.text) ?? 0;
    double q4 = double.tryParse(widget.controller4.text) ?? 0; 
    double q5 = double.tryParse(widget.controller5.text) ?? 0;
    double q6 = double.tryParse(widget.controller6.text) ?? 0;
    double q7 = double.tryParse(widget.controller7.text) ?? 0; 
    double q8 = double.tryParse(widget.controller8.text) ?? 0;
    double q9 = double.tryParse(widget.controller9.text) ?? 0;
    double q10 = double.tryParse(widget.controller10.text) ?? 0; 
    double q11 = double.tryParse(widget.controller11.text) ?? 0;
    double q12 = double.tryParse(widget.controller12.text) ?? 0;
    double q13 = double.tryParse(widget.controller13.text) ?? 0; 
    double q14 = double.tryParse(widget.controller14.text) ?? 0;
    double q15 = double.tryParse(widget.controller15.text) ?? 0;
    double result = (q1 * 0.1) +
        (q2 * 45.72) +
        (q3 * 3.5) +
        (q4 * 36) +
        (q5 * 69) +
        (q6 * 270)+
        (q7 * 570.3) +
        (q8 * 0.91) +
        (q9 * 190) +
        (q10 * 2) +
        (q11 * 36.4) +
        (q12 * 220)+
        (q13 * 12000) +
        (q14 * 260) +
        (q15 * 0.72);
    String formattedResult;
  if (result >= 1000) {
    double kilograms = result / 1000;
    formattedResult = "Your Overall Carbon Footprint is ${kilograms.toStringAsFixed(2)} kilograms!";
  } else {
    formattedResult = "Your Overall Carbon Footprint is ${result.toStringAsFixed(2)} grams!";
  }

  setState(() {
    OverallcarbonFootprintResult = formattedResult;
  });
}
}

