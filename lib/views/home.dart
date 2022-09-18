import 'dart:developer';

import 'package:announdo/backend/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("home"),
      ),
      body: Container(
        child: Column(
          children: [
            TextButton(onPressed: () async {
              Auth.logout();
              Navigator.of(context).pushReplacementNamed('/login');
            }, child: Text("Logout"))
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
    });
  }
}
