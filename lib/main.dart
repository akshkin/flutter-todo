import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: const MyHomePage(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: true,
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Color.fromARGB(255, 27, 148, 176)),
            appBarTheme: const AppBarTheme(centerTitle: true)));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
        backgroundColor: const Color.fromARGB(255, 27, 148, 176),
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
