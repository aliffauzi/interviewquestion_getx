import 'package:cloud_firestore/cloud_firestore.dart';

class LoginResponse {
  String id, socialId, name, email, password, mobile, address, profilePicture, whereLogin;
  int adminApprove;

  LoginResponse(
      {this.id,
      this.socialId,
      this.name,
      this.email,
      this.mobile,
      this.address,
      this.profilePicture,
      this.whereLogin,
      this.adminApprove});

  LoginResponse.fromDocumentSnapshot(
      QueryDocumentSnapshot queryDocumentSnapshot) {
    id = queryDocumentSnapshot.id;
    password  = queryDocumentSnapshot["password"] == null ? '' : queryDocumentSnapshot["password"];
    socialId = queryDocumentSnapshot["socialid"] == null ? '' : queryDocumentSnapshot["socialid"];
    name = queryDocumentSnapshot["name"] == null ? '' : queryDocumentSnapshot["name"];
    email = queryDocumentSnapshot["email"] == null ? '' : queryDocumentSnapshot["email"];
    address = queryDocumentSnapshot["address"] == null ? '' : queryDocumentSnapshot["address"];
    profilePicture = queryDocumentSnapshot["profilepicture"] == null ? '' : queryDocumentSnapshot["profilepicture"];
    whereLogin = queryDocumentSnapshot["wherelogin"] == null ? '' : queryDocumentSnapshot["wherelogin"];
    mobile = queryDocumentSnapshot["mobile"] == null ? '' : queryDocumentSnapshot["mobile"];
    adminApprove = queryDocumentSnapshot["adminapprove"] == null ? 0 : queryDocumentSnapshot["adminapprove"];
  }
}
