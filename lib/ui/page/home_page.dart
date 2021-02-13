import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interviewquestion/controller/controller.dart';
import 'package:interviewquestion/resource/colors.dart';
import 'package:interviewquestion/resource/images.dart';
import 'package:interviewquestion/resource/routes.dart';
import 'package:interviewquestion/resource/style.dart';
import 'package:interviewquestion/resource/value.dart';
import 'package:interviewquestion/ui/widget/bottom_sheet_custom.dart';
import 'package:interviewquestion/ui/widget/drawer_menu.dart';

class HomePage extends StatefulWidget {
  @override
  createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  final _favouriteController = Get.put(FavouriteController());

  @override
  void initState() {
    super.initState();
    //TODO DIALOG OPEN THE INIT-STATE
    /*WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
        context: Get.context,
        barrierDismissible: false,
        builder: (_) => DialogExit(callBackCancel: () {}, callBackOk: () {})));*/
  }

  @override
  Widget build(BuildContext context) => _renderBody(context);

  _renderBody(BuildContext context) => Obx(() => Scaffold(
      appBar: AppBar(
          elevation: appBarElevation,
          leading: IconButton(
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                bottomSheetCustom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10))),
                    isScrollControlled: true,
                    isDismissible: true,
                    backgroundColor: backgroundColor,
                    context: context,
                    builder: (context) => DrawerMenu(
                        userName: HomeController.to.secureStorageUserName.value,
                        email: HomeController.to.secureStorageEmail.value,
                        profileURL:
                        HomeController.to.secureStorageProfileURL.value,
                        whereLogin:
                        HomeController.to.secureStorageWhereLogin.value,
                        drawerCallBack: (String value) {
                          Get.back();
                          switch (value) {
                            case titleContactUs:
                              Get.toNamed(contactUsRoute);
                              break;

                            case titleFreeCode:
                              Get.toNamed(freeCodeRoute);
                              break;

                            case titleChangePassword:
                              Get.toNamed(changePasswordRoute);
                              break;

                            case titleLogout:
                              HomeController.to.callLogout();
                              break;
                          }
                        }));
              },
              icon: Icon(navigationIcon, size: 18, color: appBarTitleColor)),
          title: Text(appName, style: appBarTitleStyle)),
      body: PageView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            HomeController.to.redirectPage(),
            HomeController.to.redirectPage(),
            HomeController.to.redirectPage(),
            HomeController.to.redirectPage()
          ],
          controller: HomeController.to.pageController),
      bottomNavigationBar: _bottomNavigationBar()));

  _bottomNavigationBar() => BottomNavigationBar(
          elevation: 4,
          backgroundColor: tabBackgroundColor,
          fixedColor: tabSelectColor,
          unselectedItemColor: tabUnSelectColor,
          type: BottomNavigationBarType.fixed,
          onTap: HomeController.to.onTabChange,
          selectedLabelStyle: tabSelectStyle,
          unselectedLabelStyle: tabUnSelectStyle,
          currentIndex: HomeController.to.currentPageIndex.value,
          items: [
            BottomNavigationBarItem(
                icon: _notification(
                    iconData: tabHomeIcon,
                    notificationIconShow: false),
                label: bottomMenuHome),
            BottomNavigationBarItem(
                icon: _notification(
                    iconData: tabFavouriteIcon,
                    notificationIconShow: true,
                    notificationCounter: _favouriteController.totalFavourite.toString(),
                    selectIndex: HomeController.to.currentPageIndex.value ==
                        favouriteIndex),
                label: bottomMenuFavourite),
            BottomNavigationBarItem(
                icon: _notification(
                    iconData: tabTechnologyIcon,
                    notificationIconShow: false),
                label: bottomMenuTechnology),
            BottomNavigationBarItem(
                icon: _notification(
                    iconData: tabProfileIcon, notificationIconShow: false),
                label: bottomMenuProfile)
          ]);

  _notification(
          {@required IconData iconData,
          String notificationCounter,
          bool notificationIconShow = false,
          bool selectIndex = false}) =>
      Stack(children: <Widget>[
        Container(
            width: 30,
            height: 25,
            padding: const EdgeInsets.only(right: 0.0, top: 4),
            child: Icon(iconData)),
        if (notificationIconShow)
          Positioned(
              right: 0,
              top: 0,
              child: Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                      color: selectIndex
                          ? countSelectBackgroundColor
                          : countBackgroundColor,
                      borderRadius: BorderRadius.circular(8)),
                  constraints:
                      const BoxConstraints(minWidth: 16, minHeight: 16),
                  child: Center(child: Text(notificationCounter,
                      style: countStyle))))
      ]);
}
