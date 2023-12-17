// To parse this JSON data, do
//
//     final playersModel = playersModelFromJson(jsonString);

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
  final int red;
  final String id;
  final String name;
  final String team;
  final String position;
  final int goal;
  final int yellow;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Message({
    required this.red,
    required this.id,
    required this.name,
    required this.team,
    required this.position,
    required this.goal,
    required this.yellow,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        red: json["red"],
        id: json["_id"],
        name: json["name"],
        team: json["team"],
        position: json["position"],
        goal: json["goal"],
        yellow: json["yellow"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "red": red,
        "_id": id,
        "name": name,
        "team": team,
        "position": position,
        "goal": goal,
        "yellow": yellow,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
