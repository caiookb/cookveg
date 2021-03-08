import 'package:cloud_firestore/cloud_firestore.dart';

class StorageRepo {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  getUsualRecipes(String document) async {
    CollectionReference usualRecipes =
        FirebaseFirestore.instance.collection('recipes');

    return usualRecipes.doc(document).snapshots();
  }

  Future<void> uploadProfilePic() async {}
}
