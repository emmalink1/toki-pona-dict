import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

Future<Post> fetchPost() async {
  var response = await rootBundle.loadString('assets/data/test.json');
  return Post.fromJson(json.decode(response));
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
