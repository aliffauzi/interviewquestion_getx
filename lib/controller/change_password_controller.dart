import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interviewquestion/resource/value.dart';
import 'package:interviewquestion/shared/repository/firestore_database_repository.dart';
import 'package:interviewquestion/utils/state_status.dart';
import 'package:interviewquestion/utils/extensions.dart';
import 'controller.dart';

class ChangePasswordController extends GetxController {
  var stateStatus = Rx<StateStatus>(StateStatus.INITIAL);

  var newPasswordController = TextEditingController();
  var newConfirmPasswordController = TextEditingController();
  var currentPasswordController = TextEditingController();

  var key = GlobalKey<FormState>();
  var fireStoreDatabaseRepository = Get.find<FireStoreDatabaseRepository>();
  var _homeController = Get.put(HomeController());

  String _changePassword = '',
      _changeConfirmPassword = '',
      _changeCurrentPassword;

  var autoValidate = Rx<bool>(false);
  var passwordVisible = Rx<bool>(true);

  newPassword(String value) {
    _changePassword = value;
  }

  newConfirmPassword(String value) {
    _changeConfirmPassword = value;
  }

  currentPassword(String value) {
    _changeCurrentPassword = value;
  }

  checkAutoValidate() {
    autoValidate.value = true;
  }

  togglePasswordVisibility() {
    this.passwordVisible.value = !passwordVisible.value;
  }

  Future<void> callChangePassword() async {
    stateStatus.value = StateStatus.LOADING;

    fireStoreDatabaseRepository.changePassword(_homeController.secureStorageUserId.value, currentPasswordController.text, _changeConfirmPassword);
    stateStatus.value = StateStatus.SUCCESS;

    _clearTextField();
    Get.back();

    toast(title: titleChangePassword, message: changePasswordMessage);
  }

  _clearTextField() {
    newPasswordController.clear();
    newConfirmPasswordController.clear();
    currentPasswordController.clear();

    _changePassword = '';
    _changeConfirmPassword = '';
    _changeCurrentPassword = '';
  }

  String isNewPasswordValid(String value) => value.validateCurrentPassword();

  String isCurrentPasswordValid(String value) =>
      value.validateCurrentPassword();

  @override
  void dispose() {
    super.dispose();
    _clearTextField();
  }
}
