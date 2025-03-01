// To parse this JSON data, do
//
//     final recipeModel = recipeModelFromJson(jsonString);

import 'dart:convert';

HabitModel habitModelFromJson(String str) =>
    HabitModel.fromJson(json.decode(str));

String habitModelToJson(HabitModel data) => json.encode(data.toJson());

class HabitModel {
  String username;
  DateTime dateAdded;
  String frequency;
  String state;
  String title;
  String type;
  String description;
  int count;
  int duration;

  HabitModel({
    required this.username,
    required this.dateAdded,
    required this.frequency,
    required this.state,
    required this.title,
    required this.type,
    required this.description,
    required this.count,
    required this.duration,
  });

  HabitModel copyWith({
    String? username,
    DateTime? dateAdded,
    String? frequency,
    String? state,
    String? title,
    String? type,
    String? description,
    int? count,
    int? duration,
  }) =>
      HabitModel(
        username: username ?? this.username,
        dateAdded: dateAdded ?? this.dateAdded,
        frequency: frequency ?? this.frequency,
        state: state ?? this.state,
        title: title ?? this.title,
        type: type ?? this.type,
        description: description ?? this.description,
        count: count ?? this.count,
        duration: duration ?? this.duration,
      );

  factory HabitModel.fromJson(Map<String, dynamic> json) => HabitModel(
    username: json["username"],
    dateAdded: DateTime.parse(json["dateAdded"]),
    frequency: json["frequency"],
    state: json["state"],
    title: json["title"],
    type: json["type"],
    description: json["description"],
    count: json["count"],
    duration: json["duration"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "dateAdded": dateAdded.toIso8601String(),
    "frequency": frequency,
    "state": state,
    "title": title,
    "type": type,
    "description": description,
    "count": count,
    "duration": duration,
  };
}
