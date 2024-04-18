import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _UsagePageState extends State<UsagePage> {
  late TextEditingController _controller1;
  late TextEditingController _controller2;
  late TextEditingController _controller3;
  late SharedPreferences _prefs;
  String carbonFootprintResult = "";  // 用于存储和显示碳足迹计算结果的字符串

  // ...其他初始化方法...

  void calculateCarbonFootprint() {
    double q1 = double.tryParse(_controller1.text) ?? 0;
    double q2 = double.tryParse(_controller2.text) ?? 0;
    double q3 = double.tryParse(_controller3.text) ?? 0;
    double result = (q1 * 0.1) + (q2 * 45.72) + (q3 * 3.5);
    setState(() {
      carbonFootprintResult = "Your Carbon Footprint is $result grams!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildQuestion("How many plastic bags did you use?", _controller1),
            SizedBox(height: 20),
            buildQuestion("How many sets of disposable tableware did you use?", _controller2),
            SizedBox(height: 20),
            buildQuestion("How many grams of paper products did you use?", _controller3),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildButton("Last Page", Colors.grey, () => Navigator.pop(context)),
                buildButton("Calculate Your Carbon Footprint", Colors.green, calculateCarbonFootprint),
              ],
            ),
            SizedBox(height: 20),
            if (carbonFootprintResult.isNotEmpty) Text(carbonFootprintResult),
          ],
        ),
      ),
    );
  }
}
