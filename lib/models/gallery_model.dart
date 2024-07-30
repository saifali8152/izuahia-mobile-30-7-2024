class GalleryModel {
  final List<GalleryData> data;
  final String error;

  GalleryModel({
    required this.data,
    required this.error,
  });

  factory GalleryModel.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List;
    List<GalleryData> galleryDataList =
        dataList.map((item) => GalleryData.fromJson(item)).toList();

    return GalleryModel(
      data: galleryDataList,
      error: json['error'],
    );
  }
}

class GalleryData {
  final String ugId;
  final String galleryImage;
  final String userIdFk;

  GalleryData({
    required this.ugId,
    required this.galleryImage,
    required this.userIdFk,
  });

  factory GalleryData.fromJson(Map<String, dynamic> json) {
    return GalleryData(
      ugId: json['ug_id'],
      galleryImage: json['gallery_image'],
      userIdFk: json['user_id_fk'],
    );
  }
}
