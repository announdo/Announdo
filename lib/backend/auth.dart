import 'dart:developer';

import 'package:announdo/backend/tickets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Auth {
  static String? token;
  static Future<bool> isLoggedIn() async {
    if(FirebaseAuth.instance.currentUser == null) return false;
    if((await getAuthExpiry()).compareTo(DateTime.now().toUtc()) <= 0){
      // logout
      await logout();
      return false;
    }
    return true;
  }
  static Future<DateTime> getAuthExpiry() async {
    var result = await FirebaseAuth.instance.currentUser!.getIdTokenResult(false);
    if(result.claims!.containsKey("expiry")){
      var expiry = result.claims!["expiry"];
      return DateTime.fromMillisecondsSinceEpoch(expiry * 1000, isUtc: true);
    }
    return DateTime.utc(275760,09,13);
  }
  static Future<bool> login(String phrase) async {
    try{
      var token = await Tickets.getAuthToken(phrase);
      if(token == null){
        return false;
      }
      await FirebaseAuth.instance.signInWithCustomToken(token);
      return true;
    }
    catch(e){
      log(e.toString());
    }
    return false;
  }
  static Future logout() async {
    if(FirebaseAuth.instance.currentUser != null) await FirebaseAuth.instance.signOut();
    await FirebaseFirestore.instance.terminate();
    await FirebaseFirestore.instance.clearPersistence();
  }
}