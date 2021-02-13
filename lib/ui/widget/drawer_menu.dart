import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interviewquestion/resource/api.dart';
import 'package:interviewquestion/resource/images.dart';
import 'package:interviewquestion/resource/style.dart';
import 'package:interviewquestion/resource/value.dart';
import 'package:recase/recase.dart';
import 'dialog_exit.dart';

class DrawerMenu extends StatelessWidget {
  final String userName, email, profileURL, whereLogin;
  final ValueChanged<String> drawerCallBack;

  DrawerMenu(
      {@required this.userName,
      @required this.email,
      @required this.profileURL,
      @required this.whereLogin,
      this.drawerCallBack});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      ListTile(
          leading: CircleAvatar(
              backgroundColor: Colors.grey.withOpacity(0.1),
              backgroundImage: profileURL == null
                  ? ExactAssetImage(profileImage)
                  : CachedNetworkImageProvider(profileURL)),
          title: Text(userName.titleCase, style: drawerUserNameStyle),
          subtitle: Text(email.toLowerCase(), style: drawerEmailStyle),
          onTap: () {}),
      whereLogin == WHERE_LOGIN
          ? ListTile(
              leading: Icon(changePasswordIcon, size: 16),
              title: Text(titleChangePassword, style: drawerMenuStyle),
              onTap: () => drawerCallBack(titleChangePassword))
          : Container(),
          ListTile(
              leading: Icon(freeCode, size: 16),
              title: Text(titleFreeCode, style: drawerMenuStyle),
              onTap: () => drawerCallBack(titleFreeCode)),
      ListTile(
          leading: Icon(contactUs, size: 16),
          title: Text(titleContactUs, style: drawerMenuStyle),
          onTap: () => drawerCallBack(titleContactUs)),
      ListTile(
          leading: Icon(logoutIcon, size: 16),
          title: Text(titleLogout, style: drawerMenuStyle),
          onTap: () {
            Get.back();
            showDialog(
                context: context,
                builder: (_) => DialogExit(
                    callBackCancel: () => Get.back(),
                    callBackOk: () => drawerCallBack(titleLogout)));
          })
    ]));
  }
}
