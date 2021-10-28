import 'dart:convert';

DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String dataModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
  DataModel({
    this.by,
    this.id,
    this.score,
    this.text,
    this.time,
    this.title,
    this.type,
    this.url,
  });

  String? by;
  int? id;
  int? score;
  String? text;
  int? time;
  String? title;
  String? type;
  String? url;

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        by: json["by"],
        id: json["id"],
        score: json["score"],
        text: json["text"],
        time: json["time"],
        title: json["title"],
        type: json["type"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "by": by,
        "id": id,
        "score": score,
        "text": text,
        "time": time,
        "title": title,
        "type": type,
        "url": url,
      };
}
