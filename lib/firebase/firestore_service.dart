import 'package:cloud_firestore/cloud_firestore.dart';
import '../core/model/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch all verified users with an email as a stream
  Stream<List<UserModel>> getVerifiedUsersWithEmail() {
    return _firestore
        .collection('users')
        .where('emailVerified', isEqualTo: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => UserModel.fromMap(doc.id, doc.data()))
            .toList());
  }

  // Update insults counter for a user by ID
  Future<void> updateInsultsById(String userId, int delta) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'insults': FieldValue.increment(delta),
      });
    } catch (e) {
      throw Exception('Failed to update insults: $e');
    }
  }
}
