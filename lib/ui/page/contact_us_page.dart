import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interviewquestion/resource/colors.dart';
import 'package:interviewquestion/resource/images.dart';
import 'package:interviewquestion/resource/style.dart';
import 'package:interviewquestion/resource/value.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: appBarElevation,
            leading: IconButton(
                onPressed: () => Get.back(),
                icon: Icon(backIcon, size: 18, color: appBarTitleColor)),
            title: Text(titleContactUs, style: appBarTitleStyle)),
        body: ListView(children: [
          ListTile(
              title: Text(developerName, style: contactUsNameStyle),
              subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(developerWebSite, style: contactUsLabelStyle),
                    Text(developerSkill, style: contactUsLabelStyle)
                  ])),
          ListTile(
              leading: Icon(LineIcons.contao),
              title: Text(hintEmail, style: contactUsLabelStyle),
              subtitle: Text(developerEmail, style: contactUsDescriptionStyle)),
          ListTile(
              leading: Icon(LineIcons.skype),
              title: Text(labelSocialSkype, style: contactUsLabelStyle),
              subtitle: Text(developerSkype, style: contactUsDescriptionStyle)),
          ListTile(
              leading: Icon(LineIcons.mobilePhone),
              trailing: GestureDetector(
                  child: Icon(LineIcons.phone, color: appBarTitleColor),
                  onTap: () => launch("tel://$developerMobile")),
              title: Text(hintMobile, style: contactUsLabelStyle),
              subtitle: Text(developerMobile, style: contactUsDescriptionStyle))
        ]));
  }
}
