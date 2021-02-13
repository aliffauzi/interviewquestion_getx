import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:interviewquestion/model/index/index_response.dart';
import 'package:interviewquestion/model/subject/subject_response.dart';
import 'package:interviewquestion/model/subject/subject_topic_group_by.dart';
import 'package:interviewquestion/shared/repository/firestore_database_repository.dart';
import 'package:interviewquestion/utils/state_status.dart';

class SubjectController extends GetxController {
  var _fireStoreDatabaseRepository = Get.find<FireStoreDatabaseRepository>();
  var stateStatus = Rx<StateStatus>(StateStatus.INITIAL);

  var _rxSubjectListList = Rx<List<SubjectResponse>>([]);
  var rxIndexList = Rx<List<IndexResponse>>([]);
  var bindStreamGroupBy = Rx<List<SubjectTopicGroupBy>>([]);

  List<IndexResponse> get indexList => rxIndexList.value.toList();

  @override
  void onInit() {
    super.onInit();
    stateStatus.value = StateStatus.LOADING;
    _rxSubjectListList.bindStream(_fireStoreDatabaseRepository.subject());
    _section();
  }

  void index(String id) {
    rxIndexList.value.clear();
    rxIndexList.bindStream(_fireStoreDatabaseRepository.index(id));
  }

  _section() {
    _rxSubjectListList.listen((data) {
      var groupByList = <SubjectTopicGroupBy>[];
      groupBy(data, (SubjectResponse student) => student.topic)
          .forEach((key, value) {
        groupByList.add(SubjectTopicGroupBy(topic: key, subjectList: value));
      });
      stateStatus.value = StateStatus.SUCCESS;
      bindStreamGroupBy.value = groupByList;
    }, onDone: () {
      stateStatus.value = StateStatus.SUCCESS;
    }, onError: (error) {
      stateStatus.value = StateStatus.SUCCESS;
    });
  }
}
