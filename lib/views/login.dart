import 'dart:developer';

import 'package:announdo/backend/auth.dart';
import 'package:announdo/views/lang.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        body: const TabBarView(
          children: [
            StudentLogin(),
            AdminLogin(),
          ],
        ),
      ),
    );
  }
}

class StudentLogin extends StatefulWidget {
  const StudentLogin({Key? key}) : super(key: key);

  @override
  State<StudentLogin> createState() => _StudentLoginState();
}

class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  bool _isObscure = true;
  String? errorText = null;

  @override
  initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
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
                    "Announcements App - Admin/Staff Login",
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText2
                ),
                SizedBox.fromSize(size: Size.fromHeight(20)),
                Text(
                    "Please enter your credentials.",
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText2
                ),
                AutofillGroup(
                    child: Column(children: [
                      TextField(
                        controller: _email,
                        keyboardType: TextInputType.text,
                        enableSuggestions: false,
                        textCapitalization: TextCapitalization.characters,
                        autocorrect: false,
                        scrollPadding: const EdgeInsets.all(10.0),
                        maxLines: 1,
                        scrollPhysics: const BouncingScrollPhysics(),
                        autofillHints: const [AutofillHints.email],
                        decoration: InputDecoration(
                            labelText: 'Email',
                            errorText: errorText == null ? null : ""
                        ),
                      ),
                      TextField(
                        controller: _password,
                        keyboardType: TextInputType.text,
                        enableSuggestions: false,
                        textCapitalization: TextCapitalization.characters,
                        autocorrect: false,
                        scrollPadding: const EdgeInsets.all(10.0),
                        maxLines: 1,
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          errorText: errorText,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscure ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          ),
                        ),
                        scrollPhysics: const BouncingScrollPhysics(),
                        autofillHints: const [AutofillHints.password],
                      ),
                    ],
                    )),
                TextButton(onPressed: () async {
                  try {
                    errorText = "";
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: _email.value.text,
                      password: _password.value.text,
                    );
                    Navigator.of(context).pushReplacementNamed('/');
                  } on FirebaseAuthException catch (e) {
                    log(e.toString());
                    if (e.code == 'user-not-found' || e.code == 'invalid-email') {
                      setState(() {
                        errorText = 'Invalid email or password';
                      });
                    } else if (e.code == 'wrong-password') {
                      setState(() {
                        errorText = 'Wrong password';
                      });
                    } else if (e.code == "unknown") {
                      setState(() {
                        errorText = 'Email or password cannot be empty';
                      });
                    } else if (e.code == "too-many-requests") {
                      setState(() {
                        errorText = 'Too many requests have been made please try again later';
                      });
                    } else if (e.code == "network-request-failed") {
                      setState(() {
                        errorText = 'Network request failed please try again later';
                      });
                    }
                  }
                }, child: const Text("Login")),
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
                      ),
                    ),
                    Expanded(
                      child: TextButton(onPressed: () async {
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
                      }, child: const Text("Login")),
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