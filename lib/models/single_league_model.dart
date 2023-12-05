// To parse this JSON data, do
//
//     final singleLeagueModel = singleLeagueModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SingleLeagueModel singleLeagueModelFromJson(String str) => SingleLeagueModel.fromJson(json.decode(str));

String singleLeagueModelToJson(SingleLeagueModel data) => json.encode(data.toJson());

class SingleLeagueModel {
    final bool success;
    final Message message;

    SingleLeagueModel({
        required this.success,
        required this.message,
    });

    factory SingleLeagueModel.fromJson(Map<String, dynamic> json) => SingleLeagueModel(
        success: json["success"],
        message: Message.fromJson(json["message"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message.toJson(),
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
        date: json["date"],
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
