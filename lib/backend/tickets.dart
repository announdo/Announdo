import 'dart:developer';

import 'package:announdo/model/auth_ticket.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Tickets {
  static late FirebaseFirestore _db;
  static void initialize(){
    _db = FirebaseFirestore.instance;
  }

  static Future<AuthToken?> getAuthToken(String phrase) async {
    var ticketRef = _db.collection("tickets").doc(phrase);
    try{
      var res = await ticketRef.get();
      var token = await _db.collection("tokens")
          .doc(res['token']).get();
      if(token['type'] != 'auth') return null;
      return AuthToken(token['expiry'], res['token']);
    }
    catch(e){
      log(e.toString());
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