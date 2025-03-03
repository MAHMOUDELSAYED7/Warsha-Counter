import 'package:cloud_firestore/cloud_firestore.dart';

class FirebasePermissionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> isAppClosed() async {
    try {
      final doc = await _firestore.collection('close').doc('app_status').get();
      if (doc.exists) {
        return doc.data()?['close'] as bool? ?? false;
      }
      return false; // Default to false if the document doesn't exist
    } catch (e) {
      throw Exception('Failed to check app status: $e');
    }
  }

  // Get the current app version from Firestore
  Future<int> getAppVersion() async {
    try {
      final doc =
          await _firestore.collection('version').doc('current_version').get();
      if (doc.exists) {
        return (doc.data()?['number'] as num? ?? 1).toInt();
      }
      return 1; // Default to version 1 if the document doesn't exist
    } catch (e) {
      throw Exception('Failed to fetch app version: $e');
    }
  }
}
