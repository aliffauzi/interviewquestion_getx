import 'package:cloud_firestore/cloud_firestore.dart';

class IndexResponse {
  String id, uniqueId, name, createDateTime;
  int indexSorting, totalQuestion;

  IndexResponse(
      {this.id, this.uniqueId, this.name, this.indexSorting, this.totalQuestion, this.createDateTime});

  IndexResponse.fromDocumentSnapshot(QueryDocumentSnapshot queryDocumentSnapshot) {
    id = queryDocumentSnapshot.id;
    uniqueId = queryDocumentSnapshot["uniqueid"];
    name = queryDocumentSnapshot["name"];
    indexSorting = queryDocumentSnapshot["indexsorting"];
    totalQuestion = queryDocumentSnapshot["totalquestion"];
    createDateTime = queryDocumentSnapshot["createdatetime"];
  }
}
