import 'package:chat_app/helpers/auth_helper.dart';
import 'package:chat_app/modals/todo_model.dart';
import 'package:chat_app/modals/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class TodoHelper {
  FirebaseFirestore db = FirebaseFirestore.instance;

  String collectionName = 'todo';
  String userCollection = "Users";

  void addTodo({required Todo todo}) {
    db
        .collection(userCollection)
        .doc(AuthHelper.instance.auth.currentUser!.uid)
        .collection(collectionName)
        .doc(todo.id)
        .set(
          todo.toMap(),
        );
  }

  Future<void> addUser({required User user}) async {
    Map<String, dynamic> data = {
      "uid": user.uid,
      "email": user.email ?? "Undefined",
      "displayName": user.displayName ?? "Guest",
      "photoURL": user.photoURL ??
          "https://e7.pngegg.com/pngimages/81/570/png-clipart-profile-logo-computer-icons-user-user-blue-heroes-thumbnail.png",
      "phoneNumber": user.phoneNumber ?? "Undefined",
    };
    await db.collection(userCollection).doc(user.uid).set(
          data,
        );
    await db.collection(userCollection).doc(user.uid).get();
  }

  void updateTodo({required Todo todo}) {
    db
        .collection(userCollection)
        .doc(AuthHelper.instance.auth.currentUser!.uid)
        .collection(collectionName)
        .doc(todo.id)
        .update(
          todo.toMap(),
        );
  }

  void deleteTodo({required Todo todo}) {
    db
        .collection(userCollection)
        .doc(AuthHelper.instance.auth.currentUser!.uid)
        .collection(collectionName)
        .doc(todo.id)
        .delete();
  }

  Future<List<Todo>> getAllTodo() async {
    QuerySnapshot snapshot = await db
        .collection(userCollection)
        .doc(AuthHelper.instance.auth.currentUser!.uid)
        .collection(collectionName)
        .get();
    return snapshot.docs.map((doc) {
      return Todo(
        doc['id'],
        doc['title'],
        doc['status'],
        doc['dTime'],
      );
    }).toList();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return db.collection(userCollection).snapshots();
  }

  Future<void> addFriend({required UserModel userModel}) async {
    await db
        .collection(userCollection)
        .doc(AuthHelper.instance.auth.currentUser!.uid)
        .collection('friends')
        .doc(userModel.uid)
        .set(userModel.toJson)
        .then(
          (value) => Logger().i("Your friend has been added successfully !!! "),
        )
        .onError((error, stackTrace) => Logger().e("ERROR: $error"));
  }

  Future<List<UserModel>> getFriends() async {
    List<UserModel> allFriends = [];

    allFriends = (await db
            .collection(userCollection)
            .doc(AuthHelper.instance.auth.currentUser!.uid)
            .collection('friends')
            .get())
        .docs
        .map((e) => UserModel.fromJson(e.data()))
        .toList();

    return allFriends;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getFriendsStream() {
    return db
        .collection(userCollection)
        .doc(AuthHelper.instance.auth.currentUser!.uid)
        .collection('friends')
        .snapshots();
  }

  TodoHelper._();
  static final TodoHelper tHelper = TodoHelper._();
}
