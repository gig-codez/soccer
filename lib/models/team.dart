// To parse this JSON data, do

import 'dart:convert';

TeamModel teamModelFromJson(String str) => TeamModel.fromJson(json.decode(str));

String teamModelToJson(TeamModel data) => json.encode(data.toJson());

class TeamModel {
    final bool success;
    final List<Message> message;

    TeamModel({
        required this.success,
        required this.message,
    });

    factory TeamModel.fromJson(Map<String, dynamic> json) => TeamModel(
        success: json["success"],
        message: List<Message>.from(json["message"].map((x) => Message.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": List<dynamic>.from(message.map((x) => x.toJson())),
    };
}

class Message {
    final String id;
    final String name;
    final String league;
    final String image;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    Message({
        required this.id,
        required this.name,
        required this.league,
        required this.image,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["_id"],
        name: json["name"],
        league: json["league"],
        image: json["image"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "league": league,
        "image": image,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
