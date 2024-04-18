import 'package:flutter/material.dart';
import 'ClothingPage.dart';
import 'FoodPage.dart';
import 'HousingPage.dart';
import 'TransportationPage.dart';
import 'UsagePage.dart';


class TopTabsExample extends StatefulWidget {
  @override
  _TopTabsExampleState createState() => _TopTabsExampleState();
}

class _TopTabsExampleState extends State<TopTabsExample> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
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
            borderRadius: BorderRadius.circular(25), // Use a high value for circular
            color: Colors.green, // Tab background color
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
          ClothingPage(category: 'Clothing'),
          FoodPage(category: 'Food',),
          HousingPage(category: 'Housing'),
          TransportationPage(category: 'Transportation',),
          UsagePage(category: 'Usage'),
        ],
      ),
    );
  }
}

