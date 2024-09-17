import 'package:flutter/material.dart';
import 'package:flutter_wt_wiki/AppLocalisations.dart';
import 'package:flutter_wt_wiki/screens/home_screen.dart';
import 'package:flutter_wt_wiki/screens/localhost_integration.dart';
import 'package:flutter_wt_wiki/screens/search_page.dart';
import 'package:flutter_wt_wiki/screens/stats_screen.dart';
import 'package:flutter_wt_wiki/screens/vehicle_screen.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'CustomFont', // Set default font family
      ),
      darkTheme: ThemeData.dark().copyWith(
        textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'CustomFont'),
      ),
      themeMode: ThemeMode.system,
      locale: const Locale('en'),
      localizationsDelegates: const [AppLocalizationsDelegate()],
      supportedLocales: const [Locale('en')],
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/vehicle') {
          final String vehicleId = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) {
              return VehicleScreen(vehicleIdentifier: vehicleId);
            },
          );
        }
        return null;
      },
      routes: {
        '/': (context) => const HomeScreen(),
        '/stats': (context) => StatsScreen(),
        '/search': (context) => const SearchPage(),
        '/map': (context) => const LocalHostIntegration(),
      },
    );
  }
}

void main() {
  runApp(const MainApp());
}
