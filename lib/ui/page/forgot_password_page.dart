import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interviewquestion/utils/extensions.dart';
import 'package:interviewquestion/controller/controller.dart';
import 'package:interviewquestion/resource/colors.dart';
import 'package:interviewquestion/resource/images.dart';
import 'package:interviewquestion/resource/style.dart';
import 'package:interviewquestion/resource/value.dart';

class ForgotPasswordPage extends GetView<ForgotPasswordController> {
  @override
  Widget build(BuildContext context) => Scaffold(
      body: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: controller.key,
          child: ListView(children: [_formUI()])));

  _formUI() => Obx(() => Container(
      padding: EdgeInsets.all(20),
      child: Column(children: <Widget>[
        size(heightScale: 100.0),
        _formIcon(),
        Text(titleForgotPassword, style: appBarTitleStyle),
        Text(labelForgotPassword,
            textAlign: TextAlign.center, style: appBarSubTitleStyle),
        size(heightScale: 30.0),
        _emailInput(),
        size(heightScale: 20.0),
        _forgotPasswordPress()
      ])));

  _formIcon() => Center(
      child: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Image.asset(appIconImage)));

  _forgotPasswordPress() =>
      Align(alignment: Alignment.bottomCenter).customFloatForm(
          color: appBarTitleColor,
          stateStatus: controller.stateStatus.value,
          icon: Icons.navigate_next,
          isMini: false,
          qrCallback: () => _forgotPasswordValidate());

  _forgotPasswordValidate() {
    FocusScope.of(Get.context).requestFocus(FocusNode());

    switch (controller.key.currentState.validate()) {
      case true:
        controller.key.currentState.save();
        controller.callForgotPassword();
        break;
      case false:
        controller.checkAutoValidate();
        break;
    }
  }

  _emailInput() => inputField(controller.emailController,
      validation: controller.isEmailValid,
      onChanged: controller.changeEmail,
      labelText: hintEmail,
      keyboardType: TextInputType.emailAddress);
}
