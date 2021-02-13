import 'package:cloud_firestore/cloud_firestore.dart';

class FreeCodeResponse {
  String id, name, platform, sourceCodeURL, backend, shortDescription, longDescription, completeCode, createDateTime, frontend, playStoreURL, ipaURL;
  int isFreePaid;
  List<dynamic> screenShotList;

  FreeCodeResponse({this.id, this.name, this.platform, this.sourceCodeURL, this.backend, this.shortDescription, this.longDescription, this.completeCode, this.createDateTime, this.frontend, this.playStoreURL, this.ipaURL, this.screenShotList});

  FreeCodeResponse.fromDocumentSnapshot(QueryDocumentSnapshot queryDocumentSnapshot) {
    id = queryDocumentSnapshot.id;
    name = queryDocumentSnapshot["name"];
    platform = queryDocumentSnapshot["platform"];
    sourceCodeURL = queryDocumentSnapshot["sourcecodeurl"];
    backend = queryDocumentSnapshot["backend"];
    shortDescription = queryDocumentSnapshot["shortdescription"];
    longDescription = queryDocumentSnapshot["longdescription"];
    completeCode = queryDocumentSnapshot["completecode"];
    createDateTime = queryDocumentSnapshot["createdatetime"];
    frontend = queryDocumentSnapshot["frontend"];
    isFreePaid = queryDocumentSnapshot["isfreepaid"];
    screenShotList = queryDocumentSnapshot["screenshotlist"] as List;
    playStoreURL = queryDocumentSnapshot["playstoreurl"];
    ipaURL = queryDocumentSnapshot["ipaurl"];
  }
}
