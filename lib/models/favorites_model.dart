import 'dart:developer';

import 'package:izuahia/models/inventory_model.dart';
import 'package:izuahia/models/service_model.dart';

class FavoriteModel {
  final String fType;
  final String fId;
  final HomeServiceModel? serviceModel;
  final HomeInventoryModel? inventoryModel;

  FavoriteModel({
    required this.fId,
    required this.fType,
    this.serviceModel,
    this.inventoryModel,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    if (json['f_type'] == 'service') {
      log("error 1");
      return FavoriteModel(
        fType: json['f_type'],
        fId: json['f_id'],
        serviceModel: HomeServiceModel.fromJson(json['details']),
      );
    } else if (json['f_type'] == 'inventory') {
      log("error 2");
      return FavoriteModel(
        fId: json['f_id'],
        fType: json['f_type'],
        inventoryModel: HomeInventoryModel.fromJson(json['details']),
      );
    } else {
      throw Exception('Unknown f_type');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'f_type': fType,
      'f_id': fId,
      'data': fType == 'service' ? serviceModel?.toJson() : inventoryModel?.toJson(),
    };
  }
}
