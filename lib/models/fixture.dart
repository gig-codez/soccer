// To parse this JSON data, do

import 'dart:convert';

FixtureModel fixtureModelFromJson(String str) =>
    FixtureModel.fromJson(json.decode(str));

String fixtureModelToJson(FixtureModel data) => json.encode(data.toJson());

class FixtureModel {
  final List<Datum> data;

  FixtureModel({
    required this.data,
  });

  factory FixtureModel.fromJson(Map<String, dynamic> json) => FixtureModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  final String id;
  final Team hometeam;
  final Team awayteam;
  final String minutesplayed;
  final String kickofftime;
  final bool twohalves;
  final bool fourhalves;
  final int v;

  Datum({
    required this.id,
    required this.hometeam,
    required this.awayteam,
    required this.minutesplayed,
    required this.kickofftime,
    required this.twohalves,
    required this.fourhalves,
    required this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        hometeam: Team.fromJson(json["hometeam"] ?? {}),
        awayteam: Team.fromJson(json["awayteam"] ?? {}),
        minutesplayed: json["minutesplayed"],
        kickofftime: json["kickofftime"],
        twohalves: json["twohalves"],
        fourhalves: json["fourhalves"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "hometeam": hometeam.toJson(),
        "awayteam": awayteam.toJson(),
        "minutesplayed": minutesplayed,
        "kickofftime": kickofftime,
        "twohalves": twohalves,
        "fourhalves": fourhalves,
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
        id: json["_id"] ?? "",
        name: json["name"] ?? "",
        image: json["image"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "image": image,
      };
}
