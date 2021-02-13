import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interviewquestion/shared/repository/firestore_database_repository.dart';
import 'package:interviewquestion/utils/state_status.dart';
import 'package:interviewquestion/utils/extensions.dart';
import 'home_controller.dart';

class ProfileEditController extends GetxController {
  var _homeController = Get.put(HomeController());
  var fireStoreDatabaseRepository = Get.find<FireStoreDatabaseRepository>();
  var stateStatus = Rx<StateStatus>(StateStatus.INITIAL);

  var key = GlobalKey<FormState>();

  var userNameController = TextEditingController();
  var emailController = TextEditingController();
  var mobileController = TextEditingController();
  var addressController = TextEditingController();

  String _userName = '', _email = '', _mobile = '', _address = '';

  var autoValidate = Rx<bool>(false);
  var profileURL = Rx<String>('');
  var userName = Rx<String>();
  var email = Rx<String>();
  var address = Rx<String>();
  var imagePickerPath = Rx<String>();

  changeUserName(String value) {
    _userName = value;
  }

  changeEmail(String value) {
    _email = value;
  }

  changeMobile(String value) {
    _mobile = value;
  }

  changeAddress(String value) {
    _address = value;
  }

  checkAutoValidate() {
    autoValidate.value = true;
  }

  @override
  onInit() {
    super.onInit();
    _homeController.getUserDetails();

    userNameController.text = _homeController.secureStorageUserName.value;
    emailController.text = _homeController.secureStorageEmail.value;
    mobileController.text = _homeController.secureStorageMobile.value;
    addressController.text = _homeController.secureStorageAddress.value;

    profileURL.value = _homeController.secureStorageProfileURL.value;
    userName.value = _homeController.secureStorageUserName.value;
    email.value = _homeController.secureStorageEmail.value;
    address.value = _homeController.secureStorageAddress.value;
  }

  setImagePickerPath(String path) {
    imagePickerPath.value = path;
  }

  Future<void> callProfile() async {
    stateStatus.value = StateStatus.LOADING;
    _homeController.setUserDetails(
      userName: _userName == ''
          ? _homeController.secureStorageUserName.value
          : _userName,
      email: _email == '' ? _homeController.secureStorageEmail.value : _email,
      mobile:
          _mobile == '' ? _homeController.secureStorageMobile.value : _mobile,
      address: _address == ''
          ? _homeController.secureStorageAddress.value
          : _address,
    );

    _homeController.getUserDetails();
    fireStoreDatabaseRepository.profileEdit(
        _homeController.secureStorageUserId.value,
        _homeController.secureStorageUserName.value,
        _homeController.secureStorageEmail.value,
        _homeController.secureStorageMobile.value,
        _homeController.secureStorageAddress.value);

    userName.value = _homeController.secureStorageUserName.value;
    stateStatus.value = StateStatus.SUCCESS;

    //_clearTextField();
    Get.back();
  }

  _clearTextField() {
    userNameController.clear();
    mobileController.clear();
    addressController.clear();
  }

  String isUserNameValid(String value) => value.validUserName();

  String isEmailValid(String value) => value.validateEmail();

  String isMobileValid(String value) => value.validateMobile();

  String isPinCodeValid(String value) => value.validatePinCode();

  String isAddressValid(String value) => value.validateAddress();

  @override
  void dispose() {
    super.dispose();
    _userName = '';
    _mobile = '';
    _address = '';

    _clearTextField();
  }
}
