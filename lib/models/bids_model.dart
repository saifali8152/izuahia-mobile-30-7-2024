class BidsModel {
  final String bId;
  final String bidPrice;
  final String inventoryIdFk;
  final String userIdFk;
  final String status;
  final String createdAt;
  final String actualPrice;
  final String bidStatus;
  final String inventoryName;
  final List<String> inventoryImages;

  BidsModel({
    required this.bId,
    required this.bidPrice,
    required this.inventoryIdFk,
    required this.userIdFk,
    required this.status,
    required this.createdAt,
    required this.actualPrice,
    required this.bidStatus,
    required this.inventoryName,
    required this.inventoryImages,
  });

  factory BidsModel.fromJson(Map<String, dynamic> json) {
    return BidsModel(
      bId: json['b_id'] ?? "",
      bidPrice: json['bid_price'] ?? "",
      inventoryIdFk: json['inventory_id_fk'] ?? "",
      userIdFk: json['user_id_fk'] ?? "",
      status: json['status'] ?? "",
      createdAt: json['created_at'] ?? "",
      actualPrice: json['actual_price'] ?? "",
      bidStatus: json['bid_status'] ?? "",
      inventoryName: json['inventory_name'] ?? "",
      inventoryImages: json['inventory_images'] != null
          ? List<String>.from(json['inventory_images'])
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'b_id': bId,
      'bid_price': bidPrice,
      'inventory_id_fk': inventoryIdFk,
      'user_id_fk': userIdFk,
      'status': status,
      'created_at': createdAt,
      'actual_price': actualPrice,
      'bid_status': bidStatus,
      'inventory_name': inventoryName,
      'inventory_images': inventoryImages,
    };
  }
}
