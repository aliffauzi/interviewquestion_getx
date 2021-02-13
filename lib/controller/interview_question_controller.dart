import 'package:get/get.dart';
import 'package:interviewquestion/model/interview_question/interview_question_response.dart';
import 'package:interviewquestion/shared/repository/firestore_database_repository.dart';
import 'package:interviewquestion/utils/state_status.dart';
import 'home_controller.dart';

class InterviewQuestionController extends GetxController {
  static InterviewQuestionController get to => Get.find();
  var fireStoreDatabaseRepository = Get.find<FireStoreDatabaseRepository>();
  var rxInterviewQuestionList = RxList<InterviewQuestionResponse>([]);
  var stateStatus = Rx<StateStatus>(StateStatus.INITIAL);


  @override
  void onInit() {
    super.onInit();
    interviewQuestion(HomeController.to.indexId);
  }

  void interviewQuestion(String indexId) {
    stateStatus.value = StateStatus.LOADING;

    rxInterviewQuestionList.bindStream(fireStoreDatabaseRepository.interviewQuestion(indexId));
    List<InterviewQuestionResponse> sortingList = rxInterviewQuestionList.toList();
    sortingList.sort((a, b) => a.indexSorting.compareTo(b.indexSorting));
    rxInterviewQuestionList.assignAll(sortingList);

    stateStatus.value = StateStatus.SUCCESS;
  }

  void isFavourite(String userId, String interviewQuestionId, int operation) {
    fireStoreDatabaseRepository.isFavourite(
        userId, interviewQuestionId, operation);
  }

  void isReadView(String userId, String interviewQuestionId, int operation) {
    fireStoreDatabaseRepository.isReadView(
        userId, interviewQuestionId, operation);
  }
}
