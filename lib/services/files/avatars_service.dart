import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AvatarService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future saveAvatar(String uid, Uint8List avatarBytes) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final imgRef = storageRef.child("$uid.jpg");
      UploadTask task = imgRef.putData(avatarBytes);
      TaskSnapshot snapshot = await task;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      _firestore.collection("Users").doc(uid).update(
        {
          'avatar_link' : downloadUrl
        }
      );

      print(downloadUrl);
    } on FirebaseException catch (e) {
      print("Storage uploading error: $e");
    }
  }
}
