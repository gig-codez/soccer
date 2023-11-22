// To parse this JSON data, do

import 'dart:convert';

ArtworkModel artworkModelFromJson(String str) =>
    ArtworkModel.fromJson(json.decode(str));

String artworkModelToJson(ArtworkModel data) => json.encode(data.toJson());

class ArtworkModel {
  final List<Datum> data;

  ArtworkModel({
    required this.data,
  });

  factory ArtworkModel.fromJson(Map<String, dynamic> json) => ArtworkModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  final String id;
  final String league;
  final Fixture fixture;
  final int homeGoals;
  final int awayGoals;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Datum({
    required this.id,
    required this.league,
    required this.fixture,
    required this.homeGoals,
    required this.awayGoals,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        league: json["league"],
        fixture: Fixture.fromJson(json["fixture"]),
        homeGoals: json["homeGoals"],
        awayGoals: json["awayGoals"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "league": league,
        "fixture": fixture.toJson(),
        "homeGoals": homeGoals,
        "awayGoals": awayGoals,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Fixture {
  final String id;
  final Team hometeam;
  final Team awayteam;

  Fixture({
    required this.id,
    required this.hometeam,
    required this.awayteam,
  });

  factory Fixture.fromJson(Map<String, dynamic> json) => Fixture(
        id: json["_id"],
        hometeam: Team.fromJson(json["hometeam"]),
        awayteam: Team.fromJson(json["awayteam"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "hometeam": hometeam.toJson(),
        "awayteam": awayteam.toJson(),
      };
}

class Team {
  final String id;
  final String name;

  Team({
    required this.id,
    required this.name,
  });

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}
