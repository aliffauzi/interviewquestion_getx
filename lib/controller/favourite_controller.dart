import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:interviewquestion/model/interview_question/interview_question_group_by.dart';
import 'package:interviewquestion/model/interview_question/interview_question_response.dart';
import 'package:interviewquestion/shared/repository/firestore_database_repository.dart';
import 'package:interviewquestion/utils/state_status.dart';
import 'home_controller.dart';

class FavouriteController extends GetxController {
  var _homeController = Get.put(HomeController());
  var _fireStoreDatabaseRepository = Get.find<FireStoreDatabaseRepository>();
  var rxInterviewQuestionList = Rx<List<InterviewQuestionResponse>>([]);
  var stateStatus = Rx<StateStatus>(StateStatus.INITIAL);

  var bindStreamGroupBy = Rx<List<InterviewQuestionGroupBy>>([]);
  int get totalFavourite => rxInterviewQuestionList.value.length;

  @override
  void onInit() {
    super.onInit();
    _interviewQuestion(_homeController.secureStorageUserId.value);
  }

  void _interviewQuestion(String userId) {
    stateStatus.value = StateStatus.INITIAL;
    rxInterviewQuestionList.bindStream(
        _fireStoreDatabaseRepository.favouriteInterviewQuestion(userId));

    _section();
  }

  _section() {
    rxInterviewQuestionList.listen((data) {
      var groupByList = <InterviewQuestionGroupBy>[];

      groupBy(data, (InterviewQuestionResponse response) => response.language)
          .forEach((key, value) {
        groupByList.add(InterviewQuestionGroupBy(
            language: key, interviewQuestionList: value));
      });

      stateStatus.value = StateStatus.SUCCESS;
      bindStreamGroupBy.value = groupByList;
    }, onDone: () {
      stateStatus.value = StateStatus.SUCCESS;
    }, onError: (error) {
      stateStatus.value = StateStatus.SUCCESS;
    });
  }

  void isFavourite(String userId, String interviewQuestionId, int operation) {
    _fireStoreDatabaseRepository.isFavourite(
        userId, interviewQuestionId, operation);
  }

  void isReadView(String userId, String interviewQuestionId, int operation) {
    _fireStoreDatabaseRepository.isReadView(
        userId, interviewQuestionId, operation);
  }
}
