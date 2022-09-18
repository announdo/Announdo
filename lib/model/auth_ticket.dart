import 'package:cloud_firestore/cloud_firestore.dart';

class AuthToken {
  Timestamp expiry;
  String? token;
  AuthToken(this.expiry, this.token);
}