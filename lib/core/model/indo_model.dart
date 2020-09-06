// To parse this JSON data, do
//
//     final indo = indoFromJson(jsonString);

import 'dart:convert';

List<Indo> indoFromJson(String str) =>
    List<Indo>.from(json.decode(str).map((x) => Indo.fromJson(x)));

String indoToJson(List<Indo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Indo {
  String name;
  String positif;
  String sembuh;
  String meninggal;

  Indo({
    this.name,
    this.positif,
    this.sembuh,
    this.meninggal,
  });

  factory Indo.fromJson(Map<String, dynamic> json) => Indo(
        name: json["name"],
        positif: json["positif"],
        sembuh: json["sembuh"],
        meninggal: json["meninggal"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "positif": positif,
        "sembuh": sembuh,
        "meninggal": meninggal,
      };
}
