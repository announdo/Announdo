import 'package:announdo/model/post.dart';
import 'package:flutter/material.dart';

class PostEditor extends StatelessWidget {
  const PostEditor({Key? key, required this.post, required this.isAdmin}) : super(key: key);
  final Post post;
  final bool isAdmin;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Creating a new post."),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.title),
                  label: Text("Title"),
                  helperText: "You want to keep this short"
                ),
                initialValue: post.title,
                onChanged: (x){
                  post.title = x;
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
