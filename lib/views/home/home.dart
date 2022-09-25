import 'dart:developer';

import 'package:announdo/backend/auth.dart';
import 'package:announdo/backend/posts.dart';
import 'package:announdo/views/home/glance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tuple/tuple.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static const List<Tuple2<String, Widget>> _widgetOptions = <Tuple2<String, Widget>>[
    Tuple2(
      "At a glance",
      Glance(),
    ),
    Tuple2(
      "This week",
      Glance(),
    ),
    Tuple2(
      "Bulletin",
      Glance(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_widgetOptions.elementAt(_selectedIndex).item1),
        actions: [
          PopupMenuButton(
              itemBuilder: (context) {
                return [
                  const PopupMenuItem<int>(
                    value: 0,
                    child: Text("About"),
                  ),

                  const PopupMenuItem<int>(
                    value: 1,
                    child: Text("Logout"),
                  ),

                  const PopupMenuItem<int>(
                    value: 2,
                    child: Text("Settings"),
                  ),
                  // if(Auth.isAdmin())
                    const PopupMenuItem<int>(
                      value: 3,
                      child: Text("Admin"),
                    ),
                ];
              },
              onSelected: (value) {
                if (value == 0) {

                } else if (value == 1) {
                  Auth.logout();
                  Navigator.of(context).pushReplacementNamed('/login');
                } else if (value == 2) {

                } else if (value == 3) {
                  Navigator.of(context).pushNamed('/admin');
                }
              }
          ),
        ],
      ),
      body: LoaderOverlay(
        child: Scaffold(
          body: _widgetOptions.elementAt(_selectedIndex).item2,
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.view_stream),
                label: "At a glance"
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_view_week_rounded),
                  label: "Week"
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.push_pin),
                  label: "Bulletin"
              )
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
            onTap: (index){
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
