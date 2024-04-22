import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

class CarbonIntensityService {
  Future<Map<String, dynamic>> fetchCarbonIntensityData(String from) async {
    String apiUrl = 'https://api.carbonintensity.org.uk/intensity/$from/fw24h';

    final response = await http.get(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch data: ${response.statusCode}');
    }
  }
}

class CarbonIntensityPage extends StatefulWidget {
  @override
  _CarbonIntensityPageState createState() => _CarbonIntensityPageState();
}

class _CarbonIntensityPageState extends State<CarbonIntensityPage> {
  final CarbonIntensityService _carbonIntensityService = CarbonIntensityService();
  List<int> _forecastValues = [];
  List<String> _forecastTimes = [];
  List<dynamic> _carbonIntensityData = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-ddTHH:mm:ss').format(now);

      
      Map<String, dynamic> carbonIntensityData = await _carbonIntensityService.fetchCarbonIntensityData(formattedDate);

      
      _carbonIntensityData = carbonIntensityData['data'];
      _forecastValues = _carbonIntensityData.map<int>((entry) => entry['intensity']['forecast']).toList();
      _forecastTimes = _carbonIntensityData.map<String>((entry) => entry['from']).toList();
    } catch (e) {
      print('Error fetching data: $e');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carbon Intensity(gCO2/kWh)'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _forecastValues.isNotEmpty
              ? Column(
                  children: [
                    Expanded(
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            width: _forecastValues.length * 100.0, 
                            child: LineChart(
                              LineChartData(
                                titlesData: FlTitlesData(
                                  bottomTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 22,
                                    getTextStyles: (value) => const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                                    margin: 10,
                                    getTitles: (value) {
                                      int index = value.toInt();
                                      if (index >= 0 && index < _forecastTimes.length) {
                                        
                                        DateTime time = DateTime.parse(_forecastTimes[index]);

                                        
                                        if (time.minute == 0) {
                                          return DateFormat('HH:mm').format(time);
                                        } else {
                                          return '';
                                        }
                                      } else {
                                        return '';
                                      }
                                    },
                                  ),
                                  leftTitles: SideTitles(
                                    showTitles: true,
                                    getTextStyles: (value) => const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                                    margin: 10,
                                    reservedSize: 40,
                                    getTitles: (value) {
                                      
                                      if (value % 5 == 0) {
                                        return value.toInt().toString();
                                      } else {
                                        return '';
                                      }
                                    },
                                  ),
                                ),
                                borderData: FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d), width: 1)),
                                minX: 0,
                                maxX: _forecastValues.length.toDouble() - 1,
                                minY: _forecastValues.reduce((min, value) => min < value ? min : value).toDouble(),
                                maxY: _forecastValues.reduce((max, value) => max > value ? max : value).toDouble(),
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: _forecastValues.asMap().entries.map((entry) => FlSpot(entry.key.toDouble(), entry.value.toDouble())).toList(),
                                    isCurved: true,
                                    colors: [Colors.blue],
                                    barWidth: 5,
                                    isStrokeCapRound: true,
                                    dotData: FlDotData(show: false),
                                    belowBarData: BarAreaData(show: true, colors: [
                                      for (var forecast in _forecastValues)
                                        if (forecast < 100)
                                          Colors.green.withOpacity(0.3)
                                        else if (forecast >= 100 && forecast <= 200)
                                          Colors.yellow.withOpacity(0.3)
                                        else
                                          Colors.red.withOpacity(0.3)
                                    ]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Center(
                  child: Text('Failed to fetch data.'),
                ),
    );
  }
}
