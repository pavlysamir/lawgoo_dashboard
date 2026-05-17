import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/question_model.dart';

abstract class QuestionsRemoteDataSource {
  Future<void> addQuestion(QuestionModel question);
  Future<List<QuestionModel>> getQuestions({String? lawId});
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
    final batch = firestore.batch();
    final docRef = firestore.collection('questions').doc();
    final data = question.toJson();
    data['question_id'] = docRef.id;
    data['created_at'] = FieldValue.serverTimestamp();
    data['updated_at'] = FieldValue.serverTimestamp();
    data['is_deleted'] = false;

    batch.set(docRef, data);

    // Increment totalQuestions in the corresponding law
    final lawRef = firestore.collection('laws').doc(question.lawId);
    batch.update(lawRef, {
      'total_questions': FieldValue.increment(1),
    });

    if (question.isActive) {
      // Track active questions in the corresponding law_level.
      final levelRef = firestore
          .collection('law_levels')
          .doc('${question.lawId}_level_${question.level}');
      batch.update(levelRef, {
        'questions_count': FieldValue.increment(1),
        'updated_at': FieldValue.serverTimestamp(),
      });
    }

    await batch.commit();
  }

  @override
  Future<List<QuestionModel>> getQuestions({String? lawId}) async {
    Query query = firestore
        .collection('questions')
        .where('is_deleted', isEqualTo: false);

    if (lawId != null) {
      query = query.where('law_id', isEqualTo: lawId);
    }

    final snapshot = await query.orderBy('created_at', descending: true).get();

    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      data['question_id'] = doc.id;

      // Convert Timestamps to ISO8601 strings to match QuestionModel.fromJson expectation
      if (data['created_at'] is Timestamp) {
        data['created_at'] = (data['created_at'] as Timestamp)
            .toDate()
            .toIso8601String();
      }
      if (data['updated_at'] is Timestamp) {
        data['updated_at'] = (data['updated_at'] as Timestamp)
            .toDate()
            .toIso8601String();
      }

      return QuestionModel.fromJson(data);
    }).toList();
  }

  @override
  Future<void> updateQuestionStatus(String questionId, bool isActive) async {
    final batch = firestore.batch();
    final questionRef = firestore.collection('questions').doc(questionId);

    final questionDoc = await questionRef.get();
    if (!questionDoc.exists) return;

    final data = questionDoc.data() as Map<String, dynamic>;
    final oldIsActive = data['is_active'] as bool? ?? true;
    final isDeleted = data['is_deleted'] as bool? ?? false;
    final lawId = data['law_id'] as String?;
    final level = data['level'] as int?;

    batch.update(questionRef, {
      'is_active': isActive,
      'updated_at': FieldValue.serverTimestamp(),
    });

    if (!isDeleted &&
        oldIsActive != isActive &&
        lawId != null &&
        level != null) {
      final levelRef = firestore
          .collection('law_levels')
          .doc('${lawId}_level_$level');
      batch.update(levelRef, {
        'questions_count': FieldValue.increment(isActive ? 1 : -1),
        'updated_at': FieldValue.serverTimestamp(),
      });
    }

    await batch.commit();
  }

  @override
  Future<void> deleteQuestion(String questionId) async {
    final batch = firestore.batch();
    final questionRef = firestore.collection('questions').doc(questionId);

    // Get the question to find the lawId and level
    final questionDoc = await questionRef.get();
    if (!questionDoc.exists) return;

    final data = questionDoc.data() as Map<String, dynamic>;
    final lawId = data['law_id'] as String?;
    final level = data['level'] as int?;
    final isActive = data['is_active'] as bool? ?? true;

    batch.update(questionRef, {
      'is_deleted': true,
      'updated_at': FieldValue.serverTimestamp(),
    });

    if (lawId != null) {
      final lawRef = firestore.collection('laws').doc(lawId);
      batch.update(lawRef, {
        'total_questions': FieldValue.increment(-1),
      });

      if (isActive && level != null) {
        final levelRef = firestore
            .collection('law_levels')
            .doc('${lawId}_level_$level');
        batch.update(levelRef, {
          'questions_count': FieldValue.increment(-1),
          'updated_at': FieldValue.serverTimestamp(),
        });
      }
    }

    await batch.commit();
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
    final batch = firestore.batch();
    final questionRef =
        firestore.collection('questions').doc(question.questionId);

    // Get old question data to check for lawId or level changes
    final questionDoc = await questionRef.get();
    if (!questionDoc.exists) return;

    final oldData = questionDoc.data() as Map<String, dynamic>;
    final oldLawId = oldData['law_id'] as String?;
    final oldLevel = oldData['level'] as int?;
    final oldIsActive = oldData['is_active'] as bool? ?? true;
    final isDeleted = oldData['is_deleted'] as bool? ?? false;

    final newLawId = question.lawId;
    final newLevel = question.level;
    final newIsActive = question.isActive;

    final data = question.toJson();
    data['updated_at'] = FieldValue.serverTimestamp();

    batch.update(questionRef, data);

    // Handle Law counter change
    if (oldLawId != newLawId) {
      if (oldLawId != null) {
        batch.update(firestore.collection('laws').doc(oldLawId), {
          'total_questions': FieldValue.increment(-1),
        });
      }
      batch.update(firestore.collection('laws').doc(newLawId), {
        'total_questions': FieldValue.increment(1),
      });
    }

    // Handle active questions count for level changes/status changes.
    if (!isDeleted &&
        (oldLawId != newLawId ||
            oldLevel != newLevel ||
            oldIsActive != newIsActive)) {
      if (oldIsActive && oldLawId != null && oldLevel != null) {
        batch.update(
          firestore.collection('law_levels').doc('${oldLawId}_level_$oldLevel'),
          {
            'questions_count': FieldValue.increment(-1),
            'updated_at': FieldValue.serverTimestamp(),
          },
        );
      }
      if (newIsActive) {
        batch.update(
          firestore.collection('law_levels').doc('${newLawId}_level_$newLevel'),
          {
            'questions_count': FieldValue.increment(1),
            'updated_at': FieldValue.serverTimestamp(),
          },
        );
      }
    }

    await batch.commit();
  }
}
