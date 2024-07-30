// To parse this JSON data, do
//
//     final boothModel = boothModelFromJson(jsonString);

import 'dart:convert';

BoothModel boothModelFromJson(String str) => BoothModel.fromJson(json.decode(str));

String boothModelToJson(BoothModel data) => json.encode(data.toJson());

class BoothModel {
    List<BoothDatum> data;
    String error;

    BoothModel({
        required this.data,
        required this.error,
    });

    factory BoothModel.fromJson(Map<String, dynamic> json) => BoothModel(
        data: List<BoothDatum>.from(json["data"].map((x) => BoothDatum.fromJson(x))),
        error: json["error"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error,
    };
}

class BoothDatum {
    String boothName;
    String boothId;

    BoothDatum({
        required this.boothName,
        required this.boothId,
    });

    factory BoothDatum.fromJson(Map<String, dynamic> json) => BoothDatum(
        boothName: json["booth_name"],
        boothId: json["booth_id"],
    );

    Map<String, dynamic> toJson() => {
        "booth_name": boothName,
        "booth_id": boothId,
    };
}
