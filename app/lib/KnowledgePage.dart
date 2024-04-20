import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class KnowledgePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
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
        InkWell(
          onTap: () => launch('https://www.un.org/en/climatechange/net-zero-coalition'),  // 添加网址链接
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Image.asset('assets/images/net_zero.jpg', width: 24, height: 24),  // 使用图片替换Icon
                SizedBox(width: 10),
                Text('Net Zero'),  // 添加右侧文字
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => launch('https://www.un.org/en/climatechange/raising-ambition/renewable-energy'),  // 添加Renewable Energy网址链接
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Image.asset('assets/images/renewable_energy.jpg', width: 24, height: 24),  // 使用图片替换Icon
                SizedBox(width: 10),
                Text('Renewable Energy'),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => launch('https://www.un.org/en/climatechange/17-goals-to-transform-our-world'),  // 添加Sustainable Development Goals网址链接
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Image.asset('assets/images/SDGs.jpg', width: 24, height: 24),  // 使用图片替换Icon
                SizedBox(width: 10),
                Text('Sustainable Development Goals'), 
              ],
            ),
          ),
        ),
      ],
    );
  }
}
