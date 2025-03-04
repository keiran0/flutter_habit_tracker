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
  int habitId;
  List<dynamic> tracking;
  int currCount;

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
    required this.habitId,
    required this.tracking,
    required this.currCount
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
    int? habitId,
    List<DateTime>? tracking,
    int? currCount
  }) =>
      HabitModel(
        username: username ?? this.username,
        dateAdded: dateAdded ?? this.dateAdded,
        frequency: frequency ?? this.frequency,
        state: state ?? this.state,
        title: title ?? this.title,
        type: type ?? this.type,
        description: description ?? this.description,
        count: count ?? this.currCount,
        duration: duration ?? this.duration,
        habitId: habitId ?? this.habitId,
        tracking: tracking ?? this.tracking,
        currCount: currCount ?? this.currCount
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
    habitId: json["habitId"],
    tracking: json["tracking"],
    currCount: json['currCount']
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
    "habitId": habitId,
    "tracking": tracking,
    "currCount": currCount
  };
}
