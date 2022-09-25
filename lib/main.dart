import 'package:announdo/View/splashScreen.dart';
import 'package:announdo/backend/auth.dart';
import 'package:announdo/backend/posts.dart';
import 'package:announdo/backend/tickets.dart';
import 'package:announdo/firebase_options.dart';
import 'package:announdo/views/admin/admin_home.dart';
import 'package:announdo/views/login/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'View/TSS_school.dart';
import 'View/school_log.dart';
import 'View/teacher_Change.dart';
import 'View/teacher_Login.dart';
import 'views/home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // FirebaseFirestore.instance.settings = const Settings(
  //   host: '192.168.12.12:8080',
  //   sslEnabled: false,
  //   persistenceEnabled: false,
  // );
  // FirebaseAuth.instance.useAuthEmulator("192.168.12.12", 9099);
  Tickets.initialize();
  Posts.initialize();
  await Auth.isLoggedIn();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MaterialApp(
      title: 'Announdo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],

        // Define the default font family.
        fontFamily: 'Roboto',

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72.0),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: const Home(),
      routes: {
        '/login': (context) => const Login(),
        '/admin': (context) => const AdminHome(),
        '/school_log': (context) => const loginApp12(),
        '/TSS_school': (context) => const thornhill_inf(),
        '/teachersAuth': (context) => const TeacherLoginAUth(),
        '/changeAuthAnnouncement': (context) => const ChangeDatabase(),
      }
  )
  );
}

