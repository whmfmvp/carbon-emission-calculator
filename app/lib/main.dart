import 'package:flutter/material.dart';
import 'splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
   
      home: SplashScreen(),

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
    Text('Home', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Data', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Knowledge', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Settings', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
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
