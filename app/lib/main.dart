import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


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

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text('Personal Information'),
          leading: Icon(Icons.person),
          onTap: () { Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => UserProfilePage()),
    );
          },
        ),
        SwitchListTile(
          title: Text('Enable notifications'),
          value: _notificationsEnabled,
          onChanged: (bool value) {
            setState(() {
              _notificationsEnabled = value;
            });
            // 这里可以添加其他逻辑，比如保存偏好到本地
          },
          secondary: Icon(Icons.notifications_active),
        ),
        ListTile(
          title: Text('Color theme'),
          leading: Icon(Icons.color_lens),
          onTap: () {
            // 这里可以添加逻辑，比如打开颜色主题选择器
          },
        ),
        // 添加更多设置项...
      ],
    );
  }
}

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _userImage = 'assets/default_avatar.png'; // 假设这是默认头像的路径

 @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    _usernameController.text = prefs.getString('username') ?? '';
    _genderController.text = prefs.getString('gender') ?? '';
    _birthdateController.text = prefs.getString('birthdate') ?? '';
    _emailController.text = prefs.getString('email') ?? '';
    _phoneController.text = prefs.getString('phone') ?? '';
  }

  void _saveProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _usernameController.text);
    await prefs.setString('gender', _genderController.text);
    await prefs.setString('birthdate', _birthdateController.text);
    await prefs.setString('email', _emailController.text);
    await prefs.setString('phone', _phoneController.text);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('User information saved'),
        duration: Duration(seconds: 2),
      ),
    );

    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit personal information'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: <Widget>[
          Center(
            child: GestureDetector(
              onTap: () {
                // 这里添加更换头像的逻辑
              },
              child: CircleAvatar(
                backgroundImage: AssetImage(_userImage),
                radius: 60,
              ),
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(labelText: 'Username'),
          ),
          TextFormField(
            controller: _genderController,
            decoration: InputDecoration(labelText: 'Gender'),
          ),
          TextFormField(
            controller: _birthdateController,
            decoration: InputDecoration(labelText: 'Birth date'),
          ),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          TextFormField(
            controller: _phoneController,
            decoration: InputDecoration(labelText: 'Telephone'),
          ),
          SizedBox(height: 40), // 增加间隔，使按钮下移
          ElevatedButton(
            onPressed: _saveProfile,
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}