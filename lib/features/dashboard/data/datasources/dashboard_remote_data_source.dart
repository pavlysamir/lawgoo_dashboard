import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../models/dashboard_stats_model.dart';
import '../../../../core/utils/firebase_constants.dart';
import '../../../../core/utils/firebase_extensions.dart';

abstract class DashboardRemoteDataSource {
  Future<DashboardStatsModel> getDashboardStats();
  Future<List<UserModel>> getUsers({int limit = 4, String? lastUserId});
  Future<List<UserModel>> searchUsers(String query);
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final FirebaseFirestore firestore;

  DashboardRemoteDataSourceImpl({required this.firestore});

  @override
  Future<DashboardStatsModel> getDashboardStats() async {
    return FirebaseLogger.logCall(
      'getDashboardStats',
      call: () async {
        Future<int?> getCount(String collection) async {
          try {
            final snapshot = await firestore.collection(collection).limit(1).get();
            if (snapshot.docs.isEmpty) return null;
            final countResult = await firestore.collection(collection).count().get();
            return countResult.count;
          } catch (_) {
            return null;
          }
        }

        final usersCount = await getCount(FirebaseCollections.users);
        final questionsCount = await getCount(FirebaseCollections.questions);
        final materialsCount = await getCount(FirebaseCollections.materials);
        
        final systemDoc = await firestore.collection(FirebaseCollections.settings).doc('system').get();
        final isActive = systemDoc.exists ? (systemDoc.data()?['isActive'] ?? true) : true;

        return DashboardStatsModel(
          totalUsers: usersCount,
          totalQuestions: questionsCount,
          totalMaterials: materialsCount,
          isSystemActive: isActive,
        );
      },
    );
  }

  @override
  Future<List<UserModel>> getUsers({int limit = 4, String? lastUserId}) async {
    return FirebaseLogger.logCall(
      'getUsers',
      params: {'limit': limit, 'lastUserId': lastUserId},
      call: () async {
        var query = firestore
            .collection(FirebaseCollections.users)
            .orderBy('createdAt', descending: true);

        if (lastUserId != null) {
          final lastDoc =
              await firestore.collection(FirebaseCollections.users).doc(lastUserId).get();
          if (lastDoc.exists) {
            query = query.startAfterDocument(lastDoc);
          }
        }

        query = query.limit(limit);

        final snapshot = await query.get();

        return snapshot.docs.map((doc) {
          final userData = doc.data();
          final completedLevels = userData['completed_levels'] as int? ?? 0;

          return UserModel.fromJson(
            {...userData, 'countCompletedLevels': completedLevels},
            doc.id,
          );
        }).toList();
      },
    );
  }

  @override
  Future<List<UserModel>> searchUsers(String queryText) async {
    return FirebaseLogger.logCall(
      'searchUsers',
      params: {'queryText': queryText},
      call: () async {
        final snapshot = await firestore
            .collection(FirebaseCollections.users)
            .where('name', isGreaterThanOrEqualTo: queryText)
            .where('name', isLessThanOrEqualTo: '$queryText\uf8ff')
            .get();

        return snapshot.docs.map((doc) {
          final userData = doc.data();
          final completedLevels = userData['completed_levels'] as int? ?? 0;

          return UserModel.fromJson(
            {...userData, 'countCompletedLevels': completedLevels},
            doc.id,
          );
        }).toList();
      },
    );
  }
}
