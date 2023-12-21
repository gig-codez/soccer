// To parse this JSON data, do
//
//     final fixtureModel = fixtureModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

FixtureModel fixtureModelFromJson(String str) => FixtureModel.fromJson(json.decode(str));

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
    final String league;
    final Team hometeam;
    final Team awayteam;
    final String minutesplayed;
    final String kickofftime;
    final String fixtureDate;
    final int homeGoals;
    final int awayGoals;
    final bool isLive;
    final bool halfEnded;
    final bool quarterEnded;
    final bool matchEnded;
    final String elapsedTime;
    final bool twohalves;
    final int v;

    Datum({
        required this.id,
        required this.league,
        required this.hometeam,
        required this.awayteam,
        required this.minutesplayed,
        required this.kickofftime,
        required this.fixtureDate,
        required this.homeGoals,
        required this.awayGoals,
        required this.isLive,
        required this.halfEnded,
        required this.quarterEnded,
        required this.matchEnded,
        required this.elapsedTime,
        required this.twohalves,
        required this.v,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        league: json["league"],
        hometeam: Team.fromJson(json["hometeam"]),
        awayteam: Team.fromJson(json["awayteam"]),
        minutesplayed: json["minutesplayed"],
        kickofftime: json["kickofftime"],
        fixtureDate: json["fixtureDate"],
        homeGoals: json["homeGoals"],
        awayGoals: json["awayGoals"],
        isLive: json["isLive"],
        halfEnded: json["halfEnded"],
        quarterEnded: json["quarterEnded"],
        matchEnded: json["matchEnded"],
        elapsedTime: json["elapsedTime"],
        twohalves: json["twohalves"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "league": league,
        "hometeam": hometeam.toJson(),
        "awayteam": awayteam.toJson(),
        "minutesplayed": minutesplayed,
        "kickofftime": kickofftime,
        "fixtureDate": fixtureDate,
        "homeGoals": homeGoals,
        "awayGoals": awayGoals,
        "isLive": isLive,
        "halfEnded": halfEnded,
        "quarterEnded": quarterEnded,
        "matchEnded": matchEnded,
        "elapsedTime": elapsedTime,
        "twohalves": twohalves,
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
