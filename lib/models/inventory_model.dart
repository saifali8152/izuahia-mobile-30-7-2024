class HomeInventoryModel {
  final String inventoryId;
  final String inventoryName;
  final String sellingPrice;
  final String inventoryBudgetCurrency;
  final String itemColor;
  final String size;
  final String quantity;
  final String inventoryCondition;
  final String overview;
  final String features;
  final String specifications;
  final String deliveryTerms;
  final String inventoryType;
  final String description;
  final List<String> inventoryImages;
  final String userIdFk;
  final String spIdFk;
  final String boothIdFk;
  final String createdAt;

  HomeInventoryModel({
    required this.inventoryId,
    required this.inventoryName,
    required this.sellingPrice,
    required this.inventoryBudgetCurrency,
    required this.itemColor,
    required this.size,
    required this.quantity,
    required this.inventoryCondition,
    required this.overview,
    required this.features,
    required this.specifications,
    required this.deliveryTerms,
    required this.inventoryType,
    required this.description,
    required this.inventoryImages,
    required this.userIdFk,
    required this.spIdFk,
    required this.boothIdFk,
    required this.createdAt,
  });

  factory HomeInventoryModel.fromJson(Map<String, dynamic> json) {
    return HomeInventoryModel(
      inventoryId: json['inventory_id'],
      inventoryName: json['inventory_name'],
      sellingPrice: json['selling_price'],
      inventoryBudgetCurrency: json['inventory_budget_currency'],
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
      inventoryImages: List<String>.from(json['inventory_images']),
      userIdFk: json['user_id_fk'],
      spIdFk: json['sp_id_fk'],
      boothIdFk: json['booth_id_fk'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'inventory_id': inventoryId,
      'inventory_name': inventoryName,
      'selling_price': sellingPrice,
      'inventory_budget_currency': inventoryBudgetCurrency,
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
      'inventory_images': inventoryImages,
      'user_id_fk': userIdFk,
      'sp_id_fk': spIdFk,
      'booth_id_fk': boothIdFk,
      'created_at': createdAt,
    };
  }
}