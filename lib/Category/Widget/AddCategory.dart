import 'dart:io';


import 'package:enersuryadmin/Category/Widget/Editcategory.dart';
import 'package:enersuryadmin/Category/Widget/widget/Categorywidget.dart';
import 'package:enersuryadmin/Provider/Prodcut.dart';
import 'package:enersuryadmin/Service/Categoryservices.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';


class TodoList extends StatefulWidget {
  static String routeName = "/TodoList";
  @override
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
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
          return EditDialog(
              title: 'Add Category',
              positiveAction: 'ADD',
              negativeAction: 'CANCEL',
              submit: _handleDialogSubmission);
        });
  }



  // Add Task
  void _handleDialogSubmission(String value,context,File file) async{
     var provider = Provider.of<Productprovider>(context,listen: false);
   EasyLoading.show(status:"Processing Save");
                                provider.imageupload(file.path).then((value2)  {

var task = <String, dynamic>{
      'Name': value,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'imageurl':value2
    };
    Database.addCategory(task);
    EasyLoading.showSuccess("Save Successfully");

    });
   
    
    
  }

  // Placeholder Function to retrieve Tasks

  Widget _getTasks() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Category')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemBuilder: (BuildContext context, int index) => Tasks(
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
    Database.updateCategory(id, task);
  }

  void _deleteTask(String id) {
    Database.deletecategory(id);
  }
}
