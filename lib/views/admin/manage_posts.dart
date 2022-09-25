import 'package:flutter/material.dart';

class ManagePosts extends StatefulWidget {
  const ManagePosts({Key? key}) : super(key: key);

  @override
  State<ManagePosts> createState() => _ManagePostsState();
}

class _ManagePostsState extends State<ManagePosts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.of(context).pushNamed("/new_post");
        },
      ),
    );
  }
}
