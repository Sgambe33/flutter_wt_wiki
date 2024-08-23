import 'package:flutter/material.dart';
import 'package:flutter_wt_wiki/constants.dart';
import 'package:flutter_wt_wiki/screens/home_screen.dart';
import 'package:flutter_wt_wiki/screens/stats_screen.dart';
import 'package:flutter_wt_wiki/screens/vehicle_screen.dart';
import 'package:flutter_wt_wiki/widgets/modifications_expansion.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      // Use system theme mode
      initialRoute: '/stats',
      routes: {
        '/': (context) => const HomeScreen(),
        '/vehicle': (context) => const VehicleScreen(),
        '/stats': (context) => StatsScreen(),
      },
    );
  }
}

void main() {
  runApp(const MainApp());
}
