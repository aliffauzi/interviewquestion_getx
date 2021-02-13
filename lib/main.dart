import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app_module.dart';
import 'dependency_injection.dart';
import 'resource/colors.dart';
import 'resource/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white));
  
  await getApplicationDocumentsDirectory();
  //String appDocPath = appDocDir.path;

  await GetStorage.init();
  DependencyInjection.init();
  Firebase.initializeApp();

  //await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  //FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        enableLog: true,
        theme: ThemeData(
          /*colorScheme: ColorScheme.light(
                primary: const Color(0xff263c7a),
                secondary: const Color(0xfffca311),
                onSecondary: Colors.black,
                onPrimary: Colors.white,
                primaryVariant: const Color(0xff00174d),
                secondaryVariant: const Color(0xffc37400)),*/
            scaffoldBackgroundColor: backgroundColor,
            brightness: Brightness.light,
            accentColor: accentColor,
            primaryColor: primaryColor,
            primarySwatch: primarySwatchColor),
        initialRoute: firstLaunchRoute,
        getPages: AppPages.pages);
  }
}
