import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';

class Tickets {
  static late FirebaseFirestore _db;
  static const String apiEndpoint = "https://auth.encodeous.cc";
  static void initialize(){
    _db = FirebaseFirestore.instance;
  }

  static Future<String?> getAuthToken(String phrase) async {
    var url = "$apiEndpoint/auth/login";
    var body = json.encode(phrase);

    Map<String,String> headers = {
      'Content-type' : 'application/json',
      'Accept': 'text/plain',
    };
    var response = await http.post(Uri.parse(url), body: body, headers: headers);

    if(response.statusCode == 200){
      return response.body;
    }else{
       return null;
    }
  }
  /// Returns true if the auth ticket was made, otherwise the phrase already exists
  static Future<bool> makeAuthTicket(String phrase, Timestamp phraseExpiry, Timestamp tokenExpiry) async {
    var ticketRef = _db.collection("tickets");
    var prevTicket = await getAuthToken(phrase);
    if(prevTicket != null) return false;
    final token = <String, dynamic>{
      "expiry": tokenExpiry,
      "type": 'auth'
    };
    var newToken = await _db.collection('tokens').add(token);
    final ticket = <String, dynamic>{
      "phraseExpiry": tokenExpiry,
      "token": newToken.id
    };
    ticketRef.doc(phrase).set(ticket);
    return true;
  }
}