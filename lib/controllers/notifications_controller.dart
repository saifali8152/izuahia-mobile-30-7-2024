import 'package:get/get.dart';
import 'package:izuahia/models/notifications_model.dart';
import 'package:izuahia/repository/notifications_repo.dart';

class NotificationsController extends GetxController {
  NotificationsRepo repo = NotificationsRepo();

  RxList<NotificationsModel> notificationsList = RxList();

  RxBool isLoading = true.obs;
  Rx<String> searchString = ''.obs;

  Rx<String> fromDate = ''.obs; // Initialize as empty string
  Rx<String> toDate = ''.obs; // Initialize as empty string

  @override
  void onInit() {
    getAllNotfications();
    super.onInit();
  }

  Future<void> getAllNotfications() async {
    notificationsList.assignAll(await repo.getAllNotifications());
    isLoading.value = false;
    update();
  }
}
