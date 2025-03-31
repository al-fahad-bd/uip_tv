import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uip_tv/core/theme/theme_class.dart';
import '../../domain/entities/post_entity.dart'; // Use PostEntity instead of Post
import '../bloc/post_bloc/post_bloc.dart';
import '../bloc/post_bloc/post_state.dart';

class PostScreen extends StatelessWidget {
  static String routeName = '/post';
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeClass.primaryColor, // Match the background color
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
            size: 14,
          ),
          onPressed: () => context.pop(),
        ),
        title: Center(child: Text('Posts', style: ThemeClass.headingTextStyle)),
        actions: [],
        backgroundColor: Colors.black54, // Dark app bar
        elevation: 0,
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostInitial || state is PostLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white, // White loading indicator
              ),
            );
          } else if (state is PostLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.all(16), // Add padding
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                PostEntity post = state.posts[index]; // Use PostEntity
                return Card(
                  margin: const EdgeInsets.only(
                    bottom: 16,
                  ), // Space between cards
                  color: Colors.grey[900], // Dark card background
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16), // Inner padding
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(post.title, style: ThemeClass.subHeadingTextStyle),
                        const SizedBox(
                          height: 8,
                        ), // Space between title and body
                        Text(post.body, style: ThemeClass.greyTextStyle),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is PostError) {
            return Center(
              child: Text(state.message, style: ThemeClass.bodyTextStyle),
            );
          }
          return Container();
        },
      ),
    );
  }
}
