import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:get/get.dart';
import 'package:interviewquestion/controller/controller.dart';
import 'package:interviewquestion/resource/api.dart';
import 'package:interviewquestion/resource/font.dart';
import 'package:interviewquestion/resource/images.dart';
import 'package:interviewquestion/resource/style.dart';
import 'package:interviewquestion/resource/value.dart';
import 'package:interviewquestion/utils/extensions.dart';

class FavouriteQuestionPage extends GetView<FavouriteController> {
  final _homeController = Get.put(HomeController());

  @override
  Widget build(_) {
    return Obx(() => listView(
        stateStatus: controller.stateStatus.value,
        dataNotFoundMessage: dataNotFavourite,
        length: controller.bindStreamGroupBy.value.length,
        itemBuilder: (context, index) {
          var _controller = controller.bindStreamGroupBy.value[index];
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: Row(mainAxisSize: MainAxisSize.max, children: [
                      Expanded(
                          child: Text(
                              '${_controller.language}  (${_controller.interviewQuestionList.length})',
                              textAlign: TextAlign.center,
                              style: groupByParentLanguageStyle))
                    ])),
                Column(
                    children: _controller.interviewQuestionList
                        .asMap()
                        .map((index, item) => MapEntry(
                            index,
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Theme(
                                      data: Theme.of(context).copyWith(
                                          dividerColor: Colors.transparent),
                                      child: ExpansionTile(
                                          trailing: GestureDetector(
                                              onTap: () => controller.isFavourite(
                                                  _homeController
                                                      .secureStorageUserId
                                                      .value,
                                                  item.id,
                                                  item.likeList
                                                          .toString()
                                                          .contains(_homeController
                                                              .secureStorageUserId
                                                              .value)
                                                      ? delete
                                                      : insert),
                                              child: CircleAvatar(
                                                  radius: 14,
                                                  backgroundColor: Colors.grey
                                                      .withOpacity(0.1),
                                                  child:
                                                      Icon(item.likeList.toString().contains(_homeController.secureStorageUserId.value) ? heart : heartO, size: 18))),
                                          tilePadding: EdgeInsets.all(5),
                                          onExpansionChanged: (value) {
                                            if (value) {
                                              controller.isReadView(
                                                  _homeController
                                                      .secureStorageUserId
                                                      .value,
                                                  item.id,
                                                  insert);
                                            }
                                          },
                                          childrenPadding: EdgeInsets.all(0),
                                          title: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                            Text('(${index + 1})  ',
                                                style: questionIndexStyle),
                                            Expanded(
                                                child: Text(item.question,
                                                    style: questionStyle))
                                          ]),
                                          children: [
                                            Html(data: item.answer, style: {
                                              "body": Style(
                                                alignment: Alignment.topRight,
                                                fontFamily: regularFont,
                                                fontSize: FontSize(15.0),
                                              ),
                                              "b": Style(
                                                  alignment: Alignment.topRight,
                                                  fontFamily: semiBoldFont,
                                                  fontSize: FontSize(15.0))
                                            })
                                          ])),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 5, right: 5),
                                            child: Text(
                                                '${item.readViewList.length} Views',
                                                style:
                                                    questionCreateDateTimeStyle))
                                      ]),
                                  Divider(color: Colors.black, thickness: 0.2)
                                ])))
                        .values
                        .toList())
              ]);
        }));
  }
}
