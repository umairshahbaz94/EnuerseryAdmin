import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enersuryadmin/Service/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


class OrderScreenses extends StatefulWidget {
  static String routeName = "/orderscreens";
  @override
  _OrderScreensesState createState() => _OrderScreensesState();
}

class _OrderScreensesState extends State<OrderScreenses> {
  launchURL(String lat, String lng) async {
    final String googleMapslocationUrl =
        "https://www.google.com/maps/search/?api=1&query=${lat},${lng}";

    final String encodedURl = Uri.encodeFull(googleMapslocationUrl);

    // if (await canLaunch(encodedURl)) {
    //   await launch(encodedURl);
    // } else {
    //   print('Could not launch $encodedURl');
    //   throw 'Could not launch $encodedURl';
    // }
  }

  OrderService orderService = new OrderService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          new AppBar(backgroundColor: Colors.blue, title: Text("All Order")),
      body: StreamBuilder<QuerySnapshot>(
        stream: orderService.orders.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (!snapshot.hasData) {
            return Center(child: Text("No Data Found"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: new ListView(
              scrollDirection: Axis.vertical,
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                return new Container(
                  child: Column(children: [
    //                 Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                     children: [
    //                       FlatButton(
    //                         onPressed: () {

    // //                            double long =  (document['long'] as double);
    // // double lat = (document['lat'] as double);
    //                           // Navigator.push(
    //                           //     context,
    //                           //     MaterialPageRoute(
    //                           //         builder: (context) => MapSample(
                                     
    //                           //        long,lat,
    //                           //               // 144.04578,
    //                           //               // -37.7513169,
    //                           //               document['dis'],
    //                           //               document['user'],
    //                           //             )));
    //                         },
    //                         child: Text("Open Map"),
    //                         color: Colors.red,
    //                       ),
    //                       FlatButton(
    //                           onPressed: () {
    //                             document['pickstatus'] == 'false'
    //                                 ? FirebaseFirestore.instance
    //                                     .collection("orders")
    //                                     .doc(document.id)
    //                                     .update({'pickstatus': 'true'})
    //                                 : FirebaseFirestore.instance
    //                                     .collection("orders")
    //                                     .doc(document.id)
    //                                     .update({'pickstatus': 'false'});
    //                             EasyLoading.showSuccess(
    //                                 "opertation Perform Successfully");
    //                           },
    //                           child: Text(document['pickstatus'] == 'false'
    //                               ? "pickup"
    //                               : "cancel"),
    //                           color: document['pickstatus'] == 'false'
    //                               ? Colors.green
    //                               : Colors.lightBlue),
    //                       FlatButton(
    //                         onPressed: () {
    //                           document['dilveredstatus'] == 'false'
    //                               ? FirebaseFirestore.instance
    //                                   .collection("orders")
    //                                   .doc(document.id)
    //                                   .update({'dilveredstatus': 'true'})
    //                               : FirebaseFirestore.instance
    //                                   .collection("orders")
    //                                   .doc(document.id)
    //                                   .update({'dilveredstatus': 'false'});
    //                           EasyLoading.showSuccess(
    //                               "opertation Perform Successfully");
    //                         },
    //                         child: Text(
    //                           document['dilveredstatus'] == 'false'
    //                               ? "Deliverd"
    //                               : "Complete Successfully",
    //                           style: TextStyle(fontSize: 10),
    //                         ),
    //                         color: document['dilveredstatus'] == 'false'
    //                             ? Colors.greenAccent
    //                             : Colors.green,
    //                       ),
    //                     ]),
                    ListTile(
                      trailing: Text(
                        'Total Amount :  ${(document.data() as Map)["totalbill"].toString()}',
                      ),
                      horizontalTitleGap: 0,
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 14,
                        child: Icon(CupertinoIcons.square_list, size: 18),
                      ),
                      title: Expanded(
                        child: Text(
                          'Address:${(document.data() as Map)["Address"].toString()} Number:${(document.data() as Map)["Number"].toString()}   Email:${(document.data() as Map)["user"].toString()}',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    ExpansionTile(
                      title: Text("order Details"),
                      subtitle: Text("View Order details"),
                      children: [
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                (document.data() as Map)["Products"].length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                leading: CircleAvatar(
                                    child: Image.network(
                                        (document.data() as Map)["Products"]
                                            [index]["productimage"])),
                                title: Text((document.data() as Map)["Products"]
                                    [index]["Productname"]),
                                trailing: Text(
                                    'Name :${(document.data() as Map)["Products"][index]["Productname"]}'),
                                subtitle: Expanded(
                                    child: Text(
                                       ' Product Price \$ :${(document.data() as Map)["Products"][index]["ProductPrice"]}*  ${(document.data() as Map)["Products"][index]["qty"]}=\$ ${(document.data() as Map)["Products"][index]["qty"] * (document.data() as Map)["Products"][index]["ProductPrice"]}')),
                              );
                            })
                      ],
                    ),
                  ]),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}


