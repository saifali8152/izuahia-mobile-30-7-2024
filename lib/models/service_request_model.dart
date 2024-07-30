class ServiceRequestModel {
  final List<ServiceRequest> data;
  final String error;

  ServiceRequestModel({required this.data, required this.error});

  factory ServiceRequestModel.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<ServiceRequest> dataList = list.map((i) => ServiceRequest.fromJson(i)).toList();

    return ServiceRequestModel(
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

class ServiceRequest {
  final String srId;
  final String serviceName;
  final String serviceBudget;
  final String serviceBudgetCurrency;
  final String budgetFlexibility;
  final String description;
  final String serviceImage;
  final String latitude;
  final String longitude;
  final String fullAddress;
  final String userIdFk;
  final String createdAt;
  final List<Comment> allComments;

  ServiceRequest({
    required this.srId,
    required this.serviceName,
    required this.serviceBudget,
    required this.serviceBudgetCurrency,
    required this.budgetFlexibility,
    required this.description,
    required this.serviceImage,
    required this.latitude,
    required this.longitude,
    required this.fullAddress,
    required this.userIdFk,
    required this.createdAt,
    required this.allComments,
  });

  factory ServiceRequest.fromJson(Map<String, dynamic> json) {
    var commentsList = json['allComments'] as List;
    List<Comment> comments = commentsList.map((i) => Comment.fromJson(i)).toList();

    return ServiceRequest(
      srId: json['sr_id'],
      serviceName: json['service_name'],
      serviceBudget: json['service_budget'],
      serviceBudgetCurrency: json['service_budget_currency'],
      budgetFlexibility: json['budget_flexibility'],
      description: json['description'],
      serviceImage: json['service_image'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      fullAddress: json['full_address'],
      userIdFk: json['user_id_fk'],
      createdAt: json['created_at'],
      allComments: comments,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sr_id': srId,
      'service_name': serviceName,
      'service_budget': serviceBudget,
      'service_budget_currency': serviceBudgetCurrency,
      'budget_flexibility': budgetFlexibility,
      'description': description,
      'service_image': serviceImage,
      'latitude': latitude,
      'longitude': longitude,
      'full_address': fullAddress,
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
