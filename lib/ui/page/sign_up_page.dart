import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interviewquestion/controller/controller.dart';
import 'package:interviewquestion/resource/colors.dart';
import 'package:interviewquestion/resource/images.dart';
import 'package:interviewquestion/resource/style.dart';
import 'package:interviewquestion/resource/value.dart';
import 'package:interviewquestion/utils/extensions.dart';

class SignUpPage extends GetView<SingUpController> {
  @override
  Widget build(BuildContext context) => Scaffold(
      body: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: controller.key,
          child: ListView(children: [_formUI()])));

  _formUI() => Obx(() => Container(
      padding: EdgeInsets.all(20),
      child: Column(children: <Widget>[
        size(heightScale: 50.0),
        _formIcon(),
        Padding(
            padding: EdgeInsets.all(10),
            child: Text(labelSignUpContent,
                textAlign: TextAlign.center, style: appBarTitleStyle)),
        size(heightScale: 30.0),
        _userNameInput(),
        _emailInput(),
        _passwordInput(),
        _confirmPassword(),
        _mobileInput(),
        size(heightScale: 20.0),
        _signUpPress(),
        SizedBox(height: 10.0)
      ])));

  _formIcon() => Center(
      child: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Image.asset(appIconImage)));

  _signUpPress() => Align(alignment: Alignment.bottomCenter).customFloatForm(
      color: appBarTitleColor,
      stateStatus: controller.stateStatus.value,
      icon: Icons.navigate_next,
      isMini: false,
      qrCallback: () => _signUpValidate());

  _signUpValidate() {
    FocusScope.of(Get.context).requestFocus(FocusNode());

    switch (controller.key.currentState.validate()) {
      case true:
        controller.key.currentState.save();
        controller.callSignUp();
        break;
      case false:
        controller.checkAutoValidate();
        break;
    }
  }

  _userNameInput() => inputField(controller.userNameController,
      validation: controller.isUserNameValid,
      onChanged: controller.changeUserName,
      labelText: hintUserName,
      keyboardType: TextInputType.text);

  _emailInput() => inputField(controller.emailController,
      validation: controller.isEmailValid,
      onChanged: controller.changeEmail,
      labelText: hintEmail,
      keyboardType: TextInputType.emailAddress);

  _passwordInput() => inputField(controller.passwordController,
      labelText: hintPassword,
      validation: controller.isPasswordValid,
      obscureText: controller.isPasswordVisible,
      onChanged: controller.changePassword,
      maxLength: passwordMaxLength,
      inkWell: InkWell(
          child: Icon(controller.isPasswordVisible
              ? passwordInVisibleIcon
              : passwordVisibleIcon),
          onTap: () => controller.togglePasswordVisibility()));

  _confirmPassword() => inputField(controller.confirmPasswordController,
          labelText: hintConfirmPassword, validation: (confirmation) {
        return confirmation.isEmpty
            ? 'Confirm password is required'
            : confirmation == controller.passwordController.text
                ? null
                : 'Password and confirm password not match';
      },
          obscureText: controller.isPasswordVisible,
          onChanged: controller.changeConfirmPassword,
          maxLength: passwordMaxLength,
          inkWell: InkWell(
              child: Icon(controller.isPasswordVisible
                  ? passwordInVisibleIcon
                  : passwordVisibleIcon),
              onTap: () => controller.togglePasswordVisibility()));

  _mobileInput() => inputField(controller.mobileController,
      validation: controller.isMobileValid,
      onChanged: controller.changeMobile,
      labelText: hintMobile,
      maxLength: mobileMaxLength,
      keyboardType: TextInputType.number);
}
