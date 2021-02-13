import 'package:interviewquestion/controller/controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => SubjectController());
    Get.lazyPut(() => ProfileEditController());
    Get.lazyPut(() => TechnologyController());
  }
}
