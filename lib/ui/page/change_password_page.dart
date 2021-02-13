import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interviewquestion/utils/extensions.dart';
import 'package:interviewquestion/controller/controller.dart';
import 'package:interviewquestion/resource/colors.dart';
import 'package:interviewquestion/resource/images.dart';
import 'package:interviewquestion/resource/style.dart';
import 'package:interviewquestion/resource/value.dart';

class ChangePasswordPage extends GetView<ChangePasswordController> {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
          elevation: appBarElevation,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(backIcon, size: 18, color: appBarTitleColor)),
          title: Text(titleChangePassword, style: appBarTitleStyle)),
      body: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: controller.key,
          child: ListView(children: [_formUI()])));

  _formUI() => Obx(() => Container(
      padding: EdgeInsets.all(20),
      child: Column(children: <Widget>[
        size(heightScale: 30.0),
        _newPasswordInput(),
        _newConfirmPasswordInput(),
        _currentPasswordInput(),
        size(heightScale: 20.0),
        _changePasswordPress(),
        SizedBox(height: 10.0)
      ])));

  _changePasswordPress() =>
      Align(alignment: Alignment.bottomCenter).customFloatForm(
          color: appBarTitleColor,
          stateStatus: controller.stateStatus.value,
          icon: Icons.navigate_next,
          isMini: false,
          qrCallback: () => _changePasswordValidate());

  _changePasswordValidate() {
    FocusScope.of(Get.context).requestFocus(FocusNode());

    switch (controller.key.currentState.validate()) {
      case true:
        controller.key.currentState.save();
        controller.callChangePassword();
        break;
      case false:
        controller.checkAutoValidate();
        break;
    }
  }

  _newPasswordInput() => inputField(controller.newPasswordController,
      labelText: hintNewPassword,
      validation: controller.isNewPasswordValid,
      obscureText: controller.passwordVisible.value,
      onChanged: controller.newPassword,
      maxLength: passwordMaxLength,
      inkWell: InkWell(
          child: Icon(controller.passwordVisible.value
              ? passwordInVisibleIcon
              : passwordVisibleIcon),
          onTap: () => controller.togglePasswordVisibility()));

  _newConfirmPasswordInput() =>
      inputField(controller.newConfirmPasswordController,
          labelText: hintNewConfirmPassword, validation: (value) {
        return value.isEmpty
            ? 'New confirm password is required'
            : value == controller.newPasswordController.text
                ? null
                : 'New Password and new confirm password not match';
      },
          obscureText: controller.passwordVisible.value,
          onChanged: controller.newConfirmPassword,
          maxLength: passwordMaxLength,
          inkWell: InkWell(
              child: Icon(controller.passwordVisible.value
                  ? passwordInVisibleIcon
                  : passwordVisibleIcon),
              onTap: () => controller.togglePasswordVisibility()));

  _currentPasswordInput() => inputField(controller.currentPasswordController,
      labelText: hintCurrentPassword,
      validation: controller.isCurrentPasswordValid,
      obscureText: controller.passwordVisible.value,
      onChanged: controller.newPassword,
      maxLength: passwordMaxLength,
      inkWell: InkWell(
          child: Icon(controller.passwordVisible.value
              ? passwordInVisibleIcon
              : passwordVisibleIcon),
          onTap: () => controller.togglePasswordVisibility()));
}
