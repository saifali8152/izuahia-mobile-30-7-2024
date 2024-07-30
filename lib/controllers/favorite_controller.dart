import 'package:get/get.dart';
import 'package:izuahia/models/favorites_model.dart';
import 'package:izuahia/repository/profile_repo.dart';

class FavoritesController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<FavoriteModel> allFavoritesList = RxList();
  ProfileRepo repo = ProfileRepo();

  @override
  onInit() {
    getAllFavorites();
    super.onInit();
  }

  Future<void> getAllFavorites() async {
    allFavoritesList.assignAll(await repo.getAllFavorites());
    isLoading.value = false;
    update();
  }

  Future<void> reloadAllFavorites() async {
    isLoading.value = true;
    update();
    allFavoritesList.assignAll(await repo.getAllFavorites());
    isLoading.value = false;
    update();
  }

  Future<void> deleteFavorite({required String favoriteId}) async {
    Get.back();
    await repo.deleteFavorite(favoriteId: favoriteId);

    reloadAllFavorites();
  }
}
