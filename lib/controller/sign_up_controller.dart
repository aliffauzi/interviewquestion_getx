import 'package:flutter/material.dart';
import 'package:interviewquestion/resource/api.dart';
import 'package:interviewquestion/resource/routes.dart';
import 'package:interviewquestion/shared/repository/firestore_database_repository.dart';
import 'package:interviewquestion/shared/repository/local_auth_repository.dart';
import 'package:interviewquestion/utils/extensions.dart';
import 'package:get/get.dart';
import 'package:interviewquestion/utils/state_status.dart';

class SingUpController extends GetxController {
  var _localAuthRepository = Get.find<LocalAuthRepository>();
  var fireStoreDatabaseRepository = Get.find<FireStoreDatabaseRepository>();

  var stateStatus = Rx<StateStatus>(StateStatus.INITIAL);

  var key = GlobalKey<FormState>();

  var userNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var mobileController = TextEditingController();

  bool get isPasswordVisible => _passwordVisibleRx.value;

  String _userName = '',
      _email = '',
      _password = '',
      _confirmPassword = '',
      _mobile = '';

  final _autoValidateRx = Rx<bool>(false);
  final _passwordVisibleRx = Rx<bool>(true);

  final secureStorageUserName = Rx<String>('');
  final secureStorageProfileURL = Rx<String>('');
  final secureStorageEmail = Rx<String>('');

  changeUserName(String value) {
    _userName = value;
  }

  changeEmail(String value) {
    _email = value;
  }

  changePassword(String value) {
    _password = value;
  }

  changeConfirmPassword(String value) {
    _confirmPassword = value;
  }

  changeMobile(String value) {
    _mobile = value;
  }

  checkAutoValidate() {
    _autoValidateRx.value = true;
  }

  togglePasswordVisibility() {
    this._passwordVisibleRx.value = !_passwordVisibleRx.value;
  }

  Future<void> callSignUp() async {
    stateStatus.value = StateStatus.LOADING;

    fireStoreDatabaseRepository.checkEmail(_email.toLowerCase()).then((value) {
      if (value > 0) {
        stateStatus.value = StateStatus.SUCCESS;
        toast(message: 'Email already exit', title: 'Sign up');
      } else {
        var param = new Map<String, dynamic>();
        param['name'] = _userName;
        param['email'] = _email.toLowerCase();
        param['password'] = _password;
        param['firebasetoken'] = null;
        param['socialid'] = null;
        param['mobile'] = _mobile;
        param['address'] = null;
        param['wherelogin'] = WHERE_LOGIN;
        param['adminapprove'] = 1;
        param['profilepicture'] = null;
        param['createsignup'] = DateTime.now().toUtc();

        fireStoreDatabaseRepository.signUp(param).then((value) {
          stateStatus.value = StateStatus.SUCCESS;

          _localAuthRepository.setSession(SECURE_STORAGE_USERNAME, _userName);
          _localAuthRepository.setSession(SECURE_STORAGE_EMAIL, _email);
          _localAuthRepository.setSession(SECURE_STORAGE_PROFILE_URL, null);
          _localAuthRepository.setSession(SECURE_STORAGE_TOKEN, null);
          _localAuthRepository.setSession(SECURE_STORAGE_USER_ID, value);
          _localAuthRepository.setSession(SECURE_STORAGE_MOBILE, _mobile);
          _localAuthRepository.setSession(SECURE_STORAGE_ADDRESS, null);
          _localAuthRepository.setSession(SECURE_STORAGE_WHERE_LOGIN, WHERE_LOGIN);
          _localAuthRepository.setSession(SECURE_STORAGE_ON_BOARDING, ON_BOARDING);

          stateStatus.value = StateStatus.SUCCESS;
          _clearTextField();
          Get.offNamedUntil(homeRoute, (_) => false);
        });
      }
    });
  }

  _clearTextField() {
    userNameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    mobileController.clear();
  }

  String isUserNameValid(String value) => value.validUserName();

  String isPasswordValid(String value) => value.validatePassword();

  String isEmailValid(String value) => value.validateEmail();

  String isMobileValid(String value) => value.validateMobile();

  @override
  void dispose() {
    super.dispose();

    _userName = '';
    _email = '';
    _password = '';
    _confirmPassword = '';
    _mobile = '';

    userNameController.text = '';
    emailController.text = '';
    passwordController.text = '';
    confirmPasswordController.text = '';
    mobileController.text = '';
  }
}
