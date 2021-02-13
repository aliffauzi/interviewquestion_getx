import 'package:flutter/material.dart';
import 'package:interviewquestion/model/login/login_response.dart';
import 'package:interviewquestion/resource/api.dart';
import 'package:interviewquestion/resource/routes.dart';
import 'package:interviewquestion/shared/repository/firestore_database_repository.dart';
import 'package:interviewquestion/shared/repository/local_auth_repository.dart';
import 'package:interviewquestion/utils/extensions.dart';
import 'package:get/get.dart';
import 'package:interviewquestion/utils/state_status.dart';

class LoginController extends GetxController {
  var _localAuthRepository = Get.find<LocalAuthRepository>();
  var _fireStoreDatabaseRepository = Get.find<FireStoreDatabaseRepository>();

  var stateStatus = Rx<StateStatus>(StateStatus.INITIAL);

  var key = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  bool get isPasswordVisible => _passwordVisibleRx.value;

  String _email = '', _password = '';

  var _autoValidateRx = Rx<bool>(false);
  var _passwordVisibleRx = Rx<bool>(true);

  changeEmail(String value) {
    _email = value;
  }

  changePassword(String value) {
    _password = value;
  }

  checkAutoValidate() {
    _autoValidateRx.value = true;
  }

  togglePasswordVisibility() {
    this._passwordVisibleRx.value = !_passwordVisibleRx.value;
  }

  Future<void> callLogin() async {
    stateStatus.value = StateStatus.LOADING;

    _fireStoreDatabaseRepository.login(_email, _password).then((value) {
      stateStatus.value = StateStatus.SUCCESS;

      if (value.docs.isEmpty) {
        passwordController.clear();
        toast(message: 'Email or password not exist', title: 'Login');
      } else {
        var _login = value.docs
            .map<LoginResponse>(
                (response) => LoginResponse.fromDocumentSnapshot(response))
            .toList()[0];

        session(
            name: _login.name,
            email: _login.email,
            profilePictureUrl: _login.profilePicture,
            userId: _login.id,
            mobile: _login.mobile,
            whereLogin: _login.whereLogin);

        _clearTextField();

        Get.offNamedUntil(homeRoute, (_) => false);
      }
    });
  }

  Future<void> callGoogleLogin() async {
    _clearTextField();

    _fireStoreDatabaseRepository.googleLogin().then((user) {
      if (user != null) {
        stateStatus.value = StateStatus.SUCCESS;

        _fireStoreDatabaseRepository.login(user.email, null).then((value) {
          if (value.docChanges.isNotEmpty) {
            var _login = value.docs
                .map<LoginResponse>(
                    (response) => LoginResponse.fromDocumentSnapshot(response))
                .toList()[0];

            _localAuthRepository.setSession(
                SECURE_STORAGE_USERNAME, _login.name);
            _localAuthRepository.setSession(SECURE_STORAGE_EMAIL, _login.email);
            _localAuthRepository.setSession(
                SECURE_STORAGE_PROFILE_URL, _login.profilePicture);
            _localAuthRepository.setSession(SECURE_STORAGE_TOKEN, '');
            _localAuthRepository.setSession(SECURE_STORAGE_USER_ID, _login.id);
            _localAuthRepository.setSession(
                SECURE_STORAGE_MOBILE, _login.mobile);
            _localAuthRepository.setSession(SECURE_STORAGE_ADDRESS, '');
            _localAuthRepository.setSession(
                SECURE_STORAGE_WHERE_LOGIN, _login.whereLogin);
            _localAuthRepository.setSession(
                SECURE_STORAGE_ON_BOARDING, ON_BOARDING);

            _clearTextField();

            Get.offNamedUntil(homeRoute, (_) => false);
          } else {
            var param = new Map<String, dynamic>();
            param['name'] = user.displayName.split(' ')[0];
            param['email'] = user.email.toLowerCase();
            param['password'] = null;
            param['firebasetoken'] = null;
            param['socialid'] = user.uid;
            param['mobile'] = user.phoneNumber;
            param['address'] = null;
            param['wherelogin'] = WHERE_GOOGLE_LOGIN;
            param['adminapprove'] = 1;
            param['profilepicture'] = user.photoURL;
            param['createsignup'] = DateTime.now().toUtc();

            _fireStoreDatabaseRepository.signUp(param).then((value) {
              session(
                  name: user.displayName.split(' ')[0],
                  email: user.email.toLowerCase(),
                  profilePictureUrl: user.photoURL,
                  userId: user.uid,
                  mobile: user.phoneNumber,
                  whereLogin: WHERE_GOOGLE_LOGIN);
              stateStatus.value = StateStatus.SUCCESS;
              _clearTextField();

              Get.offNamedUntil(homeRoute, (_) => false);
            });
          }
        });
      }
    });
  }

  void session(
      {String name,
      String email,
      String profilePictureUrl,
      String userId,
      String mobile,
      String pinCode = '',
      String address = '',
      String whereLogin}) {
    _localAuthRepository.setSession(SECURE_STORAGE_USERNAME, name);
    _localAuthRepository.setSession(SECURE_STORAGE_EMAIL, email);
    _localAuthRepository.setSession(
        SECURE_STORAGE_PROFILE_URL, profilePictureUrl);
    _localAuthRepository.setSession(SECURE_STORAGE_TOKEN, '');
    _localAuthRepository.setSession(SECURE_STORAGE_USER_ID, userId);
    _localAuthRepository.setSession(SECURE_STORAGE_MOBILE, mobile);
    _localAuthRepository.setSession(SECURE_STORAGE_ADDRESS, '');
    _localAuthRepository.setSession(SECURE_STORAGE_WHERE_LOGIN, whereLogin);
    _localAuthRepository.setSession(SECURE_STORAGE_ON_BOARDING, ON_BOARDING);
  }

  Future<void> callFacebookLogin() async {}

  _clearTextField() {
    if (_email.isNotEmpty || _password.isNotEmpty) {
      emailController.clear();
      passwordController.clear();

      _email = '';
      _password = '';
    }
  }

  signUpLink() => Get.toNamed(signUpRoute);

  String isPasswordValid(String value) => value.validatePassword();

  String isEmailValid(String value) => value.validateEmail();

  @override
  void dispose() {
    super.dispose();
    _clearTextField();
  }
}
