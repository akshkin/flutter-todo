import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todo/pages/active.dart';
import 'package:todo/pages/add.dart';
import 'package:todo/pages/completed.dart';
import 'package:todo/pages/metrics.dart';
import 'package:todo/theme/colors.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const ActiveTodos(),
    const CompletedTodos(),
    Metrics()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            PageTransition(
              type: PageTransitionType.bottomToTop,
              duration: const Duration(milliseconds: 400),
              reverseDuration: const Duration(milliseconds: 400),
              child: const AddTodo(),
            ),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.incomplete_circle),
            label: 'Active',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: 'Completed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Metrics',
          ),
        ],
        onTap: (value) => {
          setState(() {
            _selectedIndex = value;
          })
        },
        currentIndex: _selectedIndex,
        selectedItemColor: ColorPallete.blueDark,
      ),
    );
  }
}
