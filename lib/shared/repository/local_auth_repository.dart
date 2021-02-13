import 'package:get/get.dart';
import 'package:interviewquestion/shared/provider/local_auth_provider.dart';

class LocalAuthRepository {
  final LocalAuthProvider _localAuthProvider = Get.find<LocalAuthProvider>();

  Future<void> clearSession() => _localAuthProvider.clearSession();

  String getSession(String key) => _localAuthProvider.getSession(key);

  void setSession(String key, String value) => _localAuthProvider.setSession(key, value);
}
