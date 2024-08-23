import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'War Thunder Wiki',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              // Handle the tap
            },
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: const Text('Statistics'),
            onTap: () {
              Navigator.pushNamed(context, '/stats');
            },
          ),
          ListTile(
            enabled: false,
            leading: const Icon(Icons.rocket_launch_rounded),
            title: const Text('Rocket index (WIP)'),
            onTap: () {
              // Handle the tap
            },
          ),
          ListTile(
            enabled: false,
            leading: const Icon(Icons.radar),
            title: const Text('Radar index (WIP)'),
            onTap: () {
              // Handle the tap
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              // Handle the tap
            },
          ),
        ],
      ),
    );
  }
}
