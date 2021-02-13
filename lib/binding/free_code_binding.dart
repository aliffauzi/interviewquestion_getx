import 'package:get/get.dart';
import 'package:interviewquestion/controller/controller.dart';

class FreeCodeBinging extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FreeCodeController());
  }
}