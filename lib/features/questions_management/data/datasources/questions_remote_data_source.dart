import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lowgos_dashboard/features/questions_management/data/models/answer_model.dart';
import '../models/question_model.dart';

abstract class QuestionsRemoteDataSource {
  Future<void> addQuestion(QuestionModel question);
  Future<List<QuestionModel>> getQuestions();
  Future<void> updateQuestionStatus(String questionId, bool isActive);
  Future<void> deleteQuestion(String questionId);
  Future<void> shareQuestion(String questionId);
}

class QuestionsRemoteDataSourceImpl implements QuestionsRemoteDataSource {
  final FirebaseFirestore firestore;

  QuestionsRemoteDataSourceImpl({required this.firestore});

  @override
  Future<void> addQuestion(QuestionModel question) async {
    final docRef = firestore.collection('questions').doc();
    final questionWithId = QuestionModel(
      questionId: docRef.id,
      lawId: question.lawId,
      materialId: question.materialId,
      level: question.level,
      questionText: question.questionText,
      answers: question.answers as List<AnswerModel>,
      difficulty: question.difficulty,
      type: question.type,
      isShared: question.isShared,
      isActive: question.isActive,
      createdAt: FieldValue.serverTimestamp() as dynamic,
      isDeleted: false,
    );
    await docRef.set(questionWithId.toJson());
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
      data['question_id'] = doc.id; // ensuring ID is mapped
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
}
