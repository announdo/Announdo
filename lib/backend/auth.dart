import 'package:announdo/backend/tickets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Auth {
  static String? token;
  static Future<bool> isLoggedIn() async {
    if(FirebaseAuth.instance.currentUser != null) return true;
    if(token == null){
      final prefs = await SharedPreferences.getInstance();
      token = prefs.getString("token");
    }
    return token != null;
  }
  static Future<bool> login(String phrase) async {
    var ticket = await Tickets.getAuthToken(phrase);
    if(ticket == null){
      return false;
    }
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("token", ticket.token!);
    token = ticket.token;
    return true;
  }
  static Future logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
  }
}

extension AuthExtensions on Query<Map<String, dynamic>>{
  Query<Map<String, dynamic>> withAuth(){
    parameters['token'] = Auth.token;
    return this;
  }
}