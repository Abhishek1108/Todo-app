
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoapp/utils/db.dart';
import 'package:todoapp/models/user.dart';

class convert {
  static List<user> tasklist;

  static List<user> getTask() {
    return tasklist;
  }


  static setTask(List<user> tasks) {
    tasklist = tasks;
  }

  static Future<List<user>> convertDbToTask() async {
    if (tasklist != null) {
      return tasklist;
    }
    QuerySnapshot obj = await db.getAllRecords();
    List<user> tasks = [];
    obj.documents.forEach((doc) {
      user ut = new user(doc["todo"], doc["decr"]);
      ut.id = doc.documentID;
      tasks.add(ut);

      tasklist = tasks;
    });
    return tasklist;
  }
}
