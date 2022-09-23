import 'dart:developer';

import 'package:announdo/backend/auth.dart';
import 'package:announdo/backend/posts.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> _posts = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("home"),
      ),
      body: Container(
        child: Column(
          children: [
            TextButton(
                onPressed: () async {
                  Auth.logout();
                  Navigator.of(context).pushReplacementNamed('/login');
                },
                child: Text("Logout")
            ),
            TextButton(
                onPressed: () async {
                  await refreshPost();
                },
                child: Text("Refresh")
            ),
            ..._posts.map((e) =>
                Text(e)
            ).toList()
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future(() async {
      try {
        if (!await Auth.isLoggedIn()) {
          Navigator.of(context).pushReplacementNamed('/login');
        }
      } catch (e) {
        log(e.toString());
      }
      await refreshPost();
    });
  }
  Future<void> refreshPost() async {
    try{
      var posts = await Posts.buildQuery().get();
      setState(() {
        for(var post in posts.docs){
          _posts.add(post['description']);
        }
      });
    }catch(e){
      setState(() {
        _posts = ["unable to load :(", "exception: ${e.toString()}"];
      });
      log(e.toString());
    }
  }
}
