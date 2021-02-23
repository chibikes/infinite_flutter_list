import 'package:flutter/material.dart';
import 'package:mylist_flutter/posts/models/post.dart';


class PostListItem extends StatelessWidget {
  const PostListItem({Key key, @required this.post}) : super(key: key);

  final Result post;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
      // leading: Text('${post.id}', style: textTheme.caption),
      title: Text(post.category),
      isThreeLine: true,
      subtitle: Text(post.correctAnswer),
      dense: true,
    );
  }
}
