import 'package:interviewquestion/controller/controller.dart';
import 'package:get/get.dart';

class InterviewQuestionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InterviewQuestionController());
  }
}
