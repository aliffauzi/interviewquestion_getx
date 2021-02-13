import 'package:interviewquestion/controller/controller.dart';
import 'package:get/get.dart';

class ScreenShotBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ScreenShotController());
  }
}
