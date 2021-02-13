import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interviewquestion/controller/controller.dart';
import 'package:interviewquestion/resource/colors.dart';
import 'package:interviewquestion/resource/routes.dart';
import 'package:interviewquestion/resource/style.dart';
import 'package:interviewquestion/resource/value.dart';
import 'package:interviewquestion/utils/extensions.dart';

class SubjectPage extends GetView<SubjectController> {
  final _homeController = Get.put(HomeController());

  @override
  Widget build(_) {
    return Obx(() => listView(
        stateStatus: controller.stateStatus.value,
        dataNotFoundMessage: dataNotMessage,
        length: controller.bindStreamGroupBy.value.length,
        itemBuilder: (_, index) {
          var _controller = controller.bindStreamGroupBy.value[index];
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.only(top: 30, bottom: 30),
                    color: colorGroupByParent,
                    child: Row(mainAxisSize: MainAxisSize.max, children: [
                      Expanded(
                          child: Text(
                              '${_controller.topic}  (${_controller.subjectList.length})',
                              textAlign: TextAlign.center,
                              style: groupByParentNameStyle))
                    ])),
                SizedBox(height: 10),
                Column(
                    children: _controller.subjectList
                        .map((item) => Column(children: [
                              InkWell(
                                  onTap: () {
                                    controller.index(item.id);
                                    Get.bottomSheet(
                                      Obx(() => Container(
                                          margin: EdgeInsets.only(
                                              top: 5, bottom: 5),
                                          child: ListView(
                                              children: controller.indexList
                                                  .map((value) => InkWell(
                                                      onTap: () {
                                                        _homeController
                                                            .indexId = value.id;
                                                        Get.back();
                                                        Get.toNamed(
                                                            interviewQuestionRoute,
                                                            arguments:
                                                                item.language);
                                                      },
                                                      child: Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  12),
                                                          child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(value.name,
                                                                    style:
                                                                        indexNameStyle),
                                                                Text(
                                                                    '(${value.totalQuestion})',
                                                                    style:
                                                                        groupByChildIndexCountStyle)
                                                              ]))))
                                                  .toList()))),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              topLeft: Radius.circular(10))),
                                      elevation: 0,
                                      isScrollControlled: false,
                                      backgroundColor: Colors.white,
                                    );
                                  },
                                  child: Container(
                                      padding: EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 8,
                                          bottom: 8),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(item.language,
                                                style: groupByChildNameStyle),
                                            Text('(${item.languageIndex})',
                                                style:
                                                    groupByChildIndexCountStyle)
                                          ]))),
                              Divider(color: Colors.grey.withOpacity(0.2))
                            ]))
                        .toList()),
              ]);
        }));
  }
}
