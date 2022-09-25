import 'dart:developer';

import 'package:announdo/backend/auth.dart';
import 'package:announdo/views/lang.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

class StudentLogin extends StatefulWidget {
  const StudentLogin({Key? key}) : super(key: key);

  @override
  State<StudentLogin> createState() => _StudentLoginState();
}

class _StudentLoginState extends State<StudentLogin> {
  late final TextEditingController _code;
  String? errorText = null;

  @override
  initState() {
    super.initState();
    _code = TextEditingController();
  }

  @override
  dispose() {
    super.dispose();
    _code.dispose();
  }

  Future login() async {
    context.loaderOverlay.show();
    setState(() {
      errorText = null;
    });
    var res = await Auth.login(_code.value.text);
    if (res) {
      Navigator.of(context).pushReplacementNamed('/');
    }
    else {
      setState(() {
        errorText = "Invalid Access Code";
      });
    }
    context.loaderOverlay.hide();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              children: [
                Text(
                    Lang.schoolAbbr,
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline1
                ),
                Text(
                    "Announcements App - Student Login",
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText2
                ),
                SizedBox.fromSize(size: Size.fromHeight(20)),
                Text(
                    "Please enter the access code provided to you by your teacher.",
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText2
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: TextField(
                        controller: _code,
                        keyboardType: TextInputType.text,
                        enableSuggestions: false,
                        textCapitalization: TextCapitalization.characters,
                        autocorrect: false,
                        scrollPadding: const EdgeInsets.all(10.0),
                        maxLines: 1,
                        scrollPhysics: const BouncingScrollPhysics(),
                        decoration: InputDecoration(
                            labelText: 'Access Code',
                            errorText: errorText
                        ),
                        onSubmitted: (x) => login(),
                      ),
                    ),
                    Expanded(
                      child: TextButton(onPressed: login, child: const Text("Login")),
                    )
                  ],
                ),
                SizedBox.fromSize(size: Size.fromHeight(10)),
                Text(
                    "Unauthorized access is strictly prohibited, only students attending ${Lang
                        .schoolName} are permitted.",
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodySmall
                        ?.merge(TextStyle(color: Colors.red))
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}