import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart'; // Import Connectivity
import '../../../domain/usecases/get_posts_usecase.dart';
import 'post_event.dart';
import 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetPostsUsecase getPostsUsecase;
  final Connectivity connectivity; // Add Connectivity

  PostBloc({required this.getPostsUsecase, required this.connectivity})
      : super(PostInitial()) {
    on<FetchPosts>(_onFetchPosts); // Listen for FetchPosts event
  }

  Future<void> _onFetchPosts(FetchPosts event, Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      // Check network connectivity
      final connectivityResult = await connectivity.checkConnectivity();
      final isOffline = connectivityResult == ConnectivityResult.none;

      // Fetch posts from the repository
      final posts = await getPostsUsecase.execute();

      // Emit the loaded state with offline status
      emit(PostLoaded(posts: posts, isOffline: isOffline));
    } catch (e) {
      emit(PostError('Failed to load posts. Please try again later.'));
    }
  }
}