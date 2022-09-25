import 'dart:developer';

import 'package:announdo/backend/auth.dart';
import 'package:announdo/backend/posts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:loader_overlay/loader_overlay.dart';

class Glance extends StatefulWidget {
  const Glance({Key? key}) : super(key: key);

  @override
  State<Glance> createState() => _GlanceState();
}

class _GlanceState extends State<Glance> {
  List<String> _posts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        child: const Icon(Icons.filter_alt),
        children: [
          SpeedDialChild(
              label: "Clear Filters",
              child: const Icon(Icons.delete)
          ),
          SpeedDialChild(
              label: "Filter By Date",
              child: const Icon(Icons.calendar_month)
          ),
          SpeedDialChild(
              label: "Search",
              child: const Icon(Icons.search)
          ),
        ],
        renderOverlay: true,
        overlayOpacity: 0,
        spaceBetweenChildren: 5,
        closeDialOnPop: true,
        useRotationAnimation: true,
        animationAngle: 90,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              child: ListView.builder(
                itemCount: _posts.length,
                scrollDirection: Axis.vertical,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_posts[index]),
                  );
                },
              ),
              onRefresh: () async {
                await refreshPosts();
              },
            ),
          ),
        ],
      ),
    );
  }

  Future refreshPosts() async {
    try {
      var posts = await Posts.buildQuery().get();
      _posts.clear();
      setState(() {
        for (var post in posts.docs) {
          _posts.add(post['description']);
        }
      });
    } catch (e) {
      setState(() {
        _posts = ["unable to load :(", "exception: ${e.toString()}"];
      });
      log(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    Future(() async {
      try {
        if (!await Auth.isLoggedIn()) {
          Navigator.of(context).pushReplacementNamed('/login');
        } else {
          await refreshPosts();
        }
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
