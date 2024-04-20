import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class KnowledgePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch, // 让每个box占据整个屏幕宽度
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              // 添加关于页面的逻辑
            },
            child: Text('About'),
          ),
        ),
        SizedBox(height: 20), // 增大每个box之间的距离
        InkWell(
          onTap: () => launch('https://www.un.org/en/climatechange/net-zero-coalition'),  // 添加网址链接
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1), // 添加边框
            ),
            padding: const EdgeInsets.all(20.0), // 增大每个box的大小
            child: Row(
              children: <Widget>[
                Image.asset('assets/images/earth.jpg', width: 48, height: 48),  // 增大图片大小
                SizedBox(width: 20),
                Text('Net Zero', style: TextStyle(fontSize: 20)),  // 增大文字大小
              ],
            ),
          ),
        ),
        SizedBox(height: 20), // 增大每个box之间的距离
        InkWell(
          onTap: () => launch('https://www.un.org/en/climatechange/raising-ambition/renewable-energy'),  // 添加Renewable Energy网址链接
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1), // 添加边框
            ),
            padding: const EdgeInsets.all(20.0), // 增大每个box的大小
            child: Row(
              children: <Widget>[
                Image.asset('assets/images/earth.jpg', width: 48, height: 48),  // 增大图片大小
                SizedBox(width: 20),
                Text('Renewable Energy', style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
        ),
        SizedBox(height: 20), // 增大每个box之间的距离
        InkWell(
          onTap: () => launch('https://www.un.org/en/climatechange/17-goals-to-transform-our-world'),  // 添加Sustainable Development Goals网址链接
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1), // 添加边框
            ),
            padding: const EdgeInsets.all(20.0), // 增大每个box的大小
            child: Row(
              children: <Widget>[
                Image.asset('assets/images/earth.jpg', width: 48, height: 48),  // 增大图片大小
                SizedBox(width: 20),
                Text('Sustainable Development Goals', style: TextStyle(fontSize: 20)), 
              ],
            ),
          ),
        ),
      ],
    );
  }
}
