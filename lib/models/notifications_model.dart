class NotificationsModel {
  final String nId;
  final String nTitle;
  final String nDetail;
  final String createdAt;
  final String userIdFk;

  NotificationsModel({
    required this.nId,
    required this.nTitle,
    required this.nDetail,
    required this.createdAt,
    required this.userIdFk,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic> json) {
    return NotificationsModel(
      nId: json['n_id'],
      nTitle: json['n_title'],
      nDetail: json['n_detail'],
      createdAt: json['created_at'],
      userIdFk: json['user_id_fk'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'n_id': nId,
      'n_title': nTitle,
      'n_detail': nDetail,
      'created_at': createdAt,
      'user_id_fk': userIdFk,
    };
  }
}
