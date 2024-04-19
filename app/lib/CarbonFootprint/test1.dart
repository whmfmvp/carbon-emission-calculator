import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'test2.dart'; // Ensure UsagePage is imported correctly

class TransportationPage extends StatefulWidget {
  @override
  _TransportationPageState createState() => _TransportationPageState();
}

class _TransportationPageState extends State<TransportationPage> {
  TextEditingController _controller = TextEditingController();
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _initializePreferences();
  }

  _initializePreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Transportation Data Input')),
      body: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'Enter transportation emissions (grams)',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _prefs.setInt('transportationEmissions', int.tryParse(_controller.text) ?? 0);
              Navigator.push(context, MaterialPageRoute(builder: (context) => UsagePage()));
            },
            child: Text('Next Page'),
          ),
        ],
      ),
    );
  }
}
