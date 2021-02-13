import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interviewquestion/controller/controller.dart';
import 'package:interviewquestion/resource/colors.dart';
import 'package:interviewquestion/resource/images.dart';
import 'package:interviewquestion/resource/routes.dart';
import 'package:interviewquestion/resource/style.dart';
import 'package:interviewquestion/resource/value.dart';
import 'package:interviewquestion/utils/extensions.dart';

class FreeCodePage extends GetView<FreeCodeController> {
  @override
  Widget build(_) {
    return Scaffold(
        appBar: AppBar(
            elevation: appBarElevation,
            leading: IconButton(
                onPressed: () => Get.back(),
                icon: Icon(backIcon, size: 18, color: appBarTitleColor)),
            title: Text(titleFreeCode, style: appBarTitleStyle)),
        body: Obx(() => listView(
            stateStatus: controller.stateStatus.value,
            dataNotFoundMessage: dataNotMessage,
            length: controller.freeCodeList.length,
            itemBuilder: (context, index) {
              var _controller = controller.freeCodeList[index];
              return GestureDetector(
                  onTap: () =>
                      Get.toNamed(freeCodeDetailRoute, arguments: _controller),
                  child: Card(
                      child: ListTile(
                          contentPadding:
                              EdgeInsets.only(left: 5, right: 5, top: 5),
                          leading: CircleAvatar(
                              backgroundColor: appBarTitleColor,
                              child: Text(_controller.name[0],
                                  style: freeCodeFirstLetterNameStyle)),
                          title:
                              Text(_controller.name, style: freeCodeNameStyle),
                          subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_controller.platform,
                                    style: freeCodePlatformStyle),
                                Text(_controller.shortDescription,
                                    style: freeCodeShortDescriptionStyle),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                          onTap: () => Get.toNamed(screenshotRoute, arguments: _controller.screenShotList),
                                          child: Container(
                                              padding: EdgeInsets.only(
                                                  top: 5, bottom: 5),
                                              child: Text(
                                                  'Screen shot ${_controller.screenShotList.length}',
                                                  style:
                                                      freeCodeScreenShotStyle))),
                                      Text(_controller.createDateTime,
                                          style: freeCodeCreateDateStyle)
                                    ])
                              ]))));
            })));
  }
}
