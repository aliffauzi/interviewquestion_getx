import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:interviewquestion/model/freecode/free_code_response.dart';
import 'package:interviewquestion/model/index/index_response.dart';
import 'package:interviewquestion/model/interview_question/interview_question_response.dart';
import 'package:interviewquestion/model/subject/subject_response.dart';
import 'package:interviewquestion/model/technology/technology_response.dart';
import 'package:interviewquestion/resource/api.dart';

class FireStoreDatabaseProvider {
  FirebaseFirestore _firebaseFireStore;
  FirebaseAuth _firebaseAuth;

  var _googleSignIn = GoogleSignIn();

  FireStoreDatabaseProvider(
      this._firebaseFireStore, this._firebaseAuth);


  Future<String> signUp(Map<String, dynamic> param) async {
    var documentReference =
        await _firebaseFireStore.collection(tableNameSignUp).add(param);

    return documentReference.id;
  }

  Future<int> checkEmail(String email) async {
    var querySnapshot = await _firebaseFireStore
        .collection(tableNameSignUp)
        .where('email', isEqualTo: email)
        .get();
    return querySnapshot.size;
  }

  Future<QuerySnapshot> login(String email, String password) async {
    return await _firebaseFireStore
        .collection(tableNameSignUp)
        .where('email', isEqualTo: email)
        .where('password', isEqualTo: password)
        .limit(1)
        .get();
  }

  Future<QuerySnapshot> forgotPassword(String email) async {
    var querySnapshot = await _firebaseFireStore
        .collection(tableNameSignUp)
        .where('email', isEqualTo: email)
        .limit(1)
        .get();
    return querySnapshot;
  }

  Future<User> googleLogin() async {
    var googleSignInAccount = await _googleSignIn.signIn();
    if (googleSignInAccount != null) {
      var googleSignInAuthentication = await googleSignInAccount.authentication;

      var credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      var authResult = await _firebaseAuth.signInWithCredential(credential);
      var user = authResult.user;

      if (user != null)
        return _firebaseAuth.currentUser;
      else
        return null;
    }
    return null;
  }

  Future<void> googleLogout() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }

  Stream<List<SubjectResponse>> subject() => _firebaseFireStore
      .collection(tableNameSubject)
      .where('adminapprove', isEqualTo: 1)
      .snapshots()
      .map((docs) => docs.docs
          .map<SubjectResponse>(
              (response) => SubjectResponse.fromDocumentSnapshot(response))
          .toList());

  Stream<List<IndexResponse>> index(String id) => _firebaseFireStore
      .collection(tableNameIndex)
      .where('uniqueid', isEqualTo: id)
      .where('adminapprove', isEqualTo: 1)
      .snapshots()
      .map((docs) => docs.docs
          .map<IndexResponse>(
              (response) => IndexResponse.fromDocumentSnapshot(response))
          .toList()..sort((a, b) => a.indexSorting.compareTo(b.indexSorting)));

  Stream<List<InterviewQuestionResponse>> interviewQuestion(String indexId) =>
      _firebaseFireStore
          .collection(tableNameInterviewQuestion)
          .where('indexid', isEqualTo: indexId)
          .where('adminapprove', isEqualTo: 1)
          .snapshots()
          .map((docs) => docs.docs
              .map<InterviewQuestionResponse>((response) =>
                  InterviewQuestionResponse.fromDocumentSnapshot(response))
              .toList());

  Stream<List<InterviewQuestionResponse>> favouriteInterviewQuestion(
          String userId) =>
      _firebaseFireStore
          .collection(tableNameInterviewQuestion)
          .where('adminapprove', isEqualTo: 1)
          .snapshots()
          .map((docs) => docs.docs
              .map<InterviewQuestionResponse>((response) =>
                  InterviewQuestionResponse.fromDocumentSnapshot(response))
              .where((element) => element.likeList.contains(userId))
              .toList());

  void isFavourite(String userId, String interviewQuestionId, int operation) {
    var documentReference = _firebaseFireStore
        .collection(tableNameInterviewQuestion)
        .doc(interviewQuestionId);
    if (operation == insert)
      documentReference.update({
        'likelist': FieldValue.arrayUnion([userId])
      });
    else if (operation == delete) {
      documentReference.update({
        'likelist': FieldValue.arrayRemove([userId])
      });
    }
  }

  void isReadView(String userId, String interviewQuestionId, int operation) {
    var documentReference = _firebaseFireStore
        .collection(tableNameInterviewQuestion)
        .doc(interviewQuestionId);
    if (operation == insert)
      documentReference.update({
        'readview': FieldValue.arrayUnion([userId])
      });
  }

  Stream<List<FreeCodeResponse>> freeCode() {
    return _firebaseFireStore
        .collection(tableNameFreeCode)
        .where('adminapprove', isEqualTo: 1)
        .snapshots()
        .map((docs) => docs.docs
            .map<FreeCodeResponse>(
                (response) => FreeCodeResponse.fromDocumentSnapshot(response))
            .toList());
  }

  Stream<List<TechnologyResponse>> technology() {
    return _firebaseFireStore
        .collection(tableNameTechnology)
        .where('adminapprove', isEqualTo: 1)
        .snapshots()
        .map((docs) => docs.docs
        .map<TechnologyResponse>(
            (response) => TechnologyResponse.fromDocumentSnapshot(response))
        .toList());
  }

  void profileEdit(
      String userId, String name, String email, String mobile, String address) {
    var documentReference =
        _firebaseFireStore.collection(tableNameSignUp).doc(userId);
    documentReference.update(
        {'name': name, 'email': email, 'mobile': mobile, 'address': address});
  }

  Future<void> changePassword(String userId, String currentPassword, String newPassword) async {
    var querySnapshot = await _firebaseFireStore
        .collection(tableNameSignUp)
        .where('password', isEqualTo: currentPassword)
        .get();
   if(querySnapshot.docs.isNotEmpty) {
     var documentReference = _firebaseFireStore.collection(tableNameSignUp).doc(
         userId);
     documentReference.update({'password': newPassword});
   }
  }
}
