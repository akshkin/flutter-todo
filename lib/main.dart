import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/pages/home.dart';
import 'package:todo/theme/themes.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
      theme: Themes.lightTheme(),
      darkTheme: Themes.darkTheme(),
      themeMode: ThemeMode.system,
      // theme: ThemeData(

      //   useMaterial3: true,
      //   // colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo)
      //   floatingActionButtonTheme: const FloatingActionButtonThemeData(
      //     backgroundColor: Color.fromARGB(255, 150, 230, 239),
      //   ),
      //   actionIconTheme: ActionIconThemeData(
      //     backButtonIconBuilder: (context) =>
      //         const Icon(Icons.chevron_left_rounded),
      //   ),
      //   appBarTheme: const AppBarTheme(
      //     centerTitle: true,

      //     // backgroundColor: Color.fromARGB(255, 27, 148, 176),
      //     // foregroundColor: Colors.white,
      //   ),
      // ),
    );
  }
}
