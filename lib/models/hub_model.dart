// To parse this JSON data, do
//
//     final hubModel = hubModelFromJson(jsonString);

import 'dart:convert';

HubModel hubModelFromJson(String str) => HubModel.fromJson(json.decode(str));

String hubModelToJson(HubModel data) => json.encode(data.toJson());

class HubModel {
    List<HubDatum> data;
    String error;

    HubModel({
        required this.data,
        required this.error,
    });

    factory HubModel.fromJson(Map<String, dynamic> json) => HubModel(
        data: List<HubDatum>.from(json["data"].map((x) => HubDatum.fromJson(x))),
        error: json["error"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error,
    };
}

class HubDatum {
    String hubName;
    String shId;

    HubDatum({
        required this.hubName,
        required this.shId,
    });

    factory HubDatum.fromJson(Map<String, dynamic> json) => HubDatum(
        hubName: json["hub_name"],
        shId: json["sh_id"],
    );

    Map<String, dynamic> toJson() => {
        "hub_name": hubName,
        "sh_id": shId,
    };
}
