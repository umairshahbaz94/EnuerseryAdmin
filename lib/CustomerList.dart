import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enersuryadmin/ProductManage/Product.dart';
import 'package:flutter/material.dart';

class CustomerList extends StatefulWidget {
  @override
  _CustomerListState createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: WillPopScope(
                 onWillPop: () async { 
Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AddProdcut()));
                                              return true;

                       },
                      child: Scaffold(appBar: AppBar(title: Text("Customer List"),),body: Column(
        children: [
            _buildBody(context),
        ],
      )),
          ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Signup').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return FittedBox(
                  child: DataTable(columns: [
            DataColumn(label: Text('Email')),
            DataColumn(label: Text('Number')),
            DataColumn(label: Text('password')),
          ], rows: _buildList(context, snapshot.data!.docs)),
        );
      },
    );
  }

  List<DataRow> _buildList(
      BuildContext context, List<DocumentSnapshot> snapshot) {
    return snapshot.map((data) => _buildListItem(context, data)).toList();
  }

  DataRow _buildListItem(BuildContext context, DocumentSnapshot data) {
    return DataRow(cells: [
      DataCell(Text((data.data() as Map)["Email"])),
      DataCell(Text((data.data() as Map)["Number"])),
      DataCell(Text((data.data() as Map)["password"])),

      // DataCell(Text(record.votes.toString())),
      // DataCell(Text(record.rName)),
    ]);
  }
}
