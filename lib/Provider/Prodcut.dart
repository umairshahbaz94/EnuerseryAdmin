import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class Productprovider with ChangeNotifier {
  late BuildContext context;
  late String prodcuturl;
  late String number;
  late String addresss;
  late String nearlocation;
  late File _image;
  User? user = FirebaseAuth.instance.currentUser;
  final picker = ImagePicker();
  Future<File> getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      notifyListeners();
    } else {
      print('No image selected.');
      notifyListeners();
    }
    return _image;
  }

  alertDialog(context, titel, content) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: titel,
            content: content,
            actions: [
              CupertinoDialogAction(
                child: GestureDetector(
                    onTap: () {
                      Navigator.of(context);
                    },
                    child: Text("ok")),
              )
            ],
          );
        });
  }

  Future<String> imageupload(filepath) async {
    File file = File(filepath);
    var timestamp = DateTime.now().microsecondsSinceEpoch;
    FirebaseStorage _storage = FirebaseStorage.instance;
    try {
      await _storage.ref("productimage/$timestamp").putFile(file);
    } on FirebaseException catch (e) {
      e.toString();
    }
    String downloadurl =
        await _storage.ref("productimage/$timestamp").getDownloadURL();
    this.prodcuturl = downloadurl;
    notifyListeners();
    return prodcuturl;
  }

  Future<bool> saveprodcut(prodcutname, des, dropdownsubvalue, price) async {
    var timestamp = DateTime.now().microsecondsSinceEpoch;
    try {
      CollectionReference _prodcuts =
          FirebaseFirestore.instance.collection('products');
      _prodcuts.doc(timestamp.toString()).set({
        'prodcuctname': prodcutname,
        'Prodcutdescription': des,
        "productimage": prodcuturl,
        "Subcategory": dropdownsubvalue,
        "collectiontype": "Featured Product",
        "Price": price,
        "ProdcutId": timestamp.toString(),
        // "Colors":  p,
        // "Sizes":size,
      }).then((value) {return true;});
      return true;
     
    } catch (e) {
      return false;
    }
  }
    Future<bool> saveservice(prodcutname, des, dropdownsubvalue, price) async {
    var timestamp = DateTime.now().microsecondsSinceEpoch;
    try {
      CollectionReference _prodcuts =
          FirebaseFirestore.instance.collection('Serviceproducts');
      _prodcuts.doc(timestamp.toString()).set({
        'prodcuctname': prodcutname,
        'Prodcutdescription': des,
        "productimage": prodcuturl,
        "Subcategory": dropdownsubvalue,
        "collectiontype": "Featured Product",
        "Price": price,
        "ProdcutId": timestamp.toString(),
        // "Colors":  p,
        // "Sizes":size,
      }).then((value) {return true;});
      return true;
     
    } catch (e) {
      return false;
    }
  }

  saveuseraddress(address, number, nearlocation) async {
    try {
      // CollectionReference _prodcuts =await
      //     FirebaseFirestore.instance.collection('CustomerAddress');
      // _prodcuts.doc(user.uid).set({
      //   'Address': address,
      //   'Number': number,
      //   'nearlocation': nearlocation,

      statusChaage();
      // });
      this.number = number;
      notifyListeners();
      this.addresss = address;
      notifyListeners();
      this.nearlocation = nearlocation;
      notifyListeners();
    } catch (e) {}
    return null;
  }

  saveuseraddressprovider(address, number, nearlocation) async {
    try {
      this.number = number;
      notifyListeners();
      this.addresss = address;
      notifyListeners();
      this.nearlocation = nearlocation;
      notifyListeners();
    } catch (e) {}
    return null;
  }

  statusChaage() async {
    CollectionReference cart = FirebaseFirestore.instance.collection('cart');

    try {
      cart.doc(user!.uid).update({"status": "True"}).then((value) => cart
              .doc(user!.uid)
              .collection("Products")
              .get()
              .then((QuerySnapshot snapshot) {
            for (DocumentSnapshot ds in snapshot.docs) {
              ds.reference.delete();
            }
          }));
    } catch (e) {}
    return null;
  }
}
