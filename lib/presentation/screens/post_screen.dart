import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uip_tv/core/theme/theme_class.dart';
import '../../domain/entities/post_entity.dart';
import '../bloc/post_bloc/post_bloc.dart';
import '../bloc/post_bloc/post_state.dart';

class PostScreen extends StatefulWidget {
  static String routeName = '/post';
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  bool? isOffline; // Null means checking status

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
  }
  
  void _checkConnectivity() async {
    List<ConnectivityResult> connectivityResults =
        await Connectivity().checkConnectivity();
    bool hasNetwork =
        connectivityResults.isNotEmpty &&
        !connectivityResults.contains(ConnectivityResult.none);

    // Manually verify by attempting to reach Google
    try {
      final result = await InternetAddress.lookup('google.com');
      hasNetwork = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      hasNetwork = false;
    }

    if (mounted) {
      setState(() {
        isOffline = !hasNetwork;
      });
    }

    Connectivity().onConnectivityChanged.listen((results) async {
      bool online =
          results.isNotEmpty && !results.contains(ConnectivityResult.none);
      try {
        final test = await InternetAddress.lookup('google.com');
        online = test.isNotEmpty && test[0].rawAddress.isNotEmpty;
      } catch (_) {
        online = false;
      }
      if (mounted) {
        setState(() {
          isOffline = !online;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeClass.primaryColor,
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
        backgroundColor: Colors.black54,
        elevation: 0,
      ),
      body: Column(
        children: [
          if (isOffline == null)
            Container(
              width: double.infinity,
              color: Colors.grey, // Neutral color while checking status
              padding: const EdgeInsets.all(8),
              child: const Center(
                child: Text("Checking network...", style: TextStyle(color: Colors.white)),
              ),
            )
          else
            Container(
              width: double.infinity,
              color: isOffline! ? Colors.redAccent : Colors.green,
              padding: const EdgeInsets.all(8),
              child: Center(
                child: Text(
                  isOffline! ? "You're offline. Showing cached posts." : "You're online. Fetching latest posts.",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          Expanded(
            child: BlocBuilder<PostBloc, PostState>(
              builder: (context, state) {
                if (state is PostInitial || state is PostLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                } else if (state is PostLoaded) {
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.posts.length,
                    itemBuilder: (context, index) {
                      PostEntity post = state.posts[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        color: Colors.grey[900],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post.title,
                                style: ThemeClass.subHeadingTextStyle,
                              ),
                              const SizedBox(height: 8),
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
          ),
        ],
      ),
    );
  }
}
