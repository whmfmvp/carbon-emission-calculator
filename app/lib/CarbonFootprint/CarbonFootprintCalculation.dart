import 'package:flutter/material.dart';
import 'package:flutter_application_1/CarbonFootprint/TransportationPage.dart';
import 'ClothingPage.dart';
import 'FoodPage.dart';
import 'HousingPage.dart';
import 'UsagePage.dart';


class TopTabsExample extends StatefulWidget {
  @override
  _TopTabsExampleState createState() => _TopTabsExampleState();
}

class _TopTabsExampleState extends State<TopTabsExample> with SingleTickerProviderStateMixin {
  late TabController _tabController;


  late TextEditingController _controller1;
  late TextEditingController _controller2;
  late TextEditingController _controller3;
  late TextEditingController _controller4;
  late TextEditingController _controller5;
  late TextEditingController _controller6;
  late TextEditingController _controller7;
  late TextEditingController _controller8;
  late TextEditingController _controller9;
  late TextEditingController _controller10;
  late TextEditingController _controller11;
  late TextEditingController _controller12;
  late TextEditingController _controller13;
  late TextEditingController _controller14;
  late TextEditingController _controller15;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);

    _controller1 = TextEditingController();
    _controller2 = TextEditingController();
    _controller3 = TextEditingController();
    _controller4 = TextEditingController();
    _controller5 = TextEditingController();
    _controller6 = TextEditingController();
    _controller7 = TextEditingController();
    _controller8 = TextEditingController();
    _controller9 = TextEditingController();
    _controller10 = TextEditingController();
    _controller11 = TextEditingController();
    _controller12 = TextEditingController();
    _controller13 = TextEditingController();
    _controller14 = TextEditingController();
    _controller15 = TextEditingController();
  }

  @override
  void dispose() {
    _tabController.dispose();

    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    _controller5.dispose();
    _controller6.dispose();
    _controller7.dispose();
    _controller8.dispose();
    _controller9.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicator: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(25), 
            color: Colors.green, 
          ),
          tabs: [
            Tab(icon: Icon(Icons.checkroom), text: 'Clothing'),
            Tab(icon: Icon(Icons.fastfood), text: 'Food'),
            Tab(icon: Icon(Icons.home), text: 'Housing'),
            Tab(icon: Icon(Icons.directions_car), text: 'Transportation'),
            Tab(icon: Icon(Icons.devices), text: 'Usage'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ClothingPage(controller13: _controller13, controller14: _controller14, controller15: _controller15),
          FoodPage(controller10: _controller10, controller11: _controller11, controller12: _controller12),
          HousingPage(controller7: _controller7, controller8: _controller8, controller9: _controller9),
          TransportationPage(controller4: _controller4, controller5: _controller5, controller6: _controller6),
          UsagePage(controller1: _controller1, controller2: _controller2, controller3: _controller3, 
          controller4: _controller4, controller5: _controller5, controller6: _controller6,
          controller7: _controller7, controller8: _controller8, controller9: _controller9,
          controller10: _controller10, controller11: _controller11, controller12: _controller12,
          controller13: _controller13, controller14: _controller14, controller15: _controller15),
        ],
      ),
    );
  }
}

