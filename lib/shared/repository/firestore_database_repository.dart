import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:interviewquestion/model/freecode/free_code_response.dart';
import 'package:interviewquestion/model/index/index_response.dart';
import 'package:interviewquestion/model/interview_question/interview_question_response.dart';
import 'package:interviewquestion/model/subject/subject_response.dart';
import 'package:interviewquestion/model/technology/technology_response.dart';
import 'package:interviewquestion/shared/provider/firestore_provider.dart';

class FireStoreDatabaseRepository implements FireStoreDatabaseProvider {
  final _fireStoreDatabaseFoodCafe = Get.find<FireStoreDatabaseProvider>();

  @override
  Future<User> googleLogin() {
    return _fireStoreDatabaseFoodCafe.googleLogin();
  }

  @override
  googleLogout() async {
    _fireStoreDatabaseFoodCafe.googleLogout();
  }

  @override
  Future<String> signUp(Map<String, dynamic> param) {
    return _fireStoreDatabaseFoodCafe.signUp(param);
  }

  @override
  Future<int> checkEmail(String email) {
    return _fireStoreDatabaseFoodCafe.checkEmail(email);
  }

  @override
  Future<QuerySnapshot> login(String email, String password) {
    return _fireStoreDatabaseFoodCafe.login(email, password);
  }

  @override
  Stream<List<SubjectResponse>> subject() {
    return _fireStoreDatabaseFoodCafe.subject();
  }

  @override
  Stream<List<IndexResponse>> index(String id) {
    return _fireStoreDatabaseFoodCafe.index(id);
  }

  @override
  Stream<List<InterviewQuestionResponse>> interviewQuestion(String indexId) {
    return _fireStoreDatabaseFoodCafe.interviewQuestion(indexId);
  }

  @override
  void isFavourite(String userId, String interviewQuestionId, int operation) {
    return _fireStoreDatabaseFoodCafe.isFavourite(
        userId, interviewQuestionId, operation);
  }

  @override
  void isReadView(String userId, String interviewQuestionId, int operation) {
    return _fireStoreDatabaseFoodCafe.isReadView(
        userId, interviewQuestionId, operation);
  }

  @override
  Stream<List<InterviewQuestionResponse>> favouriteInterviewQuestion(
      String userId ) {
    return _fireStoreDatabaseFoodCafe.favouriteInterviewQuestion(userId);
  }

  @override
  void profileEdit(
      String userId, String name, String email, String mobile, String address) {
    return _fireStoreDatabaseFoodCafe.profileEdit(
        userId, name, email, mobile, address);
  }

  @override
  Stream<List<FreeCodeResponse>>  freeCode() {
    return _fireStoreDatabaseFoodCafe.freeCode();
  }

  @override
  Future<void> changePassword(String userId, String currentPassword, String newPassword) {
    return _fireStoreDatabaseFoodCafe.changePassword(userId, currentPassword, newPassword);
  }

  @override
  Stream<List<TechnologyResponse>> technology() {
    return _fireStoreDatabaseFoodCafe.technology();
  }

  @override
  Future<QuerySnapshot> forgotPassword(String email) {
    return _fireStoreDatabaseFoodCafe.forgotPassword(email);
  }
}
