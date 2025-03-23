import 'package:flutter/material.dart';
import 'package:uip_tv/core/theme/theme_class.dart';
import 'package:uip_tv/core/widgets/custom_bottom_navbar.dart';
import 'package:uip_tv/core/widgets/section_header.dart';
import 'package:uip_tv/presentation/widgets/trending_movies_section.dart';
import 'package:uip_tv/presentation/widgets/continue_watching_section.dart';
import 'package:uip_tv/presentation/widgets/recommended_movies_section.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedCategory; // Track the selected category

  // Sample movie lists
  final List<Map<String, String>> trendingMovies = [
    {'image': 'assets/images/yes_i_do.png', 'title': 'Yes I Do'},
    {'image': 'assets/images/inside_out_2.png', 'title': 'Inside Out 2'},
    {'image': 'assets/images/venom.png', 'title': 'Venom'},
    {'image': 'assets/images/soulmate.png', 'title': 'Solemate'},
    {'image': 'assets/images/sunita.png', 'title': 'Sunita'},
    {
      'image': 'assets/images/detective_pikachu.png',
      'title': 'Pokemon: Detective Pikachu',
    },
  ];

  final List<Map<String, String>> continueWatching = [
    {
      'image': 'assets/images/wednesday.png',
      'title': 'Wednesday | Season - 1 | Episode - 3',
    },
    {
      'image': 'assets/images/emily_in_paris.png',
      'title': 'Emily in Paris | Season - 1 | Episode - 1',
    },
  ];

  final List<Map<String, String>> recommendedMovies = [
    {'image': 'assets/images/soulmate.png', 'title': 'Solemate'},
    {'image': 'assets/images/sunita.png', 'title': 'Sunita'},
    {
      'image': 'assets/images/detective_pikachu.png',
      'title': 'Pokemon: Detective Pikachu',
    },
    {'image': 'assets/images/yes_i_do.png', 'title': 'Yes I Do'},
    {'image': 'assets/images/inside_out_2.png', 'title': 'Inside Out 2'},
    {'image': 'assets/images/venom.png', 'title': 'Venom'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeClass.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hello Rafsan', style: ThemeClass.headingTextStyle),
                      Text(
                        "Let's watch today",
                        style: ThemeClass.greyTextStyle,
                      ),
                    ],
                  ),
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/profile.png'),
                    radius: 22,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[800],
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 20,
                  ),
                  hintText: 'Search',
                  hintStyle: ThemeClass.greyTextStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 0,
                    minHeight: 0,
                  ),
                  suffixIcon: const Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Icon(Icons.search, color: Colors.white70),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SectionHeader(title: 'Categories'),
              Row(
                children: [
                  CategoryButton(
                    text: 'All',
                    isSelected: selectedCategory == 'All', // Check if selected
                    onPressed: () {
                      setState(() {
                        selectedCategory = 'All'; // Set 'Action' as selected
                      });
                    },
                  ),
                  CategoryButton(
                    text: 'Action',
                    isSelected:
                        selectedCategory == 'Action', // Check if selected
                    onPressed: () {
                      setState(() {
                        selectedCategory = 'Action'; // Set 'Action' as selected
                      });
                    },
                  ),
                  CategoryButton(
                    text: 'Anime',
                    isSelected:
                        selectedCategory == 'Anime', // Check if selected
                    onPressed: () {
                      setState(() {
                        selectedCategory = 'Anime'; // Set 'Anime' as selected
                      });
                    },
                  ),
                  CategoryButton(
                    text: 'Sci-fi',
                    isSelected:
                        selectedCategory == 'Sci-fi', // Check if selected
                    onPressed: () {
                      setState(() {
                        selectedCategory = 'Sci-fi'; // Set 'Sci-fi' as selected
                      });
                    },
                  ),
                  CategoryButton(
                    text: 'Thriller',
                    isSelected:
                        selectedCategory == 'Thriller', // Check if selected
                    onPressed: () {
                      setState(() {
                        selectedCategory =
                            'Thriller'; // Set 'Thriller' as selected
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.asset(
                    'assets/images/uncharted.png',
                    width: MediaQuery.of(context).size.width,
                    height: 165,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TrendingMoviesSection(movies: trendingMovies),
              ContinueWatchingSection(movies: continueWatching),
              RecommendedMoviesSection(movies: recommendedMovies),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String text;
  final bool isSelected; // Add isSelected parameter
  final VoidCallback? onPressed; // Optional callback for handling tap events

  const CategoryButton({
    super.key,
    required this.text,
    this.isSelected = false, // Default to false
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: GestureDetector(
        onTap: onPressed, // Handle tap events
        child: Chip(
          label: Text(
            text,
            style: TextStyle(
              color:
                  isSelected
                      ? Colors.black
                      : Colors.white, // Text color based on selection
            ),
          ),
          backgroundColor:
              isSelected
                  ? Colors.white
                  : Colors.grey[800], // Background color based on selection
          side:
              isSelected
                  ? BorderSide(color: Colors.black)
                  : BorderSide.none, // Add border for selected chip
        ),
      ),
    );
  }
}
