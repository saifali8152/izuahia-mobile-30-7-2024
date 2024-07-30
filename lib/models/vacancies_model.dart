class VacanciesModel {
  final String jvId;
  final String jobTitle;
  final String jobFor;
  final String jobType;
  final String jobDescription;
  final String jobSalary;
  final String workingHours;
  final String jobRequirements;
  final String businessIdFk;
  final String createdAt;
  final String businessName;
  final String businessImage;
  int isApplied;

  VacanciesModel({
    required this.jvId,
    required this.jobTitle,
    required this.jobFor,
    required this.jobType,
    required this.jobDescription,
    required this.jobSalary,
    required this.workingHours,
    required this.jobRequirements,
    required this.businessIdFk,
    required this.createdAt,
    required this.businessName,
    required this.businessImage,
    required this.isApplied,
  });

  factory VacanciesModel.fromJson(Map<String, dynamic> json) {
    return VacanciesModel(
      jvId: json['jv_id'],
      jobTitle: json['job_title'],
      jobFor: json['job_for'],
      jobType: json['job_type'],
      jobDescription: json['job_description'],
      jobSalary: json['job_salary'],
      workingHours: json['working_hours'],
      jobRequirements: json['job_requirements'],
      businessIdFk: json['business_id_fk'],
      createdAt: json['created_at'],
      businessName: json['business_name'],
      businessImage: json['business_image'],
      isApplied: json['is_applied'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'jv_id': jvId,
      'job_title': jobTitle,
      'job_for': jobFor,
      'job_type': jobType,
      'job_description': jobDescription,
      'job_salary': jobSalary,
      'working_hours': workingHours,
      'job_requirements': jobRequirements,
      'business_id_fk': businessIdFk,
      'created_at': createdAt,
      'business_name': businessName,
      'business_image': businessImage,
      'is_applied': isApplied,
    };
  }
}