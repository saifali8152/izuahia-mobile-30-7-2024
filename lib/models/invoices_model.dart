class InvoicesModel {
  String invoiceId;
  String invoiceNo;
  String invoiceCurrency;
  String invoicePrice;
  String invoiceTax;
  String invoiceTotalPrice;
  String invoiceType;
  String isDeliveryArranged;
  String createdAt;
  String userIdFk;
  String vendorIdFk;
  VendorDetails vendorDetails;
  List<ItemDetails> itemDetails;

  InvoicesModel({
    required this.invoiceId,
    required this.invoiceNo,
    required this.invoiceCurrency,
    required this.invoicePrice,
    required this.invoiceTax,
    required this.invoiceTotalPrice,
    required this.invoiceType,
    required this.isDeliveryArranged,
    required this.createdAt,
    required this.userIdFk,
    required this.vendorIdFk,
    required this.vendorDetails,
    required this.itemDetails,
  });

  factory InvoicesModel.fromJson(Map<String, dynamic> json) {
    var itemList = json['itemDetails'] as List;
    List<ItemDetails> items = itemList.map((i) => ItemDetails.fromJson(i)).toList();

    return InvoicesModel(
      invoiceId: json['invoice_id'],
      invoiceNo: json['invoice_no'],
      invoiceCurrency: json['invoice_currency'],
      invoicePrice: json['invoice_price'],
      invoiceTax: json['invoice_tax'],
      invoiceTotalPrice: json['invoice_total_price'],
      invoiceType: json['invoice_type'],
      isDeliveryArranged: json['is_delivery_arranged'],
      createdAt: json['created_at'],
      userIdFk: json['user_id_fk'],
      vendorIdFk: json['vendor_id_fk'],
      vendorDetails: VendorDetails.fromJson(json['vendorDetails']),
      itemDetails: items,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> items = itemDetails.map((i) => i.toJson()).toList();

    return {
      'invoice_id': invoiceId,
      'invoice_no': invoiceNo,
      'invoice_currency': invoiceCurrency,
      'invoice_price': invoicePrice,
      'invoice_tax': invoiceTax,
      'invoice_total_price': invoiceTotalPrice,
      'invoice_type': invoiceType,
      'is_delivery_arranged': isDeliveryArranged,
      'created_at': createdAt,
      'user_id_fk': userIdFk,
      'vendor_id_fk': vendorIdFk,
      'vendorDetails': vendorDetails.toJson(),
      'itemDetails': items,
    };
  }
}

class VendorDetails {
  String name;
  String email;
  String boothImage;

  VendorDetails({
    required this.name,
    required this.email,
    required this.boothImage,
  });

  factory VendorDetails.fromJson(Map<String, dynamic> json) {
    return VendorDetails(
      name: json['name'],
      email: json['email'],
      boothImage: json['booth_image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'booth_image': boothImage,
    };
  }
}

class ItemDetails {
  int sNo;
  String itemName;
  String itemQty;
  String itemPrice;
  String itemColor;
  String size;
  String itemCondition;
  String itemImage;

  ItemDetails({
    required this.sNo,
    required this.itemName,
    required this.itemQty,
    required this.itemPrice,
    required this.itemColor,
    required this.size,
    required this.itemCondition,
    required this.itemImage,
  });

  factory ItemDetails.fromJson(Map<String, dynamic> json) {
    return ItemDetails(
      sNo: json['s_no'],
      itemName: json['item_name'],
      itemQty: json['item_qty'],
      itemPrice: json['item_price'],
      itemColor: json['item_color'],
      size: json['size'],
      itemCondition: json['item_condition'],
      itemImage: json['item_image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      's_no': sNo,
      'item_name': itemName,
      'item_qty': itemQty,
      'item_price': itemPrice,
      'item_color': itemColor,
      'size': size,
      'item_condition': itemCondition,
      'item_image': itemImage,
    };
  }
}
