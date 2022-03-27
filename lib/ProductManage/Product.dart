import 'dart:io';

import 'package:enersuryadmin/AddService.dart';
import 'package:enersuryadmin/Category/Widget/AddCategory.dart';
import 'package:enersuryadmin/CustomerList.dart';
import 'package:enersuryadmin/Login.dart';
import 'package:enersuryadmin/Manageservices.dart';
import 'package:enersuryadmin/Products.dart';
import 'package:enersuryadmin/Provider/Prodcut.dart';
import 'package:enersuryadmin/Service/service.dart';
import 'package:enersuryadmin/Signupo.dart';
import 'package:enersuryadmin/userlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:shop_app/Category/AddCategory.dart';
// import 'package:shop_app/Provider/Productprovider.dart';
// import 'package:shop_app/Service/OrderService.dart';
// import 'package:shop_app/services/AddServices.dart';

class AddProdcut extends StatefulWidget {
  static String routeName = "/AddProdcut";
  @override
  _AddProdcutState createState() => _AddProdcutState();
}

class _AddProdcutState extends State<AddProdcut> {
  final formKey = GlobalKey<FormState>();
  OrderService orderService = new OrderService();

  var temparray = [];

  var dropdownvalueservice;
  var temparraysize = [];

  late File _image;
  bool _load = false;
  var dropdownvalue;
  late String dropdownsubvalue;
  late String _category;

  // getCheckboxItems() {
  //   colors.forEach((key, value) {
  //     if (value == true) {
  //       temparray.add(key);
  //     }
  //   });
  //   temparray.forEach((element) {
  //     print(element);
  //   });
  // }

  // List<String> subchildcategory=["Bamboo Access","Silk Access"];
  late String prodcutname;
  late int price;
  late String productdes;
  TextEditingController category = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Productprovider>(context);
    return DefaultTabController(
      length: 5,
      child: WillPopScope(
        onWillPop: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProdcut()),
          );

