import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HousingPage extends StatefulWidget {
  final String category;

  HousingPage({Key? key, required this.category}) : super(key: key);

  @override
  _HousingPageState createState() => _HousingPageState();
}

class _HousingPageState extends State<HousingPage> {
  late TextEditingController _controller1;
  late TextEditingController _controller2;
  late TextEditingController _controller3;
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _controller1 = TextEditingController();
    _controller2 = TextEditingController();
    _controller3 = TextEditingController();
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('Question 1'),
        TextField(
          controller: _controller1,
          keyboardType: TextInputType.number,
          onSubmitted: (value) {
            _saveData('${widget.category}_q1', value);
          },
        ),
        Text('Question 2'),
        TextField(
          controller: _controller2,
          keyboardType: TextInputType.number,
          onSubmitted: (value) {
            _saveData('${widget.category}_q2', value);
          },
        ),
        Text('Question 3'),
        TextField(
          controller: _controller3,
          keyboardType: TextInputType.number,
          onSubmitted: (value) {
            _saveData('${widget.category}_q3', value);
          },
        ),
      ],
    );
  }
}
