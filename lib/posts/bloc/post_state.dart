part of 'post_bloc.dart';

enum PostStatus { initial, success, failure }
class PostState extends Equatable {
  const PostState({
    this.status = PostStatus.initial,
    this.posts = const <Result>[],
    this.hasReachedMax = false,
  });

  final PostStatus status;
  final List<Result> posts;
  final bool hasReachedMax;

  PostState copyWith({
    PostStatus status,
    List<Result> posts,
    bool hasReachedMax,
  }) {
    return PostState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [status, posts, hasReachedMax];

}