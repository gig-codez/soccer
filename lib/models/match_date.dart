// To parse this JSON data, do
//
//     final matchDateModel = matchDateModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<MatchDateModel> matchDateModelFromJson(String str) => List<MatchDateModel>.from(json.decode(str).map((x) => MatchDateModel.fromJson(x)));

String matchDateModelToJson(List<MatchDateModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MatchDateModel {
    final String id;
    final String date;
    final int v;

    MatchDateModel({
        required this.id,
        required this.date,
        required this.v,
    });

    factory MatchDateModel.fromJson(Map<String, dynamic> json) => MatchDateModel(
        id: json["_id"],
        date: json["date"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "date": date,
        "__v": v,
    };
}
