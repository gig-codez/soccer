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
  final int cleanSheet;
  final String id;
  final String name;
  final Team team;
  final bool transferred;
  final String soldOut;
  final String position;
  final int goal;
  final int assist;
  final int yellow;
  final int red;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Message({
    required this.cleanSheet,
    required this.id,
    required this.name,
    required this.team,
    required this.transferred,
    required this.soldOut,
    required this.position,
    required this.goal,
    required this.assist,
    required this.yellow,
    required this.red,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        cleanSheet: json["clean_sheet"],
        id: json["_id"],
        name: json["name"],
        team: Team.fromJson(json["team"]),
        transferred: json["transferred"],
        soldOut: json["sold_out"],
        position: json["position"],
        goal: json["goal"],
        assist: json["assist"],
        yellow: json["yellow"],
        red: json["red"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "clean_sheet": cleanSheet,
        "_id": id,
        "name": name,
        "team": team.toJson(),
        "transferred": transferred,
        "sold_out": soldOut,
        "position": position,
        "goal": goal,
        "assist": assist,
        "yellow": yellow,
        "red": red,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Team {
  final String id;
  final String name;
  final String image;

  Team({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        id: json["_id"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "image": image,
      };
}
