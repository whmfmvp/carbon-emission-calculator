import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme_provider.dart';
import 'package:provider/provider.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


class ColorThemePage extends StatefulWidget {
  @override
  _ColorThemePageState createState() => _ColorThemePageState();
}

class _ColorThemePageState extends State<ColorThemePage> {
  final List<Color> _colors = [Colors.white,Colors.blue, Colors.green, Colors.red, Colors.orange,Colors.pink,Colors.purple];
  int? _selectedColorIndex;

  @override

  void initState() {
    super.initState();
    _loadSelectedColor();
  }

  _loadSelectedColor() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedColorIndex = prefs.getInt('colorThemeIndex');
    });
  }

  _saveSelectedColor(int index) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('colorThemeIndex', index);


  await Future.delayed(Duration(seconds: 2));
    Navigator.of(context).pop();
}


  _onColorTap(int index) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    themeProvider.themeColor = _colors[index];
    Navigator.of(context).pop(); // 返回设置页面
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose a color theme'),
      ),
      body: ListView.builder(
        itemCount: _colors.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Radio<int>(
              value: index,
              groupValue: _selectedColorIndex,
              onChanged: (int? value) {
                setState(() {
                  _selectedColorIndex = value;
                });
                _saveSelectedColor(index);
              },
            ),
            title: Container(
              height: 50,
              color: _colors[index],
            ),
          onTap: () => _onColorTap(index),
          );
        },
      ),
    );
  }
}
