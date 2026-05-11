import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/utils/firebase_extensions.dart';
import '../models/law_model.dart';

abstract class LawsRemoteDataSource {
  Future<List<LawModel>> getLaws({int limit = 10, LawModel? lastLaw});
  Future<int> getLawsCount();
  Future<int> getActiveLawsCount();
  Future<void> addLaw(LawModel law);
  Future<void> deleteLaw(String lawId);
  Future<void> toggleLawActive(String id, bool isActive);
}

class LawsRemoteDataSourceImpl implements LawsRemoteDataSource {
  final FirebaseFirestore firestore;

  LawsRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<LawModel>> getLaws({int limit = 10, LawModel? lastLaw}) async {
    return FirebaseLogger.logCall(
      'getLaws',
      params: {'limit': limit, 'lastLawId': lastLaw?.id},
      call: () async {
        Query query = firestore
            .collection('laws')
            .where('is_deleted', isNotEqualTo: true)
            .orderBy('created_at', descending: true)
            .limit(limit);

        if (lastLaw != null && lastLaw.id.isNotEmpty) {
          final lastDoc = await firestore
              .collection('laws')
              .doc(lastLaw.id)
              .get();
          if (lastDoc.exists) {
            query = query.startAfterDocument(lastDoc);
          }
        }

        final snapshot = await query.get();
        return snapshot.docs
            .map(
              (doc) =>
                  LawModel.fromJson(doc.data() as Map<String, dynamic>, doc.id),
            )
            .toList();
      },
    );
  }

  @override
  Future<int> getLawsCount() async {
    return FirebaseLogger.logCall(
      'getLawsCount',
      call: () async {
        final snapshot = await firestore
            .collection('laws')
            .where('is_deleted', isNotEqualTo: true)
            .count()
            .get();
        return snapshot.count ?? 0;
      },
    );
  }

  @override
  Future<int> getActiveLawsCount() async {
    return FirebaseLogger.logCall(
      'getActiveLawsCount',
      call: () async {
        final snapshot = await firestore
            .collection('laws')
            .where('is_deleted', isNotEqualTo: true)
            .where('is_active', isEqualTo: true)
            .count()
            .get();
        return snapshot.count ?? 0;
      },
    );
  }

  @override
  Future<void> addLaw(LawModel law) async {
    return FirebaseLogger.logCall(
      'addLaw',
      params: law.toJson(),
      call: () async {
        final batch = firestore.batch();
        final docRef = firestore.collection('laws').doc();
        final lawId = docRef.id;

        // 1. Create Law document
        batch.set(docRef, {
          ...law.toJson(),
          'id': lawId,
          'is_deleted': false,
          'updated_at': FieldValue.serverTimestamp(),
          'created_at': FieldValue.serverTimestamp(),
        });

        // 2. Create LawLevels documents
        for (int i = 1; i <= law.totalLevels; i++) {
          final levelRef =
              firestore.collection('law_levels').doc('${lawId}_level_$i');
          batch.set(levelRef, {
            'id': levelRef.id,
            'law_id': lawId,
            'level_number': i,
            'title': 'المستوى $i',
            'questions_count': 0,
            'expected_duration_minutes': 5,
            'reward_points': 50,
            'order': i,
            'is_active': true,
            'created_at': FieldValue.serverTimestamp(),
            'updated_at': FieldValue.serverTimestamp(),
          });
        }

        await batch.commit();
      },
    );
  }

  @override
  Future<void> deleteLaw(String lawId) async {
    return FirebaseLogger.logCall(
      'deleteLaw',
      params: {'id': lawId},
      call: () async {
        await firestore.collection('laws').doc(lawId).update({
          'is_deleted': true,
          'updated_at': FieldValue.serverTimestamp(),
        });
      },
    );
  }
  @override
  Future<void> toggleLawActive(String id, bool isActive) async {
    return FirebaseLogger.logCall(
      'toggleLawActive',
      params: {'id': id, 'is_active': isActive},
      call: () async {
        await firestore.collection('laws').doc(id).update({
          'is_active': isActive,
          'updated_at': FieldValue.serverTimestamp(),
        });
      },
    );
  }
}
