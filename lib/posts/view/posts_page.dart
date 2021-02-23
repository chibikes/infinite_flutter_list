import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_infinite_list/posts/posts.dart';
import 'package:http/http.dart' as http;
import 'package:mylist_flutter/posts/bloc/post_bloc.dart';
import 'package:mylist_flutter/posts/view/posts_list.dart';

class PostsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: BlocProvider(
        create: (_) => PostBloc(httpClient: http.Client())..add(PostFetched()),
        child: PostsList(),
      ),
    );
  }
}
