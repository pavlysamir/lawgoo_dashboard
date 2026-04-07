import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../../../firebase_options.dart';
import '../../../dashboard/data/models/user_model.dart';

abstract class SettingsRemoteDataSource {
  Future<void> createAdmin({
    required String name,
    required String email,
    required String password,
  });

  Future<List<UserModel>> getAdmins();

  Future<void> toggleAdminStatus(String adminId, bool isActive);

  Future<void> deleteAdmin(String adminId);
}

class SettingsRemoteDataSourceImpl implements SettingsRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth mainAuth;

  SettingsRemoteDataSourceImpl({
    required this.firestore,
    required this.mainAuth,
  });

  @override
  Future<void> createAdmin({
    required String name,
    required String email,
    required String password,
  }) async {
    FirebaseApp? secondaryApp;
    try {
      secondaryApp = Firebase.app('SecondaryApp');
    } catch (e) {
      secondaryApp = await Firebase.initializeApp(
        name: 'SecondaryApp',
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }

    FirebaseAuth secondaryAuth = FirebaseAuth.instanceFor(app: secondaryApp);

    try {
      // 1. Create user in Firebase Auth using the secondary app
      final userCredential = await secondaryAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user!.uid;

      // 2. Create user document in Firestore
      final adminModel = UserModel(
        id: uid,
        name: name,
        email: email,
        createdAt: DateTime.now(),
        isActive: true,
        role: 'admin',
      );

      await firestore.collection('users').doc(uid).set(adminModel.toJson());

      // 3. Sign out from secondary app to cleanup
      await secondaryAuth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<UserModel>> getAdmins() async {
    final querySnapshot = await firestore
        .collection('users')
        .where('role', isEqualTo: 'admin')
        .get();

    return querySnapshot.docs
        .map((doc) => UserModel.fromJson(doc.data(), doc.id))
        .toList();
  }

  @override
  Future<void> toggleAdminStatus(String adminId, bool isActive) async {
    await firestore.collection('users').doc(adminId).update({
      'isActive': isActive,
    });
  }

  @override
  Future<void> deleteAdmin(String adminId) async {
    // Note: This only deletes from Firestore. 
    // Deleting from Firebase Auth usually requires Admin SDK or being the user.
    await firestore.collection('users').doc(adminId).delete();
  }
}
