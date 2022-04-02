import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TeacherLoginAUth extends StatefulWidget {
  const TeacherLoginAUth({ Key? key }) : super(key: key);

  @override
  State<TeacherLoginAUth> createState() => _TeacherLoginAUthState();
}

class _TeacherLoginAUthState extends State<TeacherLoginAUth> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  String _errorMessage = '';
  bool _validate = false;
  bool _ps = false;
  String er = "";
  ConnectivityResult? _connectivityResult;
  late StreamSubscription _connectivitySubscription;
  bool _isConnectionSuccessful = false;

  Future<void> _checkConnectivityState() async {
    final ConnectivityResult result = await Connectivity().checkConnectivity();
    setState(() {
      _connectivityResult = result;
    });
  }
  Future<void> _tryConnection() async {
    try {
      final response = await InternetAddress.lookup('www.google.com');
      setState(() {
        _isConnectionSuccessful = response.isNotEmpty;
      });
    } on SocketException catch (e) {
      setState(() {
        _isConnectionSuccessful = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
        ConnectivityResult result
    ) {
      setState(() {
        _connectivityResult = result;
      });
    });
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _connectivitySubscription.cancel();
    super.dispose();
  }

  String dropdownvalue = 'School';
  String stats = 'None'; 
  var items = ['Thornhill Secondary School', 'Your school is not available yet', 'School'];



  @override
  Widget build(BuildContext context) {
    _tryConnection();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Teacher login"),
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil('/TSS_school', (route) => false);
          },
          color: Colors.black,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(er),
                const Text('Login to change the Announcement:'),
                const Text('YOU NEED TO BE A AUTHORIZED TEACHER TO CHANGE INFO!'),
                  TextField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      errorText: _validate ? _errorMessage : null,
                    ),
                  ),
                  TextField(
                    controller: _password,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      errorText: _validate ? _errorMessage : null,
                    ),
                  ),
                  const Text('Choose your school:',),
                  DropdownButton(
                    value: dropdownvalue,
                    icon: const Icon(Icons.keyboard_arrow_down),    
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) { 
                      if (!mounted) return;
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),
                  TextButton(
                    onPressed: () async {
                      if (_isConnectionSuccessful == true) {
                        er = "";
                        setState(() {
                        _email.text.isEmpty ? _validate = true : _validate = false;
                        _password.text.isEmpty ? _validate = true : _validate = false;
                        });
                        final email = _email.text;
                        final password = _password.text;
                        if (dropdownvalue == "Thornhill Secondary School"){
                          try {
                            final userCredential = 
                            await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: email,
                            password: password,
                            );
                            Navigator.of(context).pushNamedAndRemoveUntil('/changeAuthAnnouncement', (route) => false);
                            _validate = false;
                          } on FirebaseAuthException catch (e) {
                            print(e.code);
                            if (e.code == 'user-not-found' || e.code == 'invalid-email') {
                              print("User not found");
                              setState(() {
                                _errorMessage = 'Invalid email or password';
                                _validate = true;
                              });
                            } else if (e.code == 'wrong-password') {
                              print("Wrong pass");
                              setState(() {
                                _validate = true;
                                _errorMessage = 'Wrong password';
                              });
                            } else if (e.code == "unknown") {
                              print("Unknown error");
                              setState(() {
                                _validate = true;
                                _errorMessage = 'Email or password cannot be empty';
                              });
                            } else if (e.code == "too-many-requests") {
                              print("too-many-requests");
                              setState(() {
                                _validate = true;
                                _errorMessage = 'Too many requests have been made please try again later';
                              });
                            } else if (e.code == "network-request-failed") {
                              print('network-request-failed');
                              setState(() {
                                _validate = true;
                                _errorMessage = 'Network request failed please try again later';
                              });
                            } 
                          }
                        } else {
                          print("Not a valid school");
                          setState(() {
                            _validate = true;
                            _errorMessage = 'Please choose a valid school';
                            er = 'Not a valid school';
                          });
                        }
                      } else {
                        er = 'No internet connection';
                        _tryConnection();
                      }
                    },
                    child: const Text('Enter')
                    ),
              ],
            ),
        ),
      ),
    );
  }
}
