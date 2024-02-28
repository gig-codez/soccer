// To parse this JSON data, do
//
//     final leaguesModel = leaguesModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

LeaguesModel leaguesModelFromJson(String str) =>
    LeaguesModel.fromJson(json.decode(str));

String leaguesModelToJson(LeaguesModel data) => json.encode(data.toJson());

class LeaguesModel {
  final bool success;
  final List<Message> message;

  LeaguesModel({
    required this.success,
    required this.message,
  });

  factory LeaguesModel.fromJson(Map<String, dynamic> json) => LeaguesModel(
        success: json["success"],
        message:
            List<Message>.from(json["message"].map((x) => Message.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": List<dynamic>.from(message.map((x) => x.toJson())),
      };
}

class Message {
  final String id;
  final String name;
  final String date;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final String image;

  Message({
    required this.id,
    required this.name,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.image,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["_id"],
        name: json["name"],
        date: json["date"] ?? "",
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "date": date,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "image": image,
      };
}
