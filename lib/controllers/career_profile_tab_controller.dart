import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izuahia/models/career_history_model.dart';
import 'package:izuahia/models/vacancies_model.dart';
import 'package:izuahia/repository/career_repo.dart';
import 'package:izuahia/repository/local/shared_prefs.dart';
import 'package:url_launcher/url_launcher.dart';

class CareerProfileTabController extends GetxController {
  TextEditingController? summmaryController;
  TextEditingController? descriptionController;
  RxBool isEditable = false.obs;

  RxString resumeController = ''.obs;
  FilePickerResult? result;
  Rx<File?> resumeFile = Rx<File?>(null);

  final CareerRepo repo = CareerRepo();

  RxBool isHistoryLoading = true.obs;
  RxBool isVacanciesLoading = true.obs;
  RxList<CareerHistoryModel> careerHistoryList = RxList();
  List<VacanciesModel> allVacancies = [];
  RxList<VacanciesModel> filteredVacanciesList = RxList();

  @override
  void onInit() {
    summmaryController = TextEditingController(text: SharedPrefs().getString("summary"));
    descriptionController = TextEditingController(text: SharedPrefs().getString("description"));
    resumeController = RxString(SharedPrefs().getString("resume")!.isNotEmpty ? "resume.pdf" : "");
    getCareerHistory();
    getVacancies();
    super.onInit();
  }

  Rx<String> searchString = ''.obs;
  void setSearchString(String value) {
    searchString.value = value.toLowerCase();
    filterVacancies();
  }

  void filterVacancies() {
    String search = searchString.value;

    final filteredList = allVacancies.where((vacancy) {
      bool matchesSearch = false;
      matchesSearch = vacancy.businessName.toLowerCase().contains(search) ||
          vacancy.jobTitle.toLowerCase().contains(search) ||
          search.isEmpty;
      return matchesSearch;
    }).toList();

    filteredVacanciesList.assignAll(filteredList); // Update filteredRequestsList
    log("search: $search filtered list: \n $filteredVacanciesList");
  }

  Future<void> pickResume() async {
    result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: false,
    );
    if (result != null) {
      resumeFile.value = File(result!.files.single.path!);
      resumeController.value = resumeFile.value!.path;
    }
    update();
  }

  Future<void> openResume() async {
    final String resumeURL = SharedPrefs().getString("resume") ?? "";

    if (resumeURL.isNotEmpty) {
      if (await canLaunchUrl(
        Uri.parse(resumeURL),
      )) {
        launchUrl(
          Uri.parse(resumeURL),
        );
      }
    }
  }

  void toggleEditable() {
    isEditable.value = !isEditable.value;
  }

  Future<void> updateProfile() async {
    await repo.updateCareerProfile(
      summary: summmaryController!.text,
      description: descriptionController!.text,
    );
    summmaryController!.text = SharedPrefs().getString("summary") ?? "";
    summmaryController!.text = SharedPrefs().getString("description") ?? "";
    update();
  }

  Future<void> deleteResume() async {
    await repo.deleteResume();
    resumeController.value = SharedPrefs().getString("resume")!.isNotEmpty ? "resume.pdf" : "";
    update();
  }

  Future<void> uploadResume() async {
    await repo.updateResume(resumeFile: File(resumeController.value));
    resumeController.value = SharedPrefs().getString("resume")!.isNotEmpty ? "resume.pdf" : "";
    update();
  }

  Future<void> getCareerHistory() async {
    careerHistoryList.assignAll(await repo.getCareerHistory());
    isHistoryLoading.value = false;
    update();
  }

  Future<void> getVacancies() async {
    isVacanciesLoading.value = true;
    allVacancies = await repo.getAllVacancies();
    filteredVacanciesList.assignAll(allVacancies);
    isVacanciesLoading.value = false;
  }

  Future<void> applyToJob({required String jobVacancyId}) async {
    bool isApplied = true;
    await repo.applyToJob(jobVacancyId: jobVacancyId);
    if (isApplied) {
      filteredVacanciesList.firstWhere((vacanciesModel) {
        return vacanciesModel.jvId == jobVacancyId;
      }).isApplied = 1;
    }
    filteredVacanciesList.refresh();
  }
}
