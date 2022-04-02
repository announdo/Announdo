import 'dart:async';
import 'package:announdo/View/school_log.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  	
  ConnectivityResult? _connectivityResult;
 
  Future<void> _checkConnectivityState() async {
    final ConnectivityResult result = await Connectivity().checkConnectivity();
 
    if (result == ConnectivityResult.wifi) {
      print('Connected to a Wi-Fi network');
    } else if (result == ConnectivityResult.mobile) {
      print('Connected to a mobile network');
    } else {
      print('Not connected to any network');
    }
 
    setState(() {
      _connectivityResult = result;
    });
  }

  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 5),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const loginApp12())));
  }

  @override
  Widget build(BuildContext context) {
    _checkConnectivityState();
    return const Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}