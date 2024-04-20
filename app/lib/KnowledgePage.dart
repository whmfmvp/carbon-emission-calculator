import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class KnowledgePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
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
        SizedBox(height: 20),
        InkWell(
          onTap: () => launch('https://www.un.org/en/climatechange/net-zero-coalition'),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                Icon(Icons.cloud),
                SizedBox(width: 20),
                Text('Net Zero', style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        InkWell(
          onTap: () => launch('https://www.un.org/en/climatechange/raising-ambition/renewable-energy'),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                Icon(Icons.flash_on),
                SizedBox(width: 20),
                Text('Renewable Energy', style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        InkWell(
          onTap: () => launch('https://www.un.org/en/climatechange/17-goals-to-transform-our-world'),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                Icon(Icons.public),
                SizedBox(width: 20),
                Text('Sustainable Development Goals', style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        InkWell(
          onTap: () => launch('https://www.climfoot-project.eu/en/what-emission-factor'),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                Icon(Icons.assignment),
                SizedBox(width: 20),
                Text('Emission Factor (EF)', style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        InkWell(
          onTap: () => launch('https://www.nationalgrid.com/stories/energy-explained/what-is-carbon-intensity'),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                Icon(Icons.local_fire_department),
                SizedBox(width: 20),
                Text('Carbon Intensity', style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
