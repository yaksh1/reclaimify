import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reclaimify/components/my_snackbar.dart';
import 'package:reclaimify/data/models/post.dart';
import 'package:reclaimify/services/storage/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //!upload post
  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String title,
    String category,
    String location,
    String postType,
  ) async {
    String res = "some error occurred";

    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);

      String postId = const Uuid().v1();
      Post post = Post(
          description: description,
          uid: uid,
          username: username,
          postId: postId,
          datePublished: DateTime.now(),
          postUrl: photoUrl,
          category: category,
          location: location,
          postType: postType,
          title: title);
      _firestore.collection('posts').doc(postId).set(post.toJson());

      res = "Success";
    } catch (e) {
      MySnackBar().mySnackBar(header: "Error", content: e.toString());
    }
    return res;
  }

  //! <---- update post -----> //
  Future<String> updatePost(
      String description,
      Uint8List file,
      String uid,
      String username,
      String title,
      String category,
      String location,
      String postType,
      String postID) async {
    String res = "some error occurred";

    try {
      String photoUrl =
          await StorageMethods().updateImageToStorage('posts', file, true);

      
      Post post = Post(
          description: description,
          uid: uid,
          username: username,
          postId: postID,
          datePublished: DateTime.now(),
          postUrl: photoUrl,
          category: category,
          location: location,
          postType: postType,
          title: title);
      _firestore.collection('posts').doc(postID).update(post.toJson());

      res = "Success";
    } catch (e) {
      MySnackBar().mySnackBar(header: "Error", content: e.toString());
    }
    return res;
  }

  //! <---- delete post -----> //
  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
    } catch (e) {
      MySnackBar().mySnackBar(header: "Error", content: e.toString());
    }
  }
}
