import 'dart:convert';

List<BlogsModel> blogsModelFromJson(String str) =>
    List<BlogsModel>.from(json.decode(str).map((x) => BlogsModel.fromJson(x)));

String blogsModelToJson(List<BlogsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BlogsModel {
  final String id;
  final String league;
  final String title;
  final String summary;
  final String content;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  BlogsModel({
    required this.id,
    required this.league,
    required this.title,
    required this.summary,
    required this.content,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory BlogsModel.fromJson(Map<String, dynamic> json) => BlogsModel(
        id: json["_id"],
        league: json["league"],
        title: json["title"],
        summary: json["summary"],
        content: json["content"],
        image: json["image"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "league": league,
        "title": title,
        "summary": summary,
        "content": content,
        "image": image,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
