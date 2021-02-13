import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interviewquestion/resource/api.dart';
import 'package:interviewquestion/resource/routes.dart';
import 'package:interviewquestion/resource/value.dart';
import 'package:interviewquestion/shared/repository/firestore_database_repository.dart';
import 'package:interviewquestion/shared/repository/local_auth_repository.dart';
import 'package:interviewquestion/ui/page/favourite_question_page.dart';
import 'package:interviewquestion/ui/page/technology_page.dart';
import 'package:interviewquestion/ui/page/page.dart';
import 'package:interviewquestion/ui/page/subject_page.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  var _localAuthRepository = Get.find<LocalAuthRepository>();
  var fireStoreDatabaseRepository = Get.find<FireStoreDatabaseRepository>();
  String indexId ='';

  var searchController = TextEditingController();
  PageController pageController;

  var currentPageIndex = Rx<int>(0);
  var drawerMenuIndex = Rx<int>(0);

  var secureStorageUserName = Rx<String>('');
  var secureStorageProfileURL = Rx<String>('');
  var secureStorageEmail = Rx<String>('');
  var secureStorageMobile = Rx<String>('');
  var secureStoragePinCode = Rx<String>('');
  var secureStorageAddress = Rx<String>('');
  var secureStorageWhereLogin = Rx<String>('');
  var secureStorageUserId = Rx<String>('');

  @override
  onInit() {
    super.onInit();
    pageController = PageController(initialPage: currentPageIndex.value);
    getUserDetails();
  }

  onTabChange(int index) {
    currentPageIndex.value = index;

    if (drawerMenuIndex.value > 3) drawerMenuIndex.value = 0;
  }

  drawerMenuChange(int index) {
    drawerMenuIndex.value = index;
  }

  _tabPages(int index) {
    switch (index) {
      case subjectIndex:
        return SubjectPage();
        break;
      case favouriteIndex:
        return FavouriteQuestionPage();
        break;
      case technologyIndex:
        return TechnologyPage();
        break;
      case profileIndex:
        return ProfileEditPage();
        break;
    }
  }

  redirectPage() {
    return _tabPages(currentPageIndex.value);
  }

  void getUserDetails() {
    secureStorageUserId.value =
        _localAuthRepository.getSession(SECURE_STORAGE_USER_ID);
    secureStorageUserName.value =
        _localAuthRepository.getSession(SECURE_STORAGE_USERNAME);
    secureStorageProfileURL.value =
        _localAuthRepository.getSession(SECURE_STORAGE_PROFILE_URL);
    secureStorageEmail.value =
        _localAuthRepository.getSession(SECURE_STORAGE_EMAIL);
    secureStorageMobile.value =
        _localAuthRepository.getSession(SECURE_STORAGE_MOBILE);
    secureStorageAddress.value =
        _localAuthRepository.getSession(SECURE_STORAGE_ADDRESS);
    secureStorageWhereLogin.value =
        _localAuthRepository.getSession(SECURE_STORAGE_WHERE_LOGIN);
  }

  void setUserDetails(
      {String userName,
      String email,
      String mobile,
      String address,
      String profileUrl}) {
    _localAuthRepository.setSession(SECURE_STORAGE_USERNAME, userName);
    _localAuthRepository.setSession(SECURE_STORAGE_MOBILE, mobile);
    _localAuthRepository.setSession(SECURE_STORAGE_EMAIL, email);
    _localAuthRepository.setSession(SECURE_STORAGE_ADDRESS, address);
  }

  Future<void> callLogout() async {
    _localAuthRepository.clearSession();
    fireStoreDatabaseRepository.googleLogout();

    //Get.offAllNamed(loginRoute);
    Get.offNamedUntil(loginRoute, (_) => false);
  }

  @override
  onClose() {
    super.onClose();
    pageController.dispose();

    secureStorageUserName.value = '';
    secureStorageProfileURL.value = '';
    secureStorageEmail.value = '';
    secureStorageMobile.value = '';
    secureStoragePinCode.value = '';
    secureStorageAddress.value = '';
  }
}
