import 'package:flutter/material.dart';
import 'package:flutter_wt_wiki/widgets/homedrawer.dart';
import '../widgets/carditem.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Home')),
        drawer: const HomeDrawer(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CardItem(
                imageUrl:
                    "https://wiki.warthunder.com/images/d/de/Img_plane.png",
                title: "AVIATION",
                onTap: () {
                  // Handle tap
                },
              ),
              CardItem(
                imageUrl:
                    "https://wiki.warthunder.com/images/4/4f/Img_tank.png",
                title: "GROUND FORCES",
                onTap: () {
                  // Handle tap
                },
              ),
              CardItem(
                imageUrl:
                    "https://wiki.warthunder.com/images/c/c7/Img_ship.png",
                title: "FLEET",
                onTap: () {
                  // Handle tap
                },
              ),
            ],
          ),
        ));
  }
}
