import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:otp/otp.dart';

class loginApp12 extends StatefulWidget {
  const loginApp12({ Key? key }) : super(key: key);

  @override
  State<loginApp12> createState() => _loginApp12State();
}

class _loginApp12State extends State<loginApp12> {
    late final TextEditingController _password;
    String _errorMessage = "";
    ConnectivityResult? _connectivityResult;
    late StreamSubscription _connectivitySubscription;
    bool _isConnectionSuccessful = false;

    @override
    initState() {
      super.initState();
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
    dispose() {
      super.dispose();
      _password.dispose();
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
  
  String dropdownvalue = 'School';
  String mesa = "";
  String stats = 'None'; 
  var items = ['Thornhill Secondary School', 'Your school is not available yet', 'School'];
  bool sch = false;
  @override
  Widget build(BuildContext context) {
    if (dropdownvalue == "Thornhill Secondary School") {
      setState(() {
        mesa = "Please enter the school password!";
      });
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
                TextField(
                  // controller: _email,
                  cursorColor: const Color.fromRGBO(8, 65, 92, 1),
                  keyboardType: TextInputType.emailAddress,
                  enableSuggestions: false,
                  autocorrect: false,
                  scrollPadding: const EdgeInsets.all(10.0),
                  maxLines: 1,
                  enabled: sch,
                  scrollPhysics: const BouncingScrollPhysics(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'Lato',
                    // color: const Color.fromRGBO(8, 65, 92, 1),
                  ),
                  decoration: InputDecoration(
                    labelText: 'School Password',
                    // errorText: 'Invalid Password',
                    suffixIcon: IconButton(onPressed: () {
                      setState(() {
                        mesa = code;
                      });
                    }, icon: const Icon(Icons.send)),
                    // errorText: _validate ? _errorMessage : null,
                  ),
                ),
                const SizedBox(height: 20),
                Text(mesa),
                const SizedBox(height: 20),
                TextField(
                  controller: _password,
                  cursorColor: Color.fromRGBO(8, 65, 92, 1),
                  keyboardType: TextInputType.emailAddress,
                  enableSuggestions: false,
                  autocorrect: false,
                  scrollPadding: EdgeInsets.all(10.0),
                  maxLines: 1,
                  enabled: sch,
                  scrollPhysics: BouncingScrollPhysics(),
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Lato',
                    // color: const Color.fromRGBO(8, 65, 92, 1),
                  ),
                  decoration: InputDecoration(
                    labelText: 'Code',
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(56, 134, 151, 1),
                  ),
                  child: const Text('Enter', style: TextStyle(fontFamily: 'Lato-bold', fontSize: 22.0, color: Colors.white)),
                  onPressed: () {
                    if (_isConnectionSuccessful == true) {
                      final password = _password.text;
                      if (password == code.toString()) {
                        String _errorMessage = '';
                        if (dropdownvalue == 'Thornhill Secondary School'){
                          Navigator.of(context).pushReplacementNamed('/TSS_school');
                        } else{
                          _errorMessage = 'School not available yet';
                        }
                      } else {
                        _errorMessage = 'No internet connection';
                        _tryConnection();
                      }
                    } else {
                      _errorMessage = 'Wrong code try again!';
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
