import 'dart:io';
import 'dart:math';
import 'package:uuid/uuid.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

class PostController {
  final firebase_storage.FirebaseStorage _firebaseStorage = firebase_storage.FirebaseStorage.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  ///file upload
  Future<String> uploadImage(File photo) async {
    final String randomID = const Uuid().v4();

// reference file to be uploaded
    firebase_storage.Reference ref = _firebaseStorage.ref().child('posts').child('$randomID.png');
//insert file / put file to uploaded
    firebase_storage.UploadTask uploadTask = ref.putFile(photo);
////wait for the upload process to finish
    firebase_storage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => ref.getDownloadURL());

    print(await taskSnapshot.ref.getDownloadURL());

    //return prelink to the file uploaded
    return await taskSnapshot.ref.getDownloadURL();
  }

  //adding of data to firebase
  Future<bool> submitPost({required File image}) async {
    bool isSuccess = false;
    String postImageUrl = await uploadImage(image);
//create collection
    final CollectionReference postCollection = _firebaseFirestore.collection('posts');

    await postCollection
        .add({
          'image_Url': postImageUrl,
          'name': 'Hubert kingsley ocran',
          'location': 'KNUST-Kumasi,Ghana',
          'profilePic': 'https://images.unsplash.com/photo-1641945511438-942383b1193c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1682&q=80',
          'likesCount': Random().nextInt(100),
          'commentCount': Random().nextInt(100),
          'createdAt': FieldValue.serverTimestamp()
        })
        .then((value) => isSuccess = true)
        .catchError((onError) {
          print(onError);
          isSuccess = false;
        });
    return isSuccess;
  }
}
