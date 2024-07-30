class InventoryRequestsModel {
  final List<InventoryRequest> data;
  final String error;

  InventoryRequestsModel({required this.data, required this.error});

  factory InventoryRequestsModel.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<InventoryRequest> dataList = list.map((i) => InventoryRequest.fromJson(i)).toList();

    return InventoryRequestsModel(
      data: dataList,
      error: json['error'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((v) => v.toJson()).toList(),
      'error': error,
    };
  }
}

class InventoryRequest {
  final String irId;
  final String inventoryName;
  final String? inventoryBudget;
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
  final String fullAddress;
  final String latitude;
  final String longitude;
  final List<String> inventoryImages;
  final String userIdFk;
  final String createdAt;
  final List<Comment> allComments;

  InventoryRequest({
    required this.irId,
    required this.inventoryName,
    this.inventoryBudget,
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
    required this.fullAddress,
    required this.latitude,
    required this.longitude,
    required this.inventoryImages,
    required this.userIdFk,
    required this.createdAt,
    required this.allComments,
  });

  factory InventoryRequest.fromJson(Map<String, dynamic> json) {
    var commentsList = json['allComments'] as List;
    List<Comment> comments = commentsList.map((i) => Comment.fromJson(i)).toList();

    return InventoryRequest(
      irId: json['ir_id'],
      inventoryName: json['inventory_name'],
      inventoryBudget: json['inventory_budget'],
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
      fullAddress: json['full_address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      inventoryImages: List<String>.from(json['inventory_images']),
      userIdFk: json['user_id_fk'],
      createdAt: json['created_at'],
      allComments: comments,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ir_id': irId,
      'inventory_name': inventoryName,
      'inventory_budget': inventoryBudget,
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
      'full_address': fullAddress,
      'latitude': latitude,
      'longitude': longitude,
      'inventory_images': inventoryImages,
      'user_id_fk': userIdFk,
      'created_at': createdAt,
      'allComments': allComments.map((v) => v.toJson()).toList(),
    };
  }
}

class Comment {
  final String comment;
  final String commentDatetime;
  final String commentImage;
  final String commentBy;

  Comment({
    required this.comment,
    required this.commentDatetime,
    required this.commentImage,
    required this.commentBy,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      comment: json['comment'],
      commentDatetime: json['comment_datetime'],
      commentImage: json['comment_image'],
      commentBy: json['comment_by'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'comment': comment,
      'comment_datetime': commentDatetime,
      'comment_image': commentImage,
      'comment_by': commentBy,
    };
  }
}
