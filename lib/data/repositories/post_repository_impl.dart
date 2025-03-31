import 'package:hive/hive.dart'; // Import Hive
import '../../domain/repositories/post_repository.dart';
import '../../domain/entities/post_entity.dart';
import '../datasources/remote_data_source.dart';
import '../mappers/post_mapper.dart';

class PostRepositoryImpl implements PostRepository {
  final RemoteDataSource remoteDataSource;

  PostRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<PostEntity>> getPosts() async {
    try {
      // Fetch posts from the API
      final posts = await remoteDataSource.fetchPosts();
      final postEntities =
          posts.map((post) => PostMapper.toEntity(post)).toList();

      // Save posts to local storage
      final postsBox = Hive.box<PostEntity>('postsBox');
      await postsBox.clear(); // Clear old data
      await postsBox.addAll(postEntities); // Save new data

      return postEntities;
    } catch (e) {
      // If the API call fails, return cached data
      final postsBox = Hive.box<PostEntity>('postsBox');
      return postsBox.values.toList();
    }
  }
}
