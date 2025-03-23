import 'package:equatable/equatable.dart';
import '../../../domain/entities/post_entity.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<PostEntity> posts;
  final bool isOffline; // Add isOffline flag

  const PostLoaded({required this.posts, this.isOffline = false});

  @override
  List<Object> get props => [posts, isOffline]; // Include isOffline in props
}

class PostError extends PostState {
  final String message;

  const PostError(this.message);

  @override
  List<Object> get props => [message];
}