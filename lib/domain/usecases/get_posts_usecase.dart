import '../repositories/post_repository.dart';
import '../entities/post_entity.dart';

class GetPostsUsecase {
  final PostRepository postRepository;

  GetPostsUsecase({required this.postRepository});

  Future<List<PostEntity>> execute() async {
    return await postRepository.getPosts();
  }
}