import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interviewquestion/controller/controller.dart';
import 'package:interviewquestion/resource/colors.dart';
import 'package:interviewquestion/resource/images.dart';
import 'package:interviewquestion/resource/value.dart';

class ScreenShotPage extends GetView<ScreenShotController> {
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
          elevation: appBarElevation,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(backIcon, size: 18, color: appBarTitleColor))),
      body: Stack(children: [
        PageView.builder(
            onPageChanged: controller.selectedPage,
            controller: controller.pageController,
            itemCount: controller.screenshotList.length,
            itemBuilder: (context, index) {
              return Container(
                  child: CachedNetworkImage(
                      fit: BoxFit.contain,
                      imageUrl: controller.screenshotList[index],
                      placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(strokeWidth: 1))));
            })
      ]));
}
