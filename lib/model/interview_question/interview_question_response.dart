import 'package:cloud_firestore/cloud_firestore.dart';

class InterviewQuestionResponse {
  String id, language, question, answer, createDateTime;
  int indexSorting;
  List<dynamic> likeList;
  List<dynamic> readViewList;

  InterviewQuestionResponse({this.id, this.indexSorting, this.language, this.question, this.answer, this.likeList, this.readViewList, this.createDateTime});

  InterviewQuestionResponse.fromDocumentSnapshot(
      QueryDocumentSnapshot queryDocumentSnapshot) {
    id = queryDocumentSnapshot.id;
    indexSorting = queryDocumentSnapshot["indexsorting"];
    language = queryDocumentSnapshot["language"];
    question = queryDocumentSnapshot["question"];
    answer = queryDocumentSnapshot["answer"];
    createDateTime = queryDocumentSnapshot["createdatetime"];
    likeList = queryDocumentSnapshot["likelist"] as List;
    readViewList = queryDocumentSnapshot["readview"] as List;
  }
}
