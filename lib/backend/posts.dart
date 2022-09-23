import 'package:announdo/backend/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Posts {
  static late FirebaseFirestore _db;
  static void initialize(){
    _db = FirebaseFirestore.instance;
  }

  static Query<Map<String, dynamic>> buildQuery() {
    return _db.collection("posts");
  }
}