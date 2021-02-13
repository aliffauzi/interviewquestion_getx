import 'package:cloud_firestore/cloud_firestore.dart';

class SubjectResponse{
  String id, topic, language, imageUrl, createDateTime;
  int languageIndex, adminApprove;

  SubjectResponse({
    this.id,
    this.topic,
    this.language,
    this.imageUrl,
    this.languageIndex,
    this.adminApprove,
    this.createDateTime
  });

  SubjectResponse.fromDocumentSnapshot(QueryDocumentSnapshot documentChange) {
    id = documentChange.id;
    topic = documentChange["topic"];
    language = documentChange["language"];
    imageUrl = documentChange["imageurl"];
    languageIndex = documentChange["languageindex"];
    adminApprove = documentChange["adminapprove"];
    createDateTime = documentChange["createdatetime"];
  }
}