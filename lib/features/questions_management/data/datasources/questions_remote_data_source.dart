import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lowgos_dashboard/features/questions_management/data/models/answer_model.dart';
import '../models/question_model.dart';

abstract class QuestionsRemoteDataSource {
  Future<void> addQuestion(QuestionModel question);
  Future<List<QuestionModel>> getQuestions();
  Future<void> updateQuestionStatus(String questionId, bool isActive);
  Future<void> deleteQuestion(String questionId);
  Future<void> shareQuestion(String questionId);
  Future<void> updateQuestion(QuestionModel question);
}

class QuestionsRemoteDataSourceImpl implements QuestionsRemoteDataSource {
  final FirebaseFirestore firestore;

  QuestionsRemoteDataSourceImpl({required this.firestore});

  @override
  Future<void> addQuestion(QuestionModel question) async {
    final docRef = firestore.collection('questions').doc();
    final data = question.toJson();
    data['question_id'] = docRef.id;
    data['created_at'] = FieldValue.serverTimestamp();
    data['updated_at'] = FieldValue.serverTimestamp();
    data['is_deleted'] = false;
    await docRef.set(data);
  }

  @override
  Future<List<QuestionModel>> getQuestions() async {
    final snapshot = await firestore
        .collection('questions')
        .where('is_deleted', isEqualTo: false)
        .orderBy('created_at', descending: true)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['question_id'] = doc.id;
      
      // Convert Timestamps to ISO8601 strings to match QuestionModel.fromJson expectation
      if (data['created_at'] is Timestamp) {
        data['created_at'] = (data['created_at'] as Timestamp).toDate().toIso8601String();
      }
      if (data['updated_at'] is Timestamp) {
        data['updated_at'] = (data['updated_at'] as Timestamp).toDate().toIso8601String();
      }
      
      return QuestionModel.fromJson(data);
    }).toList();
  }

  @override
  Future<void> updateQuestionStatus(String questionId, bool isActive) async {
    await firestore.collection('questions').doc(questionId).update({
      'is_active': isActive,
      'updated_at': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> deleteQuestion(String questionId) async {
    await firestore.collection('questions').doc(questionId).update({
      'is_deleted': true,
      'updated_at': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> shareQuestion(String questionId) async {
    await firestore.collection('questions').doc(questionId).update({
      'is_shared': true,
      'updated_at': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> updateQuestion(QuestionModel question) async {
    final data = question.toJson();
    data['updated_at'] = FieldValue.serverTimestamp();
    await firestore.collection('questions').doc(question.questionId).update(data);
  }
}
