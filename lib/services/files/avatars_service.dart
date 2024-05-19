import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

class AvatarService {
  Future saveAvatar(String uid, Uint8List avatarBytes) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final imgRef = storageRef.child("$uid.jpg");
      UploadTask task = imgRef.putData(avatarBytes);
      TaskSnapshot snapshot = await task;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      print(downloadUrl);
    } on FirebaseException catch (e) {
      print("Storage uploading error: $e");
    }
  }

  Future<Uint8List?> getAvatar(String uid) async {
    final storageRef = FirebaseStorage.instance.ref();
    final imageRef = storageRef.child("$uid.jpg");

    Uint8List? avatar;

    try {
      avatar = await imageRef.getData();
    } catch (e) {
      print("Storage downloading error: $e");
    }

    return avatar;
  }
}
