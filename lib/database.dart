import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  final String uid;
  DatabaseService({required this.uid});
  //collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  Future updateUserData(
      String name,
      String email_id,
      ) async{
    return await userCollection.doc(uid).set({
      'name' : name,
      'emailid':email_id,
    });

  }
}