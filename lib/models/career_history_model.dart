class CareerHistoryModel {
  final String jobTitle;
  final String startDate;
  final String endDate;
  final String businessName;
  final String businessImage;

  CareerHistoryModel({
    required this.jobTitle,
    required this.startDate,
    required this.endDate,
    required this.businessName,
    required this.businessImage,
  });

  factory CareerHistoryModel.fromJson(Map<String, dynamic> json) {
    return CareerHistoryModel(
      jobTitle: json['job_title'] ?? '',
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
      businessName: json['business_name'] ?? '',
      businessImage: json['business_image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'job_title': jobTitle,
      'start_date': startDate,
      'end_date': endDate,
      'business_name': businessName,
      'business_image': businessImage,
    };
  }
}
