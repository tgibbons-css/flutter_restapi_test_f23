// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

// json data from https://cat-fact.herokuapp.com/facts/random?animal_type=cat&amount=5
// json to  dart class convertsion from https://app.quicktype.io/

import 'dart:convert';

List<CatFact> catFactFromJson(String str) => List<CatFact>.from(json.decode(str).map((x) => CatFact.fromJson(x)));

String catFactToJson(List<CatFact> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CatFact {
  CatFact({
    required this.status,
    required this.type,
    required this.deleted,
    required this.id,
    required this.user,
    required this.text,
    required this.v,
    required this.source,
    required this.updatedAt,
    required this.createdAt,
    required this.used,
    required this.sendDate,
  });

  Status status;
  String type;
  bool deleted;
  String id;
  String user;
  String text;
  int v;
  String source;
  DateTime updatedAt;
  DateTime createdAt;
  bool used;
  DateTime sendDate;

  factory CatFact.fromJson(Map<String, dynamic> json) => CatFact(
    status: Status.fromJson(json["status"]),
    type: json["type"],
    deleted: json["deleted"],
    id: json["_id"],
    user: json["user"],
    text: json["text"],
    v: json["__v"] == null ? null : json["__v"],
    source: json["source"] == null ? null : json["source"],
    updatedAt: DateTime.parse(json["updatedAt"]),
    createdAt: DateTime.parse(json["createdAt"]),
    used: json["used"] == null ? null : json["used"],
    sendDate: json["sendDate"] == null ? DateTime.parse('10-01-1999') : DateTime.parse(json["sendDate"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status.toJson(),
    "type": type,
    "deleted": deleted,
    "_id": id,
    "user": user,
    "text": text,
    "__v": v == null ? null : v,
    "source": source == null ? null : source,
    "updatedAt": updatedAt.toIso8601String(),
    "createdAt": createdAt.toIso8601String(),
    "used": used == null ? null : used,
    "sendDate": sendDate == null ? null : sendDate.toIso8601String(),
  };
}

class Status {
  Status({
    required this.verified,
    required this.sentCount,
  });

  bool verified = false;
  int sentCount = 0;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    verified: json["verified"] == null ? null : json["verified"],
    sentCount: json["sentCount"],
  );

  Map<String, dynamic> toJson() => {
    "verified": verified == null ? null : verified,
    "sentCount": sentCount,
  };
}