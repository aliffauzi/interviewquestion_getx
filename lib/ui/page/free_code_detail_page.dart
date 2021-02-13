import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:get/get.dart';
import 'package:interviewquestion/resource/api.dart';
import 'package:interviewquestion/resource/colors.dart';
import 'package:interviewquestion/resource/font.dart';
import 'package:interviewquestion/resource/images.dart';
import 'package:interviewquestion/resource/style.dart';
import 'package:interviewquestion/resource/value.dart';
import 'package:url_launcher/url_launcher.dart';

class FreeCodeDetailPage extends StatelessWidget {
  final _freeCodeResponse = Get.arguments;

  @override
  Widget build(BuildContext context) => Scaffold(
      bottomNavigationBar: _freeCodeResponse.sourceCodeURL != ""
          ? Container(
              padding: EdgeInsets.all(10),
              color: Colors.grey.withOpacity(0.1),
              child: GestureDetector(
                  onTap: () {
                    launch(_freeCodeResponse.sourceCodeURL);
                  },
                  child: Text(
                      '${_freeCodeResponse.isFreePaid == freeCodeGet ? 'Free' : 'Paid'} source code download',
                      textAlign: TextAlign.center,
                      style: freeCodeDownloadStyle)))
          : null,
      appBar: AppBar(
          elevation: appBarElevation,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(backIcon, size: 18, color: appBarTitleColor)),
          title: Text(_freeCodeResponse.name, style: appBarTitleStyle)),
      body: ListView(children: [
        Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('APPLICATION DEVELOP DETAILS',
                  style: freeCodeDetailLabelStyle),
              Row(children: [
                Text('Frontend: ', style: freeCodeDevelopLabelStyle),
                Text(_freeCodeResponse.frontend,
                    style: freeCodeDevelopDescriptionStyle)
              ]),
              Row(children: [
                Text('Backend: ', style: freeCodeDevelopLabelStyle),
                Text(_freeCodeResponse.backend,
                    style: freeCodeDevelopDescriptionStyle)
              ]),
              SizedBox(height: 10),
              Text('APK & IPA LINK', style: freeCodeDetailLabelStyle),
              Row(children: [
                Text('Android: ', style: freeCodeDevelopLabelStyle),
                Text(_freeCodeResponse.playStoreURL,
                    style: freeCodeDevelopDescriptionStyle)
              ]),
              Row(children: [
                Text('IOS: ', style: freeCodeDevelopLabelStyle),
                Text(_freeCodeResponse.ipaURL,
                    style: freeCodeDevelopDescriptionStyle)
              ]),
              SizedBox(height: 10),
              Text('LARGE DESCRIPTION', style: freeCodeDetailLabelStyle),
            ])),
        Html(data: _freeCodeResponse.longDescription, style: {
          "body": Style(
            alignment: Alignment.topRight,
            fontFamily: regularFont,
            fontSize: FontSize(15.0),
          ),
          "b": Style(
            alignment: Alignment.topRight,
            fontFamily: semiBoldFont,
            fontSize: FontSize(15.0),
          )
        })
      ]));
}
