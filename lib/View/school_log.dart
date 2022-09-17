import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:otp/otp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'global.dart' as gl;
class loginApp12 extends StatefulWidget {
  const loginApp12({ Key? key }) : super(key: key);

  @override
  State<loginApp12> createState() => _loginApp12State();
}

class _loginApp12State extends State<loginApp12> {
    late final TextEditingController _password;
    late final TextEditingController _school;
    String _errorMessage = "";
    ConnectivityResult? _connectivityResult;
    late StreamSubscription _connectivitySubscription;
    bool _isConnectionSuccessful = false;

    @override
    initState() {
      super.initState();
      _password = TextEditingController();
      _school = TextEditingController();
      _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
          ConnectivityResult result
      ) {
        setState(() {
          _connectivityResult = result;
        });
      });
    }

    @override
    dispose() {
      super.dispose();
      _password.dispose();
      _school.dispose();
      _connectivitySubscription.cancel();
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

  String dropdownvalue = 'Thornhill Secondary School';
  String mesa = "";
  String stats = 'None';
  var items = ['Thornhill Secondary School', 'Your school is not available yet'];
  bool sch = false;
  Color k = Colors.white;

  @override
  Widget build(BuildContext context) {
    if (dropdownvalue == "Thornhill Secondary School") {
      sch = true;
    } else {
      sch = false;
    }
    String code = OTP.generateTOTPCodeString(
    'ANNONDOTHORNHILL', DateTime.now().millisecondsSinceEpoch, isGoogle:true, interval: 120, algorithm: Algorithm.SHA256, length: 5);
    _tryConnection();
    return Scaffold(
      backgroundColor: const Color.fromRGBO(8, 65, 92, 1),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(56, 134, 151, 1),
        title: const Text("Login", style: TextStyle(fontFamily: 'Lato-bold')),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_errorMessage, style: const TextStyle(color: Colors.red, fontSize: 20.0, fontFamily: 'Lato-bold'), textAlign: TextAlign.center,),
                const SizedBox(height: 20),
                const Text('Choose your school:', style: TextStyle(fontFamily: 'Lato-bold', fontSize: 25.0, color: Colors.white), textAlign: TextAlign.center,),
                const SizedBox(height: 20),
                DropdownButton(
                  style: const TextStyle(fontFamily: 'Lato-bold', fontSize: 20.0, color: Colors.white),
                  dropdownColor: const Color.fromRGBO(56, 134, 151, 1),
                  value: dropdownvalue,
                  borderRadius: BorderRadius.circular(10),
                  iconSize: 30,
                  iconDisabledColor: Colors.black,
                  iconEnabledColor: const Color.fromRGBO(204, 41, 54, 1),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Container (
                  width: 300,
                  child: TextField(
                    controller: _school,
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.text,
                    enableSuggestions: false,
                    textCapitalization: TextCapitalization.characters,
                    autocorrect: false,
                    scrollPadding: const EdgeInsets.all(10.0),
                    maxLines: 1,
                    enabled: sch,
                    scrollPhysics: const BouncingScrollPhysics(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Lato',
                    ),
                    decoration: InputDecoration(
                      labelText: 'School Password',
                      suffixIconColor: Colors.white,
                      labelStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Lato',
                      ),
                      // errorText: 'Invalid Password',
                      suffixIcon: IconButton(onPressed: () {
                        if (_school.text == "ANNONDOTHORNHILL") {
                          setState(() {
                            mesa = code;
                            k = Colors.white;
                        });
                        } else {
                          setState(() {
                            mesa = "Wrong Password";
                            k = Colors.red;
                        });
                        }

                      }, icon: const Icon(Icons.send, color: Color.fromARGB(255, 202, 202, 202),),),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(mesa, style: TextStyle(fontFamily: 'Lato-bold', fontSize: 18.0, color: k), textAlign: TextAlign.center),
                const SizedBox(height: 5),
                Container (
                  width: 300,
                  child: TextField(
                  controller: _password,
                  cursorColor: Color.fromRGBO(8, 65, 92, 1),
                  keyboardType: TextInputType.numberWithOptions(),
                  enableSuggestions: false,
                  autocorrect: false,
                  scrollPadding: EdgeInsets.all(10.0),
                  maxLines: 1,
                  enabled: sch,
                  scrollPhysics: BouncingScrollPhysics(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Lato',
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Code',
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Lato',
                    ),
                  ),
                ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(56, 134, 151, 1),
                  ),
                  child: const Text('Enter', style: TextStyle(fontFamily: 'Lato-bold', fontSize: 22.0, color: Colors.white)),
                  onPressed: () async{
                    if (_isConnectionSuccessful == true) {
                      final prefs = await SharedPreferences.getInstance();
                      final password = _password.text;
                      if (password == code.toString()) {
                        String _errorMessage = '';
                        if (dropdownvalue == 'Thornhill Secondary School'){
                          Navigator.of(context).pushReplacementNamed('/TSS_school');
                          gl.veri = 1;
                          prefs.setInt('verified', gl.veri);
                        } else{
                          _errorMessage = 'School not available yet';
                        }
                      } else {
                        _errorMessage = 'Wrong code try again!';
                      }
                    } else {
                      _errorMessage = 'No internet connection';
                      _tryConnection();
                    }
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
        ),
      ),
    );
  }
}
