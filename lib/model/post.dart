import 'package:cloud_firestore/cloud_firestore.dart';

class Post{
  String description;
  String title;
  int priority;
  bool isApproved;
  bool isDraft;
  Timestamp showTime;
  Timestamp hideTime;
  List<String> tags;
  String author;

  Post(this.description, this.title, this.priority, this.isApproved,
      this.isDraft, this.showTime, this.hideTime, this.tags, this.author);
}