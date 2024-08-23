import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/Screens/CounterScreen.dart';
import 'package:task/Screens/listScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int _taskCount = 0;
  List<Widget> _widgetOptions = [];

  @override
  void initState() {
    super.initState();
    _loadItemCount();
  }

  //Lädt die Anzahl der Aufgaben aus SharedPrefences
  void _loadItemCount() async {
    final prefs = await SharedPreferences.getInstance();
    final itemCount = prefs.getInt("itemCount") ?? 0;
    setState(() {
      _taskCount = itemCount;
      _widgetOptions = [
        listScreen(updateItemCount: _updateItemCount),
        CounterScreen(taskCount: _taskCount),
      ];
    });
  }

  void _updateItemCount(int count) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("itemCount", count);
    setState(() {
      _taskCount = count;
      _widgetOptions[1] = CounterScreen(taskCount: _taskCount);
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_widgetOptions.isEmpty) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Aufgaben"),
          BottomNavigationBarItem(
              icon: Icon(Icons.show_chart), label: "Statistik")
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.purple,
        onTap: _onItemTapped,
      ),
    );
  }
}
