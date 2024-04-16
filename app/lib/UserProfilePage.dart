import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

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