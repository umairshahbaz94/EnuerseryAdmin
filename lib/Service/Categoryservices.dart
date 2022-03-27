import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  static final FirebaseFirestore _db =FirebaseFirestore.instance;

  static Future<bool> addCategory(Map<String, dynamic> category) async {
    await _db.collection('Category').doc().set(category).catchError((e) {
      print(e);
    });
    return true;
  }

  static Future<bool> updateCategory(String id, Map<String, dynamic> category) async {
    await _db.collection('Category').doc(id).update(category).catchError((e) {
      print(e);
    });
    return true;
  }

  static Future<bool> deletecategory(String id) async {
    await _db.collection('Category').doc(id).delete().catchError((e) {
      print(e);
    });
    return true;
  }
}