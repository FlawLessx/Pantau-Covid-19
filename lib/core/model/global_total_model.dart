// To parse this JSON data, do
//
//     final globalTotal = globalTotalFromJson(jsonString);

import 'dart:convert';

GlobalTotal globalTotalFromJson(String str) => GlobalTotal.fromJson(json.decode(str));

String globalTotalToJson(GlobalTotal data) => json.encode(data.toJson());

class GlobalTotal {
    int cases;
    int deaths;
    int recovered;

    GlobalTotal({
        this.cases,
        this.deaths,
        this.recovered,
    });

    factory GlobalTotal.fromJson(Map<String, dynamic> json) => GlobalTotal(
        cases: json["cases"],
        deaths: json["deaths"],
        recovered: json["recovered"],
    );

    Map<String, dynamic> toJson() => {
        "cases": cases,
        "deaths": deaths,
        "recovered": recovered,
    };
}
