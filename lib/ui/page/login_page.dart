import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interviewquestion/resource/routes.dart';
import 'package:interviewquestion/utils/extensions.dart';
import 'package:interviewquestion/controller/controller.dart';
import 'package:interviewquestion/resource/colors.dart';
import 'package:interviewquestion/resource/images.dart';
import 'package:interviewquestion/resource/style.dart';
import 'package:interviewquestion/resource/value.dart';

class LoginPage extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) => Scaffold(
      body: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: controller.key,
          child: ListView(children: [_formUI()])));

  _formUI() => Obx(() => Container(
      padding: EdgeInsets.all(20),
      child: Column(children: <Widget>[
        size(heightScale: 80.0),
        _formIcon(),
        size(heightScale: 30.0),
        _emailInput(),
        _passwordInput(),
        size(heightScale: 20.0),
        _loginPress(),
        SizedBox(height: 10.0),
        _login()
      ])));

  _login() => Column(children: <Widget>[
        RawMaterialButton(
            padding: const EdgeInsets.all(10),
            child: Text(linkForgotPassword, style: loginLinkStyle(linkColor)),
            onPressed: () => Get.toNamed(forgotPasswordRoute)),
        SizedBox(height: 30.0),
        _socialLogin(),
        SizedBox(height: 20.0),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Text(labelSignUp, style: doNotHaveAccountStyle(Colors.black)),
          RawMaterialButton(
              padding: EdgeInsets.all(10),
              child: Text(linkSignUp, style: loginLinkStyle(linkColor)),
              onPressed: () => controller.signUpLink())
        ])
      ]);

  _formIcon() => Center(
      child: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Image.asset(appIconImage)));

  _loginPress() => Align(alignment: Alignment.bottomCenter).customFloatForm(
      color: appBarTitleColor,
      stateStatus: controller.stateStatus.value,
      icon: Icons.navigate_next,
      isMini: false,
      qrCallback: () => _loginValidate());

  _loginValidate() {
    FocusScope.of(Get.context).requestFocus(FocusNode());

    switch (controller.key.currentState.validate()) {
      case true:
        controller.key.currentState.save();
        controller.callLogin();
        break;
      case false:
        controller.checkAutoValidate();
        break;
    }
  }

  _socialLogin() => Container(
      height: 60,
      child:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        socialIcon(
            icon: Icon(googleIcon, color: socialBackgroundColor, size: 25),
            backgroundColor: googleColor,
            voidCallback: () => controller.callGoogleLogin()),
        /*SizedBox(width: 30),
        widget.socialIcon(
            icon: Icon(facebookLogin, color: socialBackgroundColor, size: 25),
            backgroundColor: facebookColor,
            voidCallback: () => _loginController.callFacebookLogin())*/
      ]));

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
}
