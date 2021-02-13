import 'package:get/get.dart';
import 'package:interviewquestion/model/freecode/free_code_response.dart';
import 'package:interviewquestion/shared/repository/firestore_database_repository.dart';
import 'package:interviewquestion/utils/state_status.dart';

class FreeCodeController extends GetxController {
  var _fireStoreDatabaseRepository = Get.find<FireStoreDatabaseRepository>();
  var _rxFreeCodeList = Rx<List<FreeCodeResponse>>([]);
  var stateStatus = Rx<StateStatus>(StateStatus.INITIAL);

  List<FreeCodeResponse> get freeCodeList => _rxFreeCodeList.value.toList();

  @override
  void onInit() {
    super.onInit();
    stateStatus.value = StateStatus.LOADING;
    _freeCode();
  }

  void _freeCode() {
    _rxFreeCodeList.bindStream(_fireStoreDatabaseRepository.freeCode());

    _rxFreeCodeList.listen((data) {
      stateStatus.value = StateStatus.SUCCESS;
    }, onDone: () {
      stateStatus.value = StateStatus.SUCCESS;
    }, onError: (error) {
      stateStatus.value = StateStatus.SUCCESS;
    });
  }
}
