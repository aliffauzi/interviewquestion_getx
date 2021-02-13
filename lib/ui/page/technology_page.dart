import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interviewquestion/controller/controller.dart';
import 'package:interviewquestion/resource/routes.dart';
import 'package:interviewquestion/resource/style.dart';
import 'package:interviewquestion/resource/value.dart';
import 'package:interviewquestion/utils/extensions.dart';

class TechnologyPage extends GetView<TechnologyController> {
  @override
  Widget build(_) {
    return Obx(() => listView(
        stateStatus: controller.stateStatus.value,
        dataNotFoundMessage: dataNotTechnology,
        length: controller.technologyList.length,
        itemBuilder: (context, index) {
          var _controller = controller.technologyList[index];
          return GestureDetector(
              onTap: () =>
                  Get.toNamed(technologyDetailRoute, arguments: _controller),
              child: Card(
                  elevation: 0.3,
                  child: Container(
                      padding: EdgeInsets.all(5),
                      color: Colors.grey.withOpacity(0.1),
                      height: 130,
                      child: Stack(children: [
                        Column(children: [
                          Text(_controller.title.toUpperCase(),
                              style: technologyTitleStyle),
                          Text(_controller.name, style: technologyNameStyle)
                        ]),
                        Positioned(
                            right: 0,
                            bottom: 0,
                            child: Text(_controller.createDateTime,
                                style: technologyCreateDateTimeStyle))
                      ]))));
        }));
  }
}
