import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart'; // Import Hive
import 'package:connectivity_plus/connectivity_plus.dart'; // Import Connectivity
import 'package:uip_tv/core/theme/theme_class.dart';
import 'package:uip_tv/data/datasources/remote_data_source.dart';
import 'package:uip_tv/data/repositories/post_repository_impl.dart';
import 'package:uip_tv/domain/entities/post_entity.dart'; // Import PostEntity
import 'package:uip_tv/domain/usecases/get_posts_usecase.dart';
import 'package:uip_tv/presentation/bloc/post_bloc/post_bloc.dart';
import 'package:uip_tv/presentation/bloc/post_bloc/post_event.dart';
import 'package:uip_tv/presentation/routes/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized

  // Initialize Hive
  await Hive.initFlutter();

  // Register the generated adapter
  Hive.registerAdapter(PostEntityAdapter()); // No error now

  // Open a Hive box for posts
  await Hive.openBox<PostEntity>('postsBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AppRouter appRouter = AppRouter(); // Initialize the router

    return BlocProvider(
      create: (context) {
        // Initialize dependencies
        final remoteDataSource = RemoteDataSource();
        final postRepository = PostRepositoryImpl(
          remoteDataSource: remoteDataSource,
        );
        final getPostsUsecase = GetPostsUsecase(postRepository: postRepository);
        final connectivity = Connectivity(); // Initialize Connectivity

        // Provide PostBloc and trigger FetchPosts event
        return PostBloc(
          getPostsUsecase: getPostsUsecase,
          connectivity: connectivity, // Pass Connectivity to PostBloc
        )..add(FetchPosts());
      },
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeClass.appTheme,
        title: 'UIP TV',
        routerConfig: appRouter.router, // Use Go Router
      ),
    );
  }
}
