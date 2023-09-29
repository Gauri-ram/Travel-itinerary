import 'package:cloud_firestore/cloud_firestore.dart';

class CurrentUserModel {
  String userId = '';
  String username = '';
  String email = '';

  Future<void> updateUser(String userId) async {
    // Fetch user data from Firestore based on the provided userId
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get();

    this.userId = userId;
    this.username = userSnapshot['username'];
    this.email = userSnapshot['email'];
  }

  static final CurrentUserModel _instance = CurrentUserModel._internal();

  factory CurrentUserModel() {
    return _instance;
  }

  CurrentUserModel._internal();
}
