import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'global.dart' as gl;
import '../firebase_options.dart';

class TeacherLoginAUth extends StatefulWidget {
  const TeacherLoginAUth({ Key? key }) : super(key: key);

  @override
  State<TeacherLoginAUth> createState() => _TeacherLoginAUthState();
}

class _TeacherLoginAUthState extends State<TeacherLoginAUth> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
  String dropdownvalue = 'School';
  String stats = 'None'; 
  
  // List of items in our dropdown menu
  var items = [    
    'Thornhill Secondary School',
    'Your school is not available yet',
    'School',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Teacher login"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Login to change the Announcement:'),
            const Text('YOU NEED TO BE A AUTHORIZED TEACHER TO CHANGE INFO!'),
              TextField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextField(
                controller: _password,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(
                  labelText: 'Password',
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
    
                  final email = _email.text;
                  final password = _password.text;
                  if (dropdownvalue == "Thornhill Secondary School"){
                    try {
                      final userCredential = 
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                      );
                      print(userCredential);
                      Navigator.of(context).pushNamedAndRemoveUntil('/changeAuthAnnouncement', (route) => false);

                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print('User not found');
                      } else if (e.code == 'wrong-password') {
                        print('Wrong password');
                      }
                    }
                  } else {
                    print("Not a valid school");
                  }
                  }, 
                  child: const Text('Login')
                  ),
          ],
        ),
      ),
    );
  }
}