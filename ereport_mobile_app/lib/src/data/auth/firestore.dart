import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ereport_mobile_app/src/data/models/user_model.dart';

class Firestore {
  final db = FirebaseFirestore.instance;

  Future<LocalUser?> getUserData(String UID) async {
    final docRef = db.collection("user");

    // docRef.snapshots().map((event) => event.docs.map((e) => LocalUser.fromMap(e.data())));

    try{
      final querySnapshot = await docRef.where("UID", isEqualTo: UID).get();
      for (var docSnapshot in querySnapshot.docs) {
        final user = LocalUser.fromMap(docSnapshot.data());
        return user;
      }
    } catch(e){
      print("error while fetching : $e");
      return null;
    }


  }
}