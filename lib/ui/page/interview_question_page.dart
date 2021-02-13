import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:get/get.dart';
import 'package:interviewquestion/controller/controller.dart';
import 'package:interviewquestion/resource/api.dart';
import 'package:interviewquestion/resource/colors.dart';
import 'package:interviewquestion/resource/font.dart';
import 'package:interviewquestion/resource/images.dart';
import 'package:interviewquestion/resource/style.dart';
import 'package:interviewquestion/resource/value.dart';
import 'package:interviewquestion/utils/extensions.dart';

class InterviewQuestionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: appBarElevation,
            leading: IconButton(
                onPressed: () => Get.back(),
                icon: Icon(backIcon, size: 18, color: appBarTitleColor)),
            title: Text(Get.arguments, style: appBarTitleStyle)),
        body: Obx(() => listView(
            stateStatus: InterviewQuestionController.to.stateStatus.value,
            dataNotFoundMessage: dataNotInterviewQuestion,
            length:
                InterviewQuestionController.to.rxInterviewQuestionList.length,
            itemBuilder: (context, index) {
              var _controller =
                  InterviewQuestionController.to.rxInterviewQuestionList[index];
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Theme(
                        data: Theme.of(context)
                            .copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                            trailing: GestureDetector(
                                onTap: () => InterviewQuestionController.to.isFavourite(
                                    HomeController.to.secureStorageUserId.value,
                                    _controller.id,
                                    _controller.likeList.toString().contains(HomeController.to.secureStorageUserId.value)
                                        ? delete
                                        : insert),
                                child: CircleAvatar(
                                    radius: 14,
                                    backgroundColor:
                                        Colors.grey.withOpacity(0.1),
                                    child: Icon(
                                        _controller.likeList.toString().contains(
                                                HomeController.to.secureStorageUserId.value)
                                            ? heart
                                            : heartO,
                                        size: 18))),
                            tilePadding: EdgeInsets.all(5),
                            onExpansionChanged: (value) {
                              if (value) {
                                InterviewQuestionController.to.isReadView(
                                    HomeController.to.secureStorageUserId.value,
                                    _controller.id,
                                    insert);
                              }
                            },
                            childrenPadding: EdgeInsets.all(0),
                            title: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text('(${index + 1})  ',
                                  style: questionIndexStyle),
                              Expanded(
                                  child: Text(_controller.question,
                                      style: questionStyle))
                            ]),
                            children: [
                              Row(children: [
                                Html(data: _controller.answer, style: {
                                  "body": Style(
                                      alignment: Alignment.topRight,
                                      fontFamily: regularFont,
                                      fontSize: FontSize(15.0)),
                                  "b": Style(
                                      alignment: Alignment.topRight,
                                      fontFamily: semiBoldFont,
                                      fontSize: FontSize(15.0))
                                })
                              ])
                            ])),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      Container(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          child: Text(
                              '${_controller.readViewList.length} Views',
                              style: questionCreateDateTimeStyle))
                    ]),
                    Divider(color: Colors.black, thickness: 0.2)
                  ]);
            })));
  }
}
