import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final VoidCallback onTap;

  const CardItem({
    required this.imageUrl,
    required this.title,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(border: Border.all(color: Colors.red, width: 2), borderRadius: BorderRadius.circular(8.0)),
            child: InkWell(
                onTap: onTap,
                child: Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                    child: Stack(children: [
                      Align(alignment: Alignment.center, child: Image.network(imageUrl)),
                      Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(title, style: const TextStyle(fontSize: 30)),
                          ))
                    ])))));
  }
}
