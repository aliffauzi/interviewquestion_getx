import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interviewquestion/controller/controller.dart';
import 'package:interviewquestion/resource/style.dart';
import 'package:interviewquestion/resource/value.dart';

class OnBoardingPage extends GetView<OnBoardingController> {
  Widget build(BuildContext context) => Scaffold(
          body: Stack(children: [
        PageView.builder(
            onPageChanged: controller.selectedPage,
            controller: controller.pageController,
            itemCount: controller.onBoardingResponseList.length,
            itemBuilder: (context, index) {
              return Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Image.asset(
                        controller.onBoardingResponseList[index].imageAssets),
                    SizedBox(height: 32),
                    Text(controller.onBoardingResponseList[index].title,
                        style: onBoardingTitleStyle),
                    SizedBox(height: 20),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 64.0),
                        child: Text(
                            controller
                                .onBoardingResponseList[index].description,
                            textAlign: TextAlign.center,
                            style: onBoardingMessageStyle))
                  ]));
            }),
        Positioned(
            left: 15,
            bottom: 20,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                    controller.onBoardingResponseList.length,
                    (index) => Obx(() => Container(
                        margin: const EdgeInsets.all(3.0),
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                            color: controller.selectedPage.value == index
                                ? Colors.red
                                : Colors.grey,
                            shape: BoxShape.circle)))))),
        Positioned(
            right: 0,
            bottom: 5,
            child: TextButton(
                child: Obx(() => Text(
                    controller.isLastPage ? ' $labelStart ' : ' $labelNext ',
                    style: btnOnBoardingStyle)),
                onPressed: () => controller.forwardAction()))
      ]));
}