          return new Future(() => false);
        },
        child: Scaffold(
          drawer: Drawer(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                ListTile(
                  leading: FlatButton(onPressed: (){

                      Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Productlist()));
                  }, child: Text("All Product"))
                  
                ),
                Divider(color:Colors.red),
                ListTile(
                  leading: FlatButton(onPressed: (){
  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ServiceList()));

                  }, child: Text("All Service"))
                ),
                  Divider(color:Colors.red),
                                 ListTile(
                  leading: FlatButton(onPressed: (){
Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CustomerList()));

                  }
                  
                  , child: Text("All Customer"))
                ),
                  Divider(color:Colors.red),
                                 ListTile(
                  leading: FlatButton(onPressed: (

                    
                  ){
                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UserList()));


                  }, child: Text("All Gardner"))
                ),
                  Divider(color:Colors.red),
              ]),
            ),
          ),
          appBar: AppBar(
            bottom: TabBar(
              isScrollable: true,
              labelColor: Colors.red,
              indicatorWeight: 10,
              tabs: [
                Tab(
                  child: Text("Add Product"),
                ),
                Tab(child: Text("Add Service")),
                Tab(child: Text("Add Service Name")),
                Tab(child: Text("Add Categort Name")),
                Tab(child: Text("New Gardner Add")),
              ],
            ),
            actions: [FlatButton(onPressed: () {
              
            
    
Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LoginScreen1()));
                                              

                      


            }, child: Text("LOGOUT"))],
          ),
          body: TabBarView(
            children: [
              ListView(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Product name";
                            }
                            setState(() {
                              prodcutname = value;
                            });
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "Product name",
                              labelStyle: TextStyle(color: Colors.grey),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey))),
                        ),
                        Divider(),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Product Price";
                            }
                            setState(() {
                              price = int.parse(value);
                            });
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "Product Price",
                              labelStyle: TextStyle(color: Colors.grey),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey))),
                        ),
                        Divider(),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Product Description";
                            }
                            
                            setState(() {
                              productdes = value!;
                            });
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "Product Description",
                              labelStyle: TextStyle(color: Colors.grey),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey))),
                        ),
                        Divider(),
                        Column(children: [
                          new StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('Category')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData)
                                  return const Center(
                                    child: const CupertinoActivityIndicator(),
                                  );
                                var length = snapshot.data!.docs.length;

                                return new Container(
                                  padding: EdgeInsets.only(bottom: 16.0),
                                  child: new Row(
                                    children: <Widget>[
                                      new Expanded(
                                          flex: 2,
                                          child: new Container(
                                            padding: EdgeInsets.fromLTRB(
                                                12.0, 10.0, 10.0, 10.0),
                                            child: new Text("Category"),
                                          )),
                                      new Expanded(
                                        flex: 4,
                                        child: new InputDecorator(
                                          decoration: const InputDecoration(
                                            //labelText: 'Activity',
                                            hintText: 'Choose an category',
                                            hintStyle: TextStyle(
                                              fontSize: 16.0,
                                              fontFamily: "OpenSans",
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          child: new DropdownButton(
                                            value: dropdownvalue,
                                            hint: Text("select Category"),
                                            isDense: true,
                                            onChanged: (newValue) async {
                                              setState(() {
                                                dropdownvalue =
                                                    newValue.toString();
                                                print(newValue);
                                              });
                                            },
                                            items: snapshot.data!.docs.map(
                                                (DocumentSnapshot document) {
                                              print(document["Name"]);
                                              return new DropdownMenuItem(
                                                  value: document["Name"],
                                                  child: new Container(
                                                    decoration: new BoxDecoration(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(5.0)),

                                                    //color: primaryColor,
                                                    child: new Text(
                                                        document["Name"]),
                                                  ));
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              })
                        ]),
                        // Text("Select Size"),
                        // Column(
                        //   children: sizes.keys.map((String keys) {
                        //     return new CheckboxListTile(
                        //       title: new Text(keys),
                        //       value: sizes[keys],
                        //       activeColor: Colors.pink,
                        //       checkColor: Colors.white,
                        //       onChanged: (values) async {
                        //         setState(() {
                        //           sizes[keys] = values!;
                        //           if (values) {
                        //             temparraysize.add(keys);
                        //           } else {
                        //             temparraysize.remove(keys);
                        //           }
                        //         });
                        //       },
                        //     );
                        //   }).toList(),
                        // ),
                        InkWell(
                          onTap: () {
                            provider.getImage().then((value) {
                              setState(() {
                                _load = true;
                                _image = value;
                              });
                            });
                          },
                          child: SizedBox(
                            width: 150,
                            height: 150,
                            child: Card(
                              child: Center(
                                child: _load == true
                                    ? Image.file(_image)
                                    : Text("Select Image"),
                              ),
                            ),
                          ),
                        ),

                        Divider(),

                        FlatButton.icon(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                EasyLoading.show(status: 'loading...');
                                EasyLoading.dismiss();
                                if (_image != null) {
                                  EasyLoading.show(status: "Processing Save");
                                  provider
                                      .imageupload(_image.path)
                                      .then((value) {
                                    if (value != null) {
                                      provider
                                          .saveprodcut(
                                        prodcutname,
                                        productdes,
                                        dropdownvalue,
                                        price,
                                      )
                                          .then((value) {
                                        if (value) {
                                          EasyLoading.showSuccess(
                                              "Product Save Successfully");

                                          formKey.currentState!.reset();
                                          setState(() {
                                            _load = false;
                                          });
                                        } else {
                                          EasyLoading.showError("Fail");
                                        }
                                      });
                                    } else {
                                      provider.alertDialog(
                                          context,
                                          "Image  upload",
                                          "Fail to upload image");
                                    }
                                  });
                                } else {
                                  AlertDialog alert = AlertDialog(
                                    title: Text("Prodcut image upload faill"),
                                    content: Text(
                                        "Please Select image and try again ."),
                                    actions: [],
                                  );
                                  alert;
                                }
                              }
                            },
                            icon: Icon(Icons.save),
                            label: Text("Save"))
                      ],
                    ),
                  ),
                ),
              ]),
              ListView(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Product name";
                            }
                            setState(() {
                              prodcutname = value;
                            });
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "Product name",
                              labelStyle: TextStyle(color: Colors.grey),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey))),
                        ),
                        Divider(),
                        TextFormField(
                          maxLength: 5,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Product Price";
                            }
                            setState(() {
                              price = int.parse(value);
                            });
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "Product Price",
                              labelStyle: TextStyle(color: Colors.grey),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey))),
                        ),
                        Divider(),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Product Description";
                            }
                            setState(() {
                              productdes = value!;
                            });
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "Product Description",
                              labelStyle: TextStyle(color: Colors.grey),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey))),
                        ),
                        Divider(),
                        Column(children: [
                          new StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('Service')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData)
                                  return const Center(
                                    child: const CupertinoActivityIndicator(),
                                  );
                                var length = snapshot.data!.docs.length;

                                return new Container(
                                  padding: EdgeInsets.only(bottom: 16.0),
                                  child: new Row(
                                    children: <Widget>[
                                      new Expanded(
                                          flex: 2,
                                          child: new Container(
                                            padding: EdgeInsets.fromLTRB(
                                                12.0, 10.0, 10.0, 10.0),
                                            child: new Text("Service"),
                                          )),
                                      new Expanded(
                                        flex: 4,
                                        child: new InputDecorator(
                                          decoration: const InputDecoration(
                                            //labelText: 'Activity',
                                            hintText: 'Choose an Service',
                                            hintStyle: TextStyle(
                                              fontSize: 16.0,
                                              fontFamily: "OpenSans",
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          child: new DropdownButton(
                                            value: dropdownvalueservice,
                                            hint: Text("select Service"),
                                            isDense: true,
                                            onChanged: (newValue) async {
                                              setState(() {
                                                dropdownvalueservice =
                                                    newValue.toString();
                                                print(newValue);
                                              });
                                            },
                                            items: snapshot.data!.docs.map(
                                                (DocumentSnapshot document) {
                                              print(document["Name"]);
                                              return new DropdownMenuItem(
                                                  value: document["Name"],
                                                  child: new Container(
                                                    decoration: new BoxDecoration(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(5.0)),

                                                    //color: primaryColor,
                                                    child: new Text(
                                                        document["Name"]),
                                                  ));
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              })
                        ]),
                        // Text("Select Size"),
                        // Column(
                        //   children: sizes.keys.map((String keys) {
                        //     return new CheckboxListTile(
                        //       title: new Text(keys),
                        //       value: sizes[keys],
                        //       activeColor: Colors.pink,
                        //       checkColor: Colors.white,
                        //       onChanged: (values) async {
                        //         setState(() {
                        //           sizes[keys] = values!;
                        //           if (values) {
                        //             temparraysize.add(keys);
                        //           } else {
                        //             temparraysize.remove(keys);
                        //           }
                        //         });
                        //       },
                        //     );
                        //   }).toList(),
                        // ),
                        InkWell(
                          onTap: () {
                            provider.getImage().then((value) {
                              setState(() {
                                _load = true;
                                _image = value;
                              });
                            });
                          },
                          child: SizedBox(
                            width: 150,
                            height: 150,
                            child: Card(
                              child: Center(
                                child: _load == true
                                    ? Image.file(_image)
                                    : Text("Select Image"),
                              ),
                            ),
                          ),
                        ),

                        Divider(),

                        FlatButton.icon(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                EasyLoading.show(status: 'loading...');
                                EasyLoading.dismiss();
                                if (_image != null) {
                                  EasyLoading.show(status: "Processing Save");
                                  provider
                                      .imageupload(_image.path)
                                      .then((value) {
                                    if (value != null) {
                                      provider
                                          .saveservice(
                                        prodcutname,
                                        productdes,
                                        dropdownvalueservice,
                                        price,
                                      )
                                          .then((value) {
                                        if (value) {
                                          EasyLoading.showSuccess(
                                              "Product Save Successfully");

                                          formKey.currentState!.reset();
                                        } else {
                                          EasyLoading.showError("Fail");
                                        }
                                      });
                                    } else {
                                      provider.alertDialog(
                                          context,
                                          "Image  upload",
                                          "Fail to upload image");
                                    }
                                  });
                                } else {
                                  AlertDialog alert = AlertDialog(
                                    title: Text("Prodcut image upload faill"),
                                    content: Text(
                                        "Please Select image and try again ."),
                                    actions: [],
                                  );
                                  alert;
                                }
                              }
                            },
                            icon: Icon(Icons.save),
                            label: Text("Save"))
                      ],
                    ),
                  ),
                ),
              ]),
              AddService(),
              TodoList(),
              Mysignuppage(),
            ],
          ),
        ),
      ),
    );
  }
}
