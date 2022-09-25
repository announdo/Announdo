import 'package:announdo/backend/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Admin settings"),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              if(Auth.isAdmin()) _SettingItem(
                  onTap: () {

                  },
                  title: "Manage Access Codes",
                  desc: "Create or delete access codes used by students or staff."
              ),
              _SettingItem(
                  onTap: () {
                    Navigator.of(context).pushNamed('/manage_posts');
                  },
                  title: "Manage Posts",
                  desc: Auth.isAdmin() ? "Create, Publish or Delete posts." : "Create new posts."
              ),
            ],
          ),
        )
    );
  }
}

class _SettingItem extends StatelessWidget {
  const _SettingItem({Key? key, required this.onTap, required this.title, required this.desc}) : super(key: key);
  final GestureTapCallback? onTap;
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
      child: Card(
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        desc,
                        maxLines: 5,
                      )
                    ],
                  ),
                ),
                const Icon(Icons.keyboard_arrow_right),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
