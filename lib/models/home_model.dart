import 'package:izuahia/models/inventory_model.dart';
import 'package:izuahia/models/request_model.dart';
import 'package:izuahia/models/service_model.dart';

class HomeApiModel {
  final List<HomeServiceModel> allServices;
  final List<HomeInventoryModel> allInventories;
  final List<HomeRequestModel> allRequests;
  final String error;

  HomeApiModel({
    required this.allServices,
    required this.allInventories,
    required this.allRequests,
    required this.error,
  });

  factory HomeApiModel.fromJson(Map<String, dynamic> json) {
    return HomeApiModel(
      allServices: (json['data']['allServices'] as List).map((i) => HomeServiceModel.fromJson(i)).toList(),
      allInventories: (json['data']['allInventories'] as List).map((i) => HomeInventoryModel.fromJson(i)).toList(),
      allRequests: (json['data']['allRequests'] as List).map((i) => HomeRequestModel.fromJson(i)).toList(),
      error: json['error'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': {
        'allServices': allServices.map((i) => i.toJson()).toList(),
        'allInventories': allInventories.map((i) => i.toJson()).toList(),
        'allRequests': allRequests.map((i) => i.toJson()).toList(),
      },
      'error': error,
    };
  }
}
