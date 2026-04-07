import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/utils/firebase_extensions.dart';
import '../models/law_material_model.dart';

abstract class LawMaterialRemoteDataSource {
  Future<List<LawMaterialModel>> getLawMaterials(
    String lawId, {
    int limit = 10,
    LawMaterialModel? lastMaterial,
    String? searchQuery,
  });

  Future<int> getLawMaterialsCount(String lawId);

  Future<void> addLawMaterial(LawMaterialModel material);

  Future<void> updateLawMaterial(LawMaterialModel material);

  Future<void> deleteLawMaterial(String materialId);
}

class LawMaterialRemoteDataSourceImpl implements LawMaterialRemoteDataSource {
  final FirebaseFirestore firestore;

  LawMaterialRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<LawMaterialModel>> getLawMaterials(
    String lawId, {
    int limit = 10,
    LawMaterialModel? lastMaterial,
    String? searchQuery,
  }) async {
    return FirebaseLogger.logCall(
      'getLawMaterials',
      params: {
        'lawId': lawId,
        'limit': limit,
        'lastMaterialId': lastMaterial?.id,
        'searchQuery': searchQuery,
      },
      call: () async {
        Query query = firestore
            .collection('materials')
            .where('law_id', isEqualTo: lawId)
            .where('is_deleted', isNotEqualTo: true);

        if (searchQuery != null && searchQuery.isNotEmpty) {
          final orderNumber = int.tryParse(searchQuery);
          if (orderNumber != null) {
            query = query.where('order', isEqualTo: orderNumber);
          }
        }

        // Always order by 'order' for consistency in materials
        query = query.orderBy('order', descending: false).limit(limit);

        if (lastMaterial != null && lastMaterial.id.isNotEmpty) {
          final lastDoc = await firestore
              .collection('materials')
              .doc(lastMaterial.id)
              .get();
          if (lastDoc.exists) {
            query = query.startAfterDocument(lastDoc);
          }
        }

        final snapshot = await query.get();
        return snapshot.docs
            .map(
              (doc) => LawMaterialModel.fromJson(
                doc.data() as Map<String, dynamic>,
                doc.id,
              ),
            )
            .toList();
      },
    );
  }

  @override
  Future<int> getLawMaterialsCount(String lawId) async {
    return FirebaseLogger.logCall(
      'getLawMaterialsCount',
      params: {'lawId': lawId},
      call: () async {
        final snapshot = await firestore
            .collection('materials')
            .where('law_id', isEqualTo: lawId)
            .where('is_deleted', isNotEqualTo: true)
            .count()
            .get();
        return snapshot.count ?? 0;
      },
    );
  }

  @override
  Future<void> addLawMaterial(LawMaterialModel material) async {
    return FirebaseLogger.logCall(
      'addLawMaterial',
      params: material.toJson(),
      call: () async {
        final batch = firestore.batch();
        final docRef = firestore.collection('materials').doc();

        batch.set(docRef, {
          ...material.toJson(),
          'id': docRef.id,
          'is_deleted': false,
          'created_at': FieldValue.serverTimestamp(),
          'updated_at': FieldValue.serverTimestamp(),
        });

        batch.update(firestore.collection('laws').doc(material.lawId), {
          'materials_count': FieldValue.increment(1),
          'updated_at': FieldValue.serverTimestamp(),
        });

        await batch.commit();
      },
    );
  }

  @override
  Future<void> updateLawMaterial(LawMaterialModel material) async {
    return FirebaseLogger.logCall(
      'updateLawMaterial',
      params: material.toJson(),
      call: () async {
        await firestore.collection('materials').doc(material.id).update({
          ...material.toJson(),
          'updated_at': FieldValue.serverTimestamp(),
        });
      },
    );
  }

  @override
  Future<void> deleteLawMaterial(String materialId) async {
    return FirebaseLogger.logCall(
      'deleteLawMaterial',
      params: {'id': materialId},
      call: () async {
        final doc = await firestore.collection('materials').doc(materialId).get();
        if (!doc.exists) return;

        final lawId = doc.data()?['law_id'] as String?;
        if (lawId == null) return;

        final batch = firestore.batch();
        batch.update(firestore.collection('materials').doc(materialId), {
          'is_deleted': true,
          'updated_at': FieldValue.serverTimestamp(),
        });

        batch.update(firestore.collection('laws').doc(lawId), {
          'materials_count': FieldValue.increment(-1),
          'updated_at': FieldValue.serverTimestamp(),
        });

        await batch.commit();
      },
    );
  }
}
