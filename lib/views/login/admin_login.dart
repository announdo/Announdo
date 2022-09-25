import 'dart:developer';

import 'package:announdo/backend/auth.dart';
import 'package:announdo/views/lang.dart';
import 'package:announdo/views/login/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loader_overlay/loader_overlay.dart';

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

  Future login() async {
    context.loaderOverlay.show();
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
                        onSubmitted: (x) => login(),
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
                        onSubmitted: (x) => login(),
                      ),
                    ],
                    )),
                TextButton(onPressed: login, child: const Text("Login")),
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