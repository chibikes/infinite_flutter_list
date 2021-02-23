import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:mylist_flutter/posts/models/post.dart';
import 'package:rxdart/rxdart.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {

  PostBloc({@required this.httpClient}) : super(const PostState());

  final http.Client httpClient;

  @override
  Stream<Transition<PostEvent, PostState>> transformEvents(
      Stream<PostEvent> events,
      TransitionFunction<PostEvent, PostState> transitionFn,
      ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (event is PostFetched) {
      yield await _mapPostFetchedToState(state);
    }
  }

  Future<PostState> _mapPostFetchedToState(PostState state) async {
    // if (state.hasReachedMax) return state;
    try {
      if (state.status == PostStatus.initial) {
        final results = await _fetchPosts();
        return state.copyWith(
          status: PostStatus.success,
          posts: results,
          hasReachedMax: _hasReachedMax(results.length),
        );
      }
      final posts = await _fetchPosts(state.posts.length);
      return posts.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
        status: PostStatus.success,
        posts: List.of(state.posts)..addAll(posts),
        hasReachedMax: _hasReachedMax(posts.length), // posts.length
      );
    } on Exception {
      return state.copyWith(status: PostStatus.failure);
    }
  }

  Future<List<Result>> _fetchPosts([int startIndex = 0]) async {
    final response = await httpClient.get(
     // 'https://jsonplaceholder.typicode.com/posts?_start=$startIndex&_limit=$_postLimit',
        'https://opentdb.com/api.php?amount=10',
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body);//.cast<Map<String, dynamic>>(); /// body is now a Map<String, dynamic> => Map<String, int>, Map<"results", List<results> u may have to cast it

      Post posts = Post.fromJson(body);
      List<Result> results = posts.results;
      return results;
      // return body.map((dynamic json) {
      //   return Result(
      //
      //     // response: json['response'] as int,
      //     results: json['results'] as List<Result>,
      //     // // body: json['body'] as String,
      //   );
      // }).toList();
    }
    throw Exception('error fetching posts');
  }

  bool _hasReachedMax(int postsCount) => false;
// ? false : true;


}