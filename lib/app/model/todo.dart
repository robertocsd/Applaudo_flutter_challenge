// To parse this JSON data, do
//
//     final ToDoModel = ToDoModelFromMap(jsonString);

// ignore_for_file: prefer_if_null_operators, unnecessary_null_comparison

import 'dart:convert';

class ToDoModel {
  ToDoModel({
    required this.id,
    required this.title,
    required this.type,
  });

  final int id;
  String title;
  bool type;

  factory ToDoModel.fromJson(String str) => ToDoModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ToDoModel.fromMap(Map<String, dynamic> json) => ToDoModel(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        type: json["type"] == null ? null : json["type"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "type": type == null ? null : type,
      };
}
