import 'package:flutter/material.dart';
import 'package:uip_tv/core/theme/theme_class.dart';

class MovieCard extends StatelessWidget {
  final String image;
  final String title;

  const MovieCard({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              image,
              width: 110,
              height: 150,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: 120,
            child: Text(
              title,
              style: ThemeClass.greyTextStyle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
