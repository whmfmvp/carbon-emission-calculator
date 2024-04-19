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
      // 获取当前时间，并将其格式化为ISO 8601格式
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-ddTHH:mm:ss').format(now);

      // 使用当前时间作为API请求的参数
      Map<String, dynamic> carbonIntensityData = await _carbonIntensityService.fetchCarbonIntensityData(formattedDate);

      // 提取所有 forecast 字段的值和时间
      List<dynamic> data = carbonIntensityData['data'];
      _forecastValues = data.map<int>((entry) => entry['intensity']['forecast']).toList();
      _forecastTimes = data.map<String>((entry) => entry['from']).toList();
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
        title: Text('Carbon Intensity Data'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _forecastValues.isNotEmpty
              ? LineChart(
                  LineChartData(
                    titlesData: FlTitlesData(
                      bottomTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 22,
                        getTextStyles: (value) => const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                        margin: 10,
                        getTitles: (value) {
                          return _forecastTimes[value.toInt()];
                        },
                      ),
                      leftTitles: SideTitles(
                        showTitles: true,
                        getTextStyles: (value) => const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                        margin: 10,
                        reservedSize: 40,
                        getTitles: (value) {
                          // 如果当前值除以 5 的余数为 0，则显示刻度，否则不显示
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
                      ),
                    ],
                  ),
                )
              : Center(
                  child: Text('Failed to fetch data.'),
                ),
    );
  }
}
