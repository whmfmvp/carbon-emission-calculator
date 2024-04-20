import 'dart:async';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'splash_screen.dart';
import 'ColorThemePage.dart';
import 'theme_provider.dart';
import 'package:provider/provider.dart';
import 'KnowledgePage.dart';
import 'UserProfilePage.dart';
import 'CarbonFootprint/CarbonFootprintCalculation.dart';
import 'data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeProvider = ThemeProvider();
  await themeProvider.loadThemeColor();

  runApp(
    ChangeNotifierProvider(
      create: (context) => themeProvider,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeProvider>(context).themeColor;
    return MaterialApp(
      home: SplashScreen(),
      theme: ThemeData(
        primaryColor: themeColor,
        scaffoldBackgroundColor: themeColor, // 设置背景颜色
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = [
    TopTabsExample(),
    CarbonIntensityPage(),
    KnowledgePage(),
    Settings(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carbon Footprint Calculator'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Data',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Knowledge',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _notificationsEnabled = false;

  void _clearCache() async {
    // 清除SharedPreferences中的数据
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Cache cleared'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 20.0), // 增加模块之间的垂直间距
      children: <Widget>[
        ListTile(
          title: Text(
            'Personal Information',
            style: TextStyle(fontSize: 20), // 增大字体大小
          ),
          leading: Icon(Icons.person),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => UserProfilePage()),
            );
          },
        ),
        SizedBox(height: 20),
        SwitchListTile(
          title: Text(
            'Enable notifications',
            style: TextStyle(fontSize: 20), // 增大字体大小
          ),
          value: _notificationsEnabled,
          onChanged: (bool value) {
            setState(() {
              _notificationsEnabled = value;
            });
            // 这里可以添加其他逻辑，比如保存偏好到本地
          },
          secondary: Icon(Icons.notifications_active),
        ),
        SizedBox(height: 20),
        ListTile(
          title: Text(
            'Clear cache',
            style: TextStyle(fontSize: 20), // 增大字体大小
          ),
          leading: Icon(Icons.clear),
          onTap: () {
            _clearCache();
          },
        ),
        SizedBox(height: 20),
        ListTile(
          title: Text(
            'Color theme',
            style: TextStyle(fontSize: 20), // 增大字体大小
          ),
          leading: Icon(Icons.color_lens),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ColorThemePage()),
            );
          },
        ),
        // 添加更多设置项...
      ],
    );
  }
}
