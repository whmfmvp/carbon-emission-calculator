import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Test1.dart'; // 确保正确导入TransportationPage

class UsagePage extends StatefulWidget {
  @override
  _UsagePageState createState() => _UsagePageState();
}

class _UsagePageState extends State<UsagePage> {
  late TextEditingController _controller;
  late Future<SharedPreferences> _prefsFuture;
  String result = "";

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _prefsFuture = SharedPreferences.getInstance();  // 异步获取SharedPreferences实例
  }

  void calculateFootprint() async {
    final prefs = await _prefsFuture;
    int transportationEmissions = prefs.getInt('transportationEmissions') ?? 0;
    int usageEmissions = int.tryParse(_controller.text) ?? 0;
    int totalEmissions = transportationEmissions + usageEmissions;
    setState(() {
      result = 'Total Carbon Footprint: $totalEmissions grams';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Usage and Emissions Calculation'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter usage emissions (grams)',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => TransportationPage()));
              },
              child: Text('Last Page'),
            ),
            ElevatedButton(
              onPressed: calculateFootprint,
              child: Text('Calculate Your Carbon Footprint'),
            ),
            SizedBox(height: 20),
            if (result.isNotEmpty) Text(result),
          ],
        ),
      ),
    );
  }
}
