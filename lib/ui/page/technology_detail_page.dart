import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:get/get.dart';
import 'package:interviewquestion/resource/colors.dart';
import 'package:interviewquestion/resource/font.dart';
import 'package:interviewquestion/resource/images.dart';
import 'package:interviewquestion/resource/style.dart';
import 'package:interviewquestion/resource/value.dart';

class TechnologyDetailPage extends StatelessWidget {
  final _technologyResponse = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: appBarElevation,
            leading: IconButton(
                onPressed: () => Get.back(),
                icon: Icon(backIcon, size: 18, color: appBarTitleColor)),
            title: Text(_technologyResponse.name, style: appBarTitleStyle)),
        body: ListView(children: [
          Html(data: _technologyResponse.description, style: {
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
}
