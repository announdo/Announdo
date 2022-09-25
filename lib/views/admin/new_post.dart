import 'package:announdo/model/post.dart';
import 'package:announdo/views/admin/editor/post_editor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewPost extends StatefulWidget {
  const NewPost({Key? key}) : super(key: key);

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: PostEditor(
        post: Post(
            "description",
            "title",
            10,
            true,
            true,
            Timestamp.fromDate(DateTime.now().toUtc()),
            Timestamp.fromDate(DateTime.now().toUtc().add(Duration(days: 1))),
            [],
            "you"
        ),
        isAdmin: true,
      ),
    );
  }
}
