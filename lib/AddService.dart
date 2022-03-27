import 'dart:io';

import 'package:enersuryadmin/Provider/Prodcut.dart';
import 'package:enersuryadmin/Service/Editservice.dart';
import 'package:enersuryadmin/Service/Serviceservice.dart';
import 'package:enersuryadmin/Service/Widget/Service.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:provider/provider.dart';


class AddService extends StatefulWidget {
  static String routeName = "/AddService";
  @override
  @override
  _AddServiceState createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  bool status = false;
  var url;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Productprovider>(context);
    return Scaffold(
        appBar: AppBar(title: Text('To-Do List')),
        body: _getTasks(),
        floatingActionButton: FloatingActionButton(
            onPressed: () => _displayDialog(context),
            tooltip: 'Add Item',
            child: Icon(Icons.add)));
  }

  // Display Add Task Dialog
  Future<void> _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return EditDialogService(
              title: 'Add Service',
              positiveAction: 'ADD',
              negativeAction: 'CANCEL',
              submit: _handleDialogSubmission);
        });
  }

  // Add Task
  void _handleDialogSubmission(String value, context, File file) async {
    var provider = Provider.of<Productprovider>(context, listen: false);
    EasyLoading.show(status: "Processing Save");
    provider.imageupload(file.path).then((value2) {
      var task = <String, dynamic>{
        'Name': value,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'imageurl': value2
      };
      Database.addService(task);
      EasyLoading.showSuccess("Save Successfully");
    });
  }

  // Placeholder Function to retrieve Tasks

  Widget _getTasks() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Service')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemBuilder: (BuildContext context, int index) => Service(
                  name: snapshot.data!.docs[index]['Name'],
                  id: snapshot.data!.docs[index].id,
                  update: _updateTask,
                  delete: _deleteTask),
              itemCount: snapshot.data!.docs.length,
            );
          } else {
            return Container();
          }
        });
  }

  void _updateTask(String updatedValue, String id) {
    var task = <String, dynamic>{
      'Name': updatedValue,
      'timestamp': DateTime.now().millisecondsSinceEpoch
    };
    Database.updateService(id, task);
  }

  void _deleteTask(String id) {
    Database.deleteService(id);
  }
}
