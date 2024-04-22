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
               Image.asset('assets/images/net_zero.jpg', width: 48, height: 48),
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
                Image.asset('assets/images/renewable_energy.jpg', width: 48, height: 48),
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
                Image.asset('assets/images/SDGs.jpg', width: 48, height: 48),
                SizedBox(width: 20),
                Text('Sustainable Development Goals', style: TextStyle(fontSize: 15)),
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
                Image.asset('assets/images/emission_factor.jpg', width: 48, height: 48),
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
                Image.asset('assets/images/carbon_intensity.jpg', width: 48, height: 48),
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
