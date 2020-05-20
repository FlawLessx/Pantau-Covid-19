// To parse this JSON data, do
//
//     final global = globalFromJson(jsonString);

import 'dart:convert';

List<Global> globalFromJson(String str) => List<Global>.from(json.decode(str).map((x) => Global.fromJson(x)));

String globalToJson(List<Global> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Global {
    String countryCode;
    String country;
    int totalConfirmed;
    int totalDeaths;
    int totalRecovered;
    int dailyConfirmed;
    int dailyDeaths;
    int activeCases;
    int totalCritical;
    int totalConfirmedPerMillionPopulation;
    int totalDeathsPerMillionPopulation;
    String fr;
    String pr;
    DateTime lastUpdated;

    Global({
        this.countryCode,
        this.country,
        this.totalConfirmed,
        this.totalDeaths,
        this.totalRecovered,
        this.dailyConfirmed,
        this.dailyDeaths,
        this.activeCases,
        this.totalCritical,
        this.totalConfirmedPerMillionPopulation,
        this.totalDeathsPerMillionPopulation,
        this.fr,
        this.pr,
        this.lastUpdated,
    });

    factory Global.fromJson(Map<String, dynamic> json) => Global(
        countryCode: json["countryCode"],
        country: json["country"],
        totalConfirmed: json["totalConfirmed"],
        totalDeaths: json["totalDeaths"],
        totalRecovered: json["totalRecovered"],
        dailyConfirmed: json["dailyConfirmed"],
        dailyDeaths: json["dailyDeaths"],
        activeCases: json["activeCases"],
        totalCritical: json["totalCritical"],
        totalConfirmedPerMillionPopulation: json["totalConfirmedPerMillionPopulation"],
        totalDeathsPerMillionPopulation: json["totalDeathsPerMillionPopulation"],
        fr: json["FR"],
        pr: json["PR"],
        lastUpdated: DateTime.parse(json["lastUpdated"]),
    );

    Map<String, dynamic> toJson() => {
        "countryCode": countryCode,
        "country": country,
        "totalConfirmed": totalConfirmed,
        "totalDeaths": totalDeaths,
        "totalRecovered": totalRecovered,
        "dailyConfirmed": dailyConfirmed,
        "dailyDeaths": dailyDeaths,
        "activeCases": activeCases,
        "totalCritical": totalCritical,
        "totalConfirmedPerMillionPopulation": totalConfirmedPerMillionPopulation,
        "totalDeathsPerMillionPopulation": totalDeathsPerMillionPopulation,
        "FR": fr,
        "PR": pr,
        "lastUpdated": lastUpdated.toIso8601String(),
    };
}
