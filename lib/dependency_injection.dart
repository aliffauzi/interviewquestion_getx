import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'shared/provider/firestore_provider.dart';
import 'shared/provider/local_auth_provider.dart';
import 'shared/repository/firestore_database_repository.dart';
import 'shared/repository/local_auth_repository.dart';

class DependencyInjection {
  static void init() {
    Get.lazyPut<FirebaseFirestore>(() => FirebaseFirestore.instance,
        fenix: true);
    Get.lazyPut<FirebaseAuth>(() => FirebaseAuth.instance, fenix: true);
    Get.lazyPut<GetStorage>(() => GetStorage(), fenix: true);

    //SECURE STORAGE
    Get.lazyPut<LocalAuthProvider>(() => LocalAuthProvider(Get.find()),
        fenix: true);
    Get.lazyPut<LocalAuthRepository>(() => LocalAuthRepository(), fenix: true);

    //FIRESTORE
    Get.lazyPut<FireStoreDatabaseProvider>(
        () => FireStoreDatabaseProvider(Get.find(), Get.find()),
        fenix: true);
    Get.lazyPut<FireStoreDatabaseRepository>(
        () => FireStoreDatabaseRepository(),
        fenix: true);
  }
}
