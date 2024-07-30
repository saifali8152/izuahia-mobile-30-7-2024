class OrdersModel {
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

  OrdersModel({
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
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) {
    return OrdersModel(
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
    );
  }

  Map<String, dynamic> toJson() {
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
