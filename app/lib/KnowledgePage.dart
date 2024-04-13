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
                Icon(Icons.cloud),  // 添加左侧图标
                SizedBox(width: 10),
                Text('Net Zero'),  // 添加右侧文字
              ],
            ),
          ),
        ),
      ],
    );
  }
}
