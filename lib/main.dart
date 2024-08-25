import 'package:flutter/material.dart';
import 'package:flutter_wt_wiki/AppLocalisations.dart';
import 'package:flutter_wt_wiki/screens/home_screen.dart';

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
      routes: {
        '/': (context) => const HomeScreen(),
        //'/stats': (context) => StatsScreen(),
      },
    );
  }
}

void main() {
  runApp(const MainApp());
}
