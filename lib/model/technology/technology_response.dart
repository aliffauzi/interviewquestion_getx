import 'package:cloud_firestore/cloud_firestore.dart';

class TechnologyResponse {
  String id, title, name, imageURL, description, createDateTime;

  TechnologyResponse({this.id, this.title, this.name, this.imageURL, this.createDateTime});

  TechnologyResponse.fromDocumentSnapshot(QueryDocumentSnapshot queryDocumentSnapshot) {
    id = queryDocumentSnapshot.id;
    title = queryDocumentSnapshot["title"];
    name = queryDocumentSnapshot["name"];
    imageURL = queryDocumentSnapshot["imageurl"];
    description = queryDocumentSnapshot["description"];
    createDateTime = queryDocumentSnapshot["createdatetime"];
  }
}
