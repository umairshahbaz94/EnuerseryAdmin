import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderService
{





  CollectionReference orders=FirebaseFirestore.instance.collection("orders");
  saveorder(Map<String,dynamic> data){
  orders.add(

      data,
    );
  }
  saveorderpaypal(Map<String,dynamic> data){
  orders.add(

      data,
    );
  }

  
}