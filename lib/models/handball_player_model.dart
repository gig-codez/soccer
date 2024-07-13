import 'dart:convert';

HandBallPlayerModel handBallPlayerModelFromJson(String str) =>
    HandBallPlayerModel.fromJson(json.decode(str));

String handBallPlayerModelToJson(HandBallPlayerModel data) =>
    json.encode(data.toJson());

class HandBallPlayerModel {
  final String id;
  final String league;
  final String player;
  final String shirtNo;
  final int to;
  final int gls;
  final int ast;
  final int mx;
  final int blk;
  final int ste;
  final int ks;
  final int twoMin;
  final int rc;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  HandBallPlayerModel({
    required this.id,
    required this.league,
    required this.player,
    required this.shirtNo,
    required this.to,
    required this.gls,
    required this.ast,
    required this.mx,
    required this.blk,
    required this.ste,
    required this.ks,
    required this.twoMin,
    required this.rc,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory HandBallPlayerModel.fromJson(Map<String, dynamic> json) =>
      HandBallPlayerModel(
        id: json["_id"],
        league: json["league"],
        player: json["player"],
        shirtNo: json["shirtNo"],
        to: json["TO"],
        gls: json["GLS"],
        ast: json["AST"],
        mx: json["MX"],
        blk: json["BLK"],
        ste: json["STE"],
        ks: json["KS"],
        twoMin: json["TWO_MIN"],
        rc: json["RC"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "league": league,
        "player": player,
        "shirtNo": shirtNo,
        "TO": to,
        "GLS": gls,
        "AST": ast,
        "MX": mx,
        "BLK": blk,
        "STE": ste,
        "KS": ks,
        "TWO_MIN": twoMin,
        "RC": rc,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
