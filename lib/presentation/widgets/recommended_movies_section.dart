import 'package:flutter/material.dart';
import 'package:uip_tv/core/widgets/movie_card.dart'; // Import MovieCard
import 'package:uip_tv/core/widgets/section_header.dart'; // Import SectionHeader

class RecommendedMoviesSection extends StatelessWidget {
  final List<Map<String, String>> movies;

  const RecommendedMoviesSection({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: 'Recommended For You'), // Use SectionHeader
        SizedBox(
          height: 200,
          child: ListView.builder(
            padding: const EdgeInsets.only(right: 20),
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return MovieCard(image: movie['image']!, title: movie['title']!);
            },
          ),
        ),
      ],
    );
  }
}
