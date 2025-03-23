import 'package:flutter/material.dart';
import 'package:uip_tv/core/theme/theme_class.dart';
import 'package:uip_tv/core/widgets/section_header.dart';
import 'package:uip_tv/presentation/widgets/slanted_progress_bar.dart'; // Import SectionHeader

class ContinueWatchingSection extends StatelessWidget {
  final List<Map<String, String>> movies;

  const ContinueWatchingSection({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: 'Continue Watching'), // Use SectionHeader
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return ContinueWatchingCard(
                image: movie['image']!,
                title: movie['title']!,
              );
            },
          ),
        ),
      ],
    );
  }
}

class ContinueWatchingCard extends StatelessWidget {
  final String image;
  final String title;

  const ContinueWatchingCard({
    super.key,
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  image,
                  width: 180,
                  height: 100,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SlantedProgressBar(width: 20),
              ),
            ],
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: 150,
            child: Text(
              title,
              style: ThemeClass.greyTextStyle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
