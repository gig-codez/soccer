// To parse this JSON data, do
import 'dart:convert';

TableModel tableModelFromJson(String str) =>
    TableModel.fromJson(json.decode(str));

String tableModelToJson(TableModel data) => json.encode(data.toJson());

class TableModel {
  final bool success;
  final List<Message> message;

  TableModel({
    required this.success,
    required this.message,
  });

  factory TableModel.fromJson(Map<String, dynamic> json) => TableModel(
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
  final League league;
  final League team;
  final int played;
  final int points;
  final int gd;
  final int won;
  final int draw;
  final int lose;
  final int goalsScored;
  final int goalsConceded;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Message({
    required this.id,
    required this.league,
    required this.team,
    required this.played,
    required this.points,
    required this.gd,
    required this.won,
    required this.draw,
    required this.lose,
    required this.goalsScored,
    required this.goalsConceded,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["_id"],
        league: League.fromJson(json["league"]),
        team: League.fromJson(json["team"]),
        played: json["played"] ?? 0,
        points: json["points"],
        gd: json["gd"],
        won: json["won"],
        draw: json["draw"],
        lose: json["lose"],
        goalsScored: json["goals_scored"],
        goalsConceded: json["goals_conceded"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "league": league.toJson(),
        "team": team.toJson(),
        "played": played,
        "points": points,
        "gd": gd,
        "won": won,
        "draw": draw,
        "lose": lose,
        "goals_scored": goalsScored,
        "goals_conceded": goalsConceded,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class League {
  final String id;
  final String name;
  final String image;

  League({
    required this.id,
    required this.name,
    required this.image,
  });

  factory League.fromJson(Map<String, dynamic> json) => League(
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
