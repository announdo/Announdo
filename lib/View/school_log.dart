import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class loginApp12 extends StatefulWidget {
  const loginApp12({ Key? key }) : super(key: key);

  @override
  State<loginApp12> createState() => _loginApp12State();
}

class _loginApp12State extends State<loginApp12> {
    String _errorMessage = "";
    ConnectivityResult? _connectivityResult;
    late StreamSubscription _connectivitySubscription;
    bool _isConnectionSuccessful = false;
    
    @override
    initState() {
      super.initState();
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
      _connectivitySubscription.cancel();
    }
  
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
  
  String dropdownvalue = 'School';
  String stats = 'None'; 
  var items = ['Thornhill Secondary School', 'Your school is not available yet', 'School'];


  @override
  Widget build(BuildContext context) {
    _tryConnection();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_errorMessage),
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
                setState(() {
                  dropdownvalue = newValue!;
                });
              },
            ),
            TextButton(
              child: const Text('Login'),
              onPressed: () {
                Text('Is connection success: $_isConnectionSuccessful');
                if (_isConnectionSuccessful == true) {
                  _errorMessage = '';
                  if (dropdownvalue == 'Thornhill Secondary School'){
                  print("YES");
                  Navigator.of(context).pushReplacementNamed('/TSS_school');
                } else{
                  _errorMessage = 'School not available yet';
                };
                } else {
                  _errorMessage = 'No internet connection';
                  _tryConnection();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
