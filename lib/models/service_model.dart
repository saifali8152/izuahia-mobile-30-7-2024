class HomeServiceModel {
  final String sId;
  final String serviceName;
  final String description;
  final String serviceImage;
  final String hubIdFk;
  final String userIdFk;
  final String createdAt;
  final String phone;
  final String email;
  final String fullAddress;
  final String latitude;
  final String longitude;
  final String hubImage;
  final String hubName;
  final String hubDescription;
  final List<HubService>? hubServices;
  final List<SimilarFirm>? similarFirms;

  HomeServiceModel({
    required this.sId,
    required this.serviceName,
    required this.description,
    required this.serviceImage,
    required this.hubIdFk,
    required this.userIdFk,
    required this.createdAt,
    required this.phone,
    required this.email,
    required this.fullAddress,
    required this.latitude,
    required this.longitude,
    required this.hubImage,
    required this.hubName,
    required this.hubDescription,
    this.hubServices,
    this.similarFirms,
  });

  factory HomeServiceModel.fromJson(Map<String, dynamic> json) {
    return HomeServiceModel(
      sId: json['s_id'] ?? "",
      serviceName: json['service_name'] ?? "",
      description: json['description'] ?? "",
      serviceImage: json['service_image'] ?? "",
      hubIdFk: json['hub_id_fk'] ?? "",
      userIdFk: json['user_id_fk'] ?? "",
      createdAt: json['created_at'] ?? "",
      phone: json['phone'] ?? "",
      email: json['email'] ?? "",
      fullAddress: json['full_address'] ?? "",
      latitude: json['latitude'] ?? "",
      longitude: json['longitude'] ?? "",
      hubImage: json['hub_image'] ?? "",
      hubName: json['hub_name'] ?? "",
      hubDescription: json['hub_description']?? "",
      hubServices: json['hubServices'] !=null ?
      (json['hubServices'] as List)
          .map((i) => HubService.fromJson(i))
          .toList() : null,
      similarFirms: json['similarFirms'] != null ?
       (json['similarFirms'] as List)
          .map((i) => SimilarFirm.fromJson(i))
          .toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      's_id': sId,
      'service_name': serviceName,
      'description': description,
      'service_image': serviceImage,
      'hub_id_fk': hubIdFk,
      'user_id_fk': userIdFk,
      'created_at': createdAt,
      'phone': phone,
      'email': email,
      'full_address': fullAddress,
      'latitude': latitude,
      'longitude': longitude,
      'hub_image': hubImage,
      'hub_name': hubName,
      'hub_description': hubDescription,
      'hubServices': hubServices?.map((i) => i.toJson()).toList(),
      'similarFirms': similarFirms?.map((i) => i.toJson()).toList(),
    };
  }
}

class HubService {
  final String sId;
  final String serviceName;
  final String description;
  final String serviceImage;
  final String hubIdFk;
  final String userIdFk;
  final String createdAt;

  HubService({
    required this.sId,
    required this.serviceName,
    required this.description,
    required this.serviceImage,
    required this.hubIdFk,
    required this.userIdFk,
    required this.createdAt,
  });

  factory HubService.fromJson(Map<String, dynamic> json) {
    return HubService(
      sId: json['s_id'],
      serviceName: json['service_name'],
      description: json['description'],
      serviceImage: json['service_image'],
      hubIdFk: json['hub_id_fk'],
      userIdFk: json['user_id_fk'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      's_id': sId,
      'service_name': serviceName,
      'description': description,
      'service_image': serviceImage,
      'hub_id_fk': hubIdFk,
      'user_id_fk': userIdFk,
      'created_at': createdAt,
    };
  }
}

class SimilarFirm {
  final String shId;
  final String hubName;
  final String phone;
  final String email;
  final String address;
  final String fullAddress;
  final String latitude;
  final String longitude;
  final String description;
  final String hubImage;
  final String userIdFk;
  final String createdAt;

  SimilarFirm({
    required this.shId,
    required this.hubName,
    required this.phone,
    required this.email,
    required this.address,
    required this.fullAddress,
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.hubImage,
    required this.userIdFk,
    required this.createdAt,
  });

  factory SimilarFirm.fromJson(Map<String, dynamic> json) {
    return SimilarFirm(
      shId: json['sh_id'],
      hubName: json['hub_name'],
      phone: json['phone'],
      email: json['email'],
      address: json['address'],
      fullAddress: json['full_address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      description: json['description'],
      hubImage: json['hub_image'],
      userIdFk: json['user_id_fk'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sh_id': shId,
      'hub_name': hubName,
      'phone': phone,
      'email': email,
      'address': address,
      'full_address': fullAddress,
      'latitude': latitude,
      'longitude': longitude,
      'description': description,
      'hub_image': hubImage,
      'user_id_fk': userIdFk,
      'created_at': createdAt,
    };
  }
}
