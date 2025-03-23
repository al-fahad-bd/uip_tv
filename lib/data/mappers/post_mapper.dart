import '../models/post.dart';
import '../../domain/entities/post_entity.dart';

class PostMapper {
  static PostEntity toEntity(Post post) {
    return PostEntity(
      userId: post.userId,
      id: post.id,
      title: post.title,
      body: post.body,
    );
  }
}