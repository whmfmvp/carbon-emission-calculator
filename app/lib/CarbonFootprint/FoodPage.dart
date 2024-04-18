import 'package:flutter/material.dart';
import 'package:flutter_application_1/CarbonFootprint/UsagePage.dart';
import 'package:flutter_application_1/UserProfilePage.dart';
import 'package:shared_preferences/shared_preferences.dart';


class FoodPage extends StatefulWidget {
  final String category;

  FoodPage({Key? key, required this.category}) : super(key: key);

  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  late TextEditingController _controller1;
  late TextEditingController _controller2;
  late TextEditingController _controller3;
  Future<SharedPreferences>? _prefsFuture;

  @override
  void initState() {
    super.initState();
    _controller1 = TextEditingController();
    _controller2 = TextEditingController();
    _controller3 = TextEditingController();
    _prefsFuture = SharedPreferences.getInstance();
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
    return FutureBuilder<SharedPreferences>(
      future: _prefsFuture,
      builder: (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          final prefs = snapshot.data!;
          _controller1.text = prefs.getString('${widget.category}_q1') ?? '';
          _controller2.text = prefs.getString('${widget.category}_q2') ?? '';
          _controller3.text = prefs.getString('${widget.category}_q3') ?? '';

          return buildPage(context);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget buildPage(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            buildQuestionField('Question 1', _controller1),
            buildQuestionField('Question 2', _controller2),
            buildQuestionField('Question 3', _controller3),
            navigationButtons(context),
          ],
        ),
      ),
    );
  }

  Widget buildQuestionField(String label, TextEditingController controller) {
    return Column(
      children: [
        Text(label),
        SizedBox(height: 10),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          onSubmitted: (value) => _prefsFuture!.then((prefs) {
            prefs.setString('${widget.category}_${label.replaceAll(' ', '').toLowerCase()}', value);
          }),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget navigationButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          child: Text('Last Page'),
          onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserProfilePage()),
          );
        },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey,
            shape: StadiumBorder(),
          ),
        ),
        ElevatedButton(
          child: Text('Next Page'),
          onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UsagePage(category: '',)),
          );
        },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: StadiumBorder(),
          ),
        ),
      ],
    );
  }
}
