import 'package:announdo/View/school_log.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SplashScreen();
  }
}

class _SplashScreen extends State<SplashScreen>{
  final int splashtime = 5; 
  // duration of splash screen on second

  @override
  void initState() {
    Future.delayed(Duration(seconds: splashtime), () async {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context){
              return const loginApp12();       
        }));
    }); 

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/announdo.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(),
      ),
    );
  }
}