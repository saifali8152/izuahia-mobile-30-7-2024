class HomeRequestModel {
  final String? irId;
  final String? srId;
  final String? inventoryName;
  final String? serviceName;
  final String? itemColor;
  final String? size;
  final String? quantity;
  final String? inventoryCondition;
  final String? overview;
  final String? features;
  final String? specifications;
  final String? deliveryTerms;
  final String? inventoryType;
  final String? description;
  final String? fullAddress;
  final String? latitude;
  final String? longitude;
  final List<String>? inventoryImages;
  final String? serviceBudget;
  final String? serviceBudgetCurrency;
  final String? budgetFlexibility;
  final String? serviceImage;
  final String userIdFk;
  final String createdAt;
  final num distance;
  final String requestType;

  HomeRequestModel({
    this.irId,
    this.srId,
    this.inventoryName,
    this.serviceName,
    this.itemColor,
    this.size,
    this.quantity,
    this.inventoryCondition,
    this.overview,
    this.features,
    this.specifications,
    this.deliveryTerms,
    this.inventoryType,
    this.description,
    this.fullAddress,
    this.latitude,
    this.longitude,
    this.inventoryImages,
    this.serviceBudget,
    this.serviceBudgetCurrency,
    this.budgetFlexibility,
    this.serviceImage,
    required this.userIdFk,
    required this.createdAt,
    required this.distance,
    required this.requestType,
  });

  factory HomeRequestModel.fromJson(Map<String, dynamic> json) {
    return HomeRequestModel(
      irId: json['ir_id'],
      srId: json['sr_id'],
      inventoryName: json['inventory_name'],
      serviceName: json['service_name'],
      itemColor: json['item_color'],
      size: json['size'],
      quantity: json['quantity'],
      inventoryCondition: json['inventory_condition'],
      overview: json['overview'],
      features: json['features'],
      specifications: json['specifications'],
      deliveryTerms: json['delivery_terms'],
      inventoryType: json['inventory_type'],
      description: json['description'],
      fullAddress: json['full_address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      inventoryImages: json['inventory_images'] != null
          ? List<String>.from(json['inventory_images'])
          : null,
      serviceBudget: json['service_budget'],
      serviceBudgetCurrency: json['service_budget_currency'],
      budgetFlexibility: json['budget_flexibility'],
      serviceImage: json['service_image'],
      userIdFk: json['user_id_fk'],
      createdAt: json['created_at'],
      distance: json['distance'],
      requestType: json['request_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ir_id': irId,
      'sr_id': srId,
      'inventory_name': inventoryName,
      'service_name': serviceName,
      'item_color': itemColor,
      'size': size,
      'quantity': quantity,
      'inventory_condition': inventoryCondition,
      'overview': overview,
      'features': features,
      'specifications': specifications,
      'delivery_terms': deliveryTerms,
      'inventory_type': inventoryType,
      'description': description,
      'full_address': fullAddress,
      'latitude': latitude,
      'longitude': longitude,
      'inventory_images': inventoryImages,
      'service_budget': serviceBudget,
      'service_budget_currency': serviceBudgetCurrency,
      'budget_flexibility': budgetFlexibility,
      'service_image': serviceImage,
      'user_id_fk': userIdFk,
      'created_at': createdAt,
      'distance': distance,
      'request_type': requestType,
    };
  }
}