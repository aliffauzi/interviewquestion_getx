import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:interviewquestion/model/login/login_response.dart';
import 'package:interviewquestion/resource/api.dart';
import 'package:interviewquestion/resource/value.dart';
import 'package:interviewquestion/shared/repository/firestore_database_repository.dart';
import 'package:interviewquestion/utils/extensions.dart';
import 'package:get/get.dart';
import 'package:interviewquestion/utils/state_status.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class ForgotPasswordController extends GetxController {
  var fireStoreDatabaseRepository = Get.find<FireStoreDatabaseRepository>();

  var stateStatus = Rx<StateStatus>(StateStatus.INITIAL);
  var emailController = TextEditingController();

  String _email = '';

  var key = GlobalKey<FormState>();
  var _autoValidate = Rx<bool>(false);

  changeEmail(String value) {
    _email = value;
  }

  checkAutoValidate() {
    _autoValidate.value = true;
  }

  Future<void> callForgotPassword() async {
    stateStatus.value = StateStatus.LOADING;

    fireStoreDatabaseRepository
        .forgotPassword(_email.toLowerCase())
        .then((QuerySnapshot value) async {

      if (value.size > 0) {
        var _login = value.docs
            .map<LoginResponse>(
                (response) => LoginResponse.fromDocumentSnapshot(response))
            .toList()[0];

        final smtpServer = gmail(smtpEmail, smtpPassword);
        final message = Message()
          ..from = Address(smtpEmail, appName)
          ..recipients.add(_login.email)
          ..subject = 'Forgot password'
          ..text = 'Thank You'
          ..html =
              '<h4>We are sending you this email because you requested a password get.</h4><p>' +
                  'Your password is: ' +
                  _login.password +
                  '</p>';

        var connection = PersistentConnection(smtpServer);
        await connection.send(message);
        await connection.close();

        stateStatus.value = StateStatus.SUCCESS;
        Get.back();
        _clearTextField();
        toast(message: 'Sent the email successful', title: titleForgotPassword);
      } else {
        stateStatus.value = StateStatus.SUCCESS;
        toast(message: 'Email not exit', title: titleForgotPassword);
        _clearTextField();
      }
    });
  }

  _clearTextField() {
    emailController.clear();
    _email = '';
  }

  String isEmailValid(String value) => value.validateEmail();

  @override
  void dispose() {
    super.dispose();
    _clearTextField();
  }
}
