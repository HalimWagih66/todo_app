import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/task.dart';
import 'models/user.dart';

class MyDataBase{
  static CollectionReference<User>collectionUser(){
    return FirebaseFirestore.instance
        .collection(User.collectionName)
        .withConverter<User>(
        fromFirestore: (snapshot, options) => User.FromFireStore(snapshot.data()),
        toFirestore: (user, options) {
          return user.toFireStore();
        }
    );
  }
   static Future<void> addUser(String uId,User user){
    var collectionReference = collectionUser();
    return collectionReference.doc(uId).set(user);
  }
  static CollectionReference<Task> collectionTask(String uId){
   return collectionUser()
        .doc(uId)
        .collection(Task.collectionName)
        .withConverter<Task>(
        fromFirestore: (snapshot, options) => Task.FromFireStore(snapshot.data()),
        toFirestore: (task, options) => task.toFireStore(),
    );
  }
  static Future<void> addTask(String uId,Task task){
    var documentReference = collectionTask(uId);
    var newTask =  documentReference.doc();
    task.id = newTask.id;
    return newTask.set(task);
  }
  static Future<User?> readUser(String uId)async{
    var collectionReference = collectionUser();
    var documentSnapshot = await collectionReference.doc(uId).get();
    return documentSnapshot.data();
  }
  static Future<void> deleteTask(String uId,String taskId){
    return collectionTask(uId).doc(taskId).delete();
  }
  static Stream<QuerySnapshot<Task>> readTasks(String uId){
    return collectionTask(uId).snapshots();
  }
}