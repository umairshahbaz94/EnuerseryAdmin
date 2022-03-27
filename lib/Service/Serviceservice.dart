import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  static final FirebaseFirestore _db =FirebaseFirestore.instance;

  static Future<bool> addService(Map<String, dynamic> service) async {
    await _db.collection('Service').doc().set(service).catchError((e) {
      print(e);
    });
    return true;
  }

  static Future<bool> updateService(String id, Map<String, dynamic> service) async {
    await _db.collection('Service').doc(id).update(service).catchError((e) {
      print(e);
    });
    return true;
  }

  static Future<bool> deleteService(String id) async {
    await _db.collection('Service').doc(id).delete().catchError((e) {
      print(e);
    });
    return true;
  }
}