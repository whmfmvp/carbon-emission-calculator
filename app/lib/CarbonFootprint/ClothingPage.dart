import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'FoodPage.dart';

class ClothingPage extends StatefulWidget {
  final String category;

  ClothingPage({Key? key, required this.category}) : super(key: key);

  @override
  _ClothingPageState createState() => _ClothingPageState();
}

class _ClothingPageState extends State<ClothingPage> {
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
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20), // Adds space at the top
          Text('Question 1'),
          SizedBox(height: 10), // Adds space between the question and the text field
          TextField(
            controller: _controller1,
            keyboardType: TextInputType.number,
            onSubmitted: (value) => _saveData('${widget.category}_q1', value),
          ),
          SizedBox(height: 20), // Adds space between text fields
          Text('Question 2'),
          SizedBox(height: 10),
          TextField(
            controller: _controller2,
            keyboardType: TextInputType.number,
            onSubmitted: (value) => _saveData('${widget.category}_q2', value),
          ),
          SizedBox(height: 20),
          Text('Question 3'),
          SizedBox(height: 10),
          TextField(
            controller: _controller3,
            keyboardType: TextInputType.number,
            onSubmitted: (value) => _saveData('${widget.category}_q3', value),
          ),
          SizedBox(height: 30), // Adds space before the buttons
          ElevatedButton(
            child: Text('Last Page'),
            onPressed: () {
              // Navigate to the last page or tab
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey, // Button color
              shape: StadiumBorder(), // Rounded edges
            ),
          ),
          SizedBox(height: 10), // Space between buttons
          ElevatedButton(
            child: Text('Next Page'),
            onPressed: () async {
  await Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => FoodPage(category: 'Food',)),
  );
},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green, // Button color
              shape: StadiumBorder(), // Rounded edges
            ),
          ),
          SizedBox(height: 20), // Adds space at the bottom
        ],
      ),
    ),
  );
}
}