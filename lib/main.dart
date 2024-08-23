import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Screens/startScreen.dart';
import 'Screens/HomeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.robotoMonoTextTheme(Theme.of(context).textTheme),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        textTheme: GoogleFonts.robotoMonoTextTheme(
            ThemeData(brightness: Brightness.dark).textTheme),
      ),
      themeMode: ThemeMode.system,
      title: 'Checkliste App',
      initialRoute: '/',
      routes: {
        '/': (context) => StartScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
