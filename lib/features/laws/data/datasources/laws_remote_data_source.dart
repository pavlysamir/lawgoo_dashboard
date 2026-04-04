import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/utils/firebase_extensions.dart';
import '../models/law_model.dart';

abstract class LawsRemoteDataSource {
  Future<List<LawModel>> getLaws({int limit = 10, LawModel? lastLaw});
  Future<int> getLawsCount();
  Future<int> getActiveLawsCount();
  Future<void> addLaw(LawModel law);
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
          final lastDoc = await firestore.collection('laws').doc(lastLaw.id).get();
          if (lastDoc.exists) {
            query = query.startAfterDocument(lastDoc);
          }
        }

        final snapshot = await query.get();
        return snapshot.docs
            .map((doc) =>
                LawModel.fromJson(doc.data() as Map<String, dynamic>, doc.id))
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
        final docRef = firestore.collection('laws').doc();
        await docRef.set({
          ...law.toJson(),
          'id': docRef.id,
          'is_deleted': false,
          'updated_at': FieldValue.serverTimestamp(),
          'created_at': FieldValue.serverTimestamp(),
        });
      },
    );
  }
}
