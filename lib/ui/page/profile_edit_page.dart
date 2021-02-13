import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interviewquestion/utils/extensions.dart';
import 'package:interviewquestion/controller/controller.dart';
import 'package:interviewquestion/resource/colors.dart';
import 'package:interviewquestion/resource/images.dart';
import 'package:interviewquestion/resource/style.dart';
import 'package:interviewquestion/resource/value.dart';

class ProfileEditPage extends GetView<ProfileEditController> {
  @override
  Widget build(BuildContext context) => Scaffold(
      body: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: controller.key,
          child: ListView(children: [_formUI()])));

  _formUI() => Container(
      padding: EdgeInsets.all(20),
      child: Column(children: <Widget>[
        _profileImage(),
        size(heightScale: 30.0),
        _userNameInput(),
        IgnorePointer(child: _emailInput()),
        _mobileInput(),
        _addressInput(),
        size(heightScale: 20.0),
        _profileEditPress(),
        SizedBox(height: 10.0)
      ]));

  _profileImage() => Column(children: [
        Obx(() => CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey.withOpacity(0.1),
            backgroundImage: controller.imagePickerPath.value == null
                ? ExactAssetImage(profileImage)
                : CachedNetworkImageProvider(controller.profileURL.value))),
        Obx(() => Text(controller.userName.value, style: appBarTitleStyle))
      ]);

  _profileEditPress() =>
      Align(alignment: Alignment.bottomCenter).customFloatForm(
          color: appBarTitleColor,
          stateStatus: controller.stateStatus.value,
          icon: Icons.navigate_next,
          isMini: false,
          qrCallback: () => _profileEditValidate());

  _profileEditValidate() {
    FocusScope.of(Get.context).requestFocus(FocusNode());

    switch (controller.key.currentState.validate()) {
      case true:
        controller.key.currentState.save();
        controller.callProfile();
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

  _mobileInput() => inputField(controller.mobileController,
      validation: controller.isMobileValid,
      onChanged: controller.changeMobile,
      maxLength: mobileMaxLength,
      labelText: hintMobile,
      keyboardType: TextInputType.number);

  _addressInput() => inputField(controller.addressController,
      validation: controller.isAddressValid,
      onChanged: controller.changeAddress,
      labelText: hintAddress,
      keyboardType: TextInputType.text);
}
