import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String postId;
  final String username;
  final datePublished;
  final String postUrl;
  final String title;
  final String category;
  final String postType;
  final String location;

  Post({required this.category,
      required this.postType,
      required this.location, 
      required this.description,
      required this.uid,
      required this.postId,
      required this.username,
      required this.datePublished,
      required this.postUrl,
      required this.title});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'description': description,
      'uid': uid,
      'postId': postId,
      'username': username,
      'datePublished': datePublished,
      'postUrl': postUrl,
      'title': title,
      'category':category,
      'postType':postType,
      'location':location,
    };
  }

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      username: snapshot['username'],
      uid: snapshot['uid'],
      description: snapshot['description'],
      postId: snapshot['postId'],
      datePublished: snapshot['datePublished'],
      title: snapshot['title'],
      postUrl: snapshot['postUrl'], 
      location: snapshot['location'], 
      category: snapshot['category'], 
      postType: snapshot['postType'], 

    );
  }
}
