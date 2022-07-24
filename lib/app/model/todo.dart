// To parse this JSON data, do
//
//     final toDo = toDoFromMap(jsonString);

import 'dart:convert';

class ToDo {
  ToDo({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
  });

  final int id;
  final String title;
  final String description;
  final String type;

  factory ToDo.fromJson(String str) => ToDo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ToDo.fromMap(Map<String, dynamic> json) => ToDo(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        type: json["type"] == null ? null : json["type"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "type": type == null ? null : type,
      };
}
