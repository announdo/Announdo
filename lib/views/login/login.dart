import 'package:announdo/views/login/student_login.dart';
import 'package:announdo/views/login/admin_login.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold (
        appBar: AppBar (
          bottom: const TabBar(
            labelPadding: EdgeInsets.symmetric(vertical: 10),
            tabs: [
              Text("Student"),
              Text("Admin")
            ],
          ),
          title: const Text('Login'),
        ),
        body: const LoaderOverlay(
            child: TabBarView(
              children: [
                StudentLogin(),
                AdminLogin(),
              ],
            ),
        )
      ),
    );
  }
}