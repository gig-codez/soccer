// To parse this JSON data, do
//
//     final playersModel = playersModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PlayersModel playersModelFromJson(String str) =>
    PlayersModel.fromJson(json.decode(str));

String playersModelToJson(PlayersModel data) => json.encode(data.toJson());

class PlayersModel {
  final bool success;
  final List<Message> message;

  PlayersModel({
    required this.success,
    required this.message,
  });

  factory PlayersModel.fromJson(Map<String, dynamic> json) => PlayersModel(
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
  final String team;
  final String position;
  final int goal;
  final int assist;
  final int yellow;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Message({
    required this.id,
    required this.name,
    required this.team,
    required this.position,
    required this.goal,
    required this.assist,
    required this.yellow,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["_id"],
        name: json["name"],
        team: json["team"],
        position: json["position"],
        goal: json["goal"],
        assist: json["assist"],
        yellow: json["yellow"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "team": team,
        "position": position,
        "goal": goal,
        "assist": assist,
        "yellow": yellow,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
