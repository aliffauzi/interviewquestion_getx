import 'package:get/get.dart';
import 'package:interviewquestion/model/technology/technology_response.dart';
import 'package:interviewquestion/shared/repository/firestore_database_repository.dart';
import 'package:interviewquestion/utils/state_status.dart';

class TechnologyController extends GetxController {
  var fireStoreDatabaseRepository = Get.find<FireStoreDatabaseRepository>();
  var _technologyList = Rx<List<TechnologyResponse>>([]);
  var stateStatus = Rx<StateStatus>(StateStatus.INITIAL);

  List<TechnologyResponse> get technologyList => _technologyList.value.toList();

  @override
  void onInit() {
    super.onInit();
    stateStatus.value = StateStatus.LOADING;
    _freeCode();
  }

  void _freeCode() {
    _technologyList.bindStream(fireStoreDatabaseRepository.technology());
    _technologyList.listen((data) {
      stateStatus.value = StateStatus.SUCCESS;
    }, onDone: () {
      stateStatus.value = StateStatus.SUCCESS;
    }, onError: (error) {
      stateStatus.value = StateStatus.SUCCESS;
    });
  }
}
