import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enersuryadmin/ProductManage/Product.dart';
import 'package:flutter/material.dart';

class ServiceList extends StatefulWidget {
  @override
  _ServiceListState createState() => _ServiceListState();
}

class _ServiceListState extends State<ServiceList> {
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
                      child: Scaffold(appBar: AppBar(title: Text("Services List"),),body: Column(
        children: [
            _buildBody(context),
        ],
      )),
          ),
    );
  }
  
  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance.collection('Serviceproducts').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return FittedBox(
                  child: DataTable(columns: [
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Type')),
            DataColumn(label: Text('Category')),
            DataColumn(label: Text('Price')),
            DataColumn(label: Text('Action')),
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
      DataCell(Text((data.data() as Map)["prodcuctname"])),
      DataCell(Text((data.data() as Map)["collectiontype"])),
      DataCell(Text((data.data() as Map)["Subcategory"])),
      DataCell(Text((data.data() as Map)["Price"].toString())),
      DataCell(TextButton(onPressed: () {}, child: const Text("Edit"))),

      // DataCell(Text(record.votes.toString())),
      // DataCell(Text(record.rName)),
    ]);
  }
}
