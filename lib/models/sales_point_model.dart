// To parse this JSON data, do
//
//     final salesPointModel = salesPointModelFromJson(jsonString);

import 'dart:convert';

SalesPointModel salesPointModelFromJson(String str) => SalesPointModel.fromJson(json.decode(str));

String salesPointModelToJson(SalesPointModel data) => json.encode(data.toJson());

class SalesPointModel {
    List<SalesPointDatum> data;
    String error;

    SalesPointModel({
        required this.data,
        required this.error,
    });

    factory SalesPointModel.fromJson(Map<String, dynamic> json) => SalesPointModel(
        data: List<SalesPointDatum>.from(json["data"].map((x) => SalesPointDatum.fromJson(x))),
        error: json["error"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error,
    };
}

class SalesPointDatum {
    String spName;
    String spId;

    SalesPointDatum({
        required this.spName,
        required this.spId,
    });

    factory SalesPointDatum.fromJson(Map<String, dynamic> json) => SalesPointDatum(
        spName: json["sp_name"],
        spId: json["sp_id"],
    );

    Map<String, dynamic> toJson() => {
        "sp_name": spName,
        "sp_id": spId,
    };
}
