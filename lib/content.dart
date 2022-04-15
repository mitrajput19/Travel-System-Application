import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'Orientationfiles/Strings.dart';
import 'Orientationfiles/orientation.dart';

class Content extends StatefulWidget {
  final String value;
  final String datatype;
  Content({Key? key, required this.value, required this.datatype})
      : super(key: key);

  @override
  _ContentState createState() => _ContentState(value, datatype);
}

class _ContentState extends State<Content> {
  String value;
  String datatype;
  _ContentState(this.value, this.datatype);
  List transactiondata = [];
  double ?purchaseitemvalue;

  generateRandomNumber() {
    var uuid = Uuid();
    var id = uuid.v4();
    return id;
    //print(id);
  }

//Generate current date
  currentdate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(now);
    return formattedDate;
    //print(formattedDate);
  }

  void purchasepackage() {
    FirebaseFirestore.instance
        .collection("UserDetails")
        .doc(Strings.email)
        .get()
        .then((snapshot) {
      Map<String, dynamic>? store = snapshot.data();
      double value = double.parse(store!['Travel Coins'].toString());
      print(value);



      if (purchaseitemvalue! <= value) {
        FirebaseFirestore.instance
            .collection("UserDetails")
            .doc(Strings.email)
            .update({
          'Travel Coins': value - double.parse(purchaseitemvalue.toString())
        }).then((value) {
          print("hogay");
          transactiondata.add(generateRandomNumber().toString());
          transactiondata.add(currentdate().toString());
          transactiondata.add("-" + purchaseitemvalue.toString());
          transactiondata.add("Purchased");

          FirebaseFirestore.instance
              .collection("UserDetails")
              .doc(Strings.email)
              .get()
              .then((document) {
            List store = document["Travel Info"] as List;
            store.add(transactiondata.join("*"));
            FirebaseFirestore.instance
                .collection("UserDetails")
                .doc(Strings.email)
                .update({"Travel Info": store}).then((value) {
              print("hogaya success");
              //concat = "";
              transactiondata.removeRange(0, transactiondata.length);
            });
          });
        }).catchError((error) {
          Fluttertoast.showToast(msg: error!.message);
        });
        print("Karid");
        Fluttertoast.showToast(msg: "You have purchased this package");
      } else {
        print("paisa nahi hai");
        transactiondata.add(generateRandomNumber().toString());
        transactiondata.add(currentdate().toString());
        transactiondata.add("-" + purchaseitemvalue.toString());
        transactiondata.add("Purchase Failed");
        //String concat = transactiondata.join("*");
        FirebaseFirestore.instance
            .collection("UserDetails")
            .doc(Strings.email)
            .get()
            .then((document) {
          List store = document["Travel Info"] as List;
          store.add(transactiondata.join("*"));
          FirebaseFirestore.instance
              .collection("UserDetails")
              .doc(Strings.email)
              .update({"Travel Info": store}).then((value) {
            print("hogaya fail");
            //concat = "";
            transactiondata.removeRange(0, transactiondata.length);
            Fluttertoast.showToast(
                msg:
                "Insufficient balance in your account... Please add balance (coins) to your account");
          });
        });
      }
    });
  }

  Future<void> buypackagedialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setstate) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              title: const Text('Do you want to buy this tour Package'),
              actions: [
                TextButton(
                  onPressed: () {
                    Fluttertoast.showToast(msg: "Purchase has been cancelled");
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    //Fluttertoast.showToast(msg: "Transaction cancelled");
                    Navigator.of(context).pop();
                  },
                  child: Text("No"),
                ),
                TextButton(
                  onPressed: () {
                    purchasepackage();
                    generateRandomNumber();
                    currentdate();
                    Navigator.of(context).pop();
                  },
                  child: Text("Yes"),
                ),
              ],
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [],
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    if (datatype =="Recommendation") {
      //print(value);
      List pagedata = value.split("*");
      print(pagedata[0]);
      List Destination = pagedata[6].toString().split("|");
      for (var x in Destination) print(x);
      List Sightseeing_Places_Covered = pagedata[18].toString().split("|");
      List Nights = pagedata[7].toString().split('.');
      List HotelDetails = pagedata[10].toString().split("|");
      //print(HotelDetails.length);
      purchaseitemvalue = double.parse(pagedata[17]);
      //print(pagedata[0].toString());
      String store = (pagedata[4].length>10) ? pagedata[4].toString():"No data found";
      return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.heightMultiplier * 4.11,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    Strings.tourheading,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: SizeConfig.textMultiplier * 3.5,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "Name: " + pagedata[2].toString(),
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: SizeConfig.textMultiplier * 2.77,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:
                    EdgeInsets.only(left: SizeConfig.heightMultiplier * 1.11),
                    child: Text(
                      "Price: " + pagedata[17].toString(),
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig.textMultiplier * 1.77,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: SizeConfig.heightMultiplier * 1.11),
                    child: Text(
                      (pagedata[4].length<10) ? "Package Type: "+pagedata[4].toString():"Package Type: No data found",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig.textMultiplier * 1.77,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 2.44,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                  EdgeInsets.only(left: SizeConfig.heightMultiplier * 1.11),
                  child: Text(
                    "Destination you will visit:",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: SizeConfig.textMultiplier * 1.77,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding:
                    EdgeInsets.only(left: SizeConfig.heightMultiplier * 3.11),
                    child: (Destination.length > 1)
                        ? ListView.builder(
                        itemCount: Destination.length,
                        itemBuilder: (context, index) {
                          return Text(
                            Destination[index] +
                                " (" +
                                Nights[index]
                                    .toString()
                                    .trim()
                                    .substring(0, 1) +
                                " Nights)",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                              fontSize: SizeConfig.textMultiplier * 1.77,
                              color: Colors.white,
                            ),
                          );
                        })
                        : Text(
                      "No Data Found",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig.textMultiplier * 1.77,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 2.44,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                  EdgeInsets.only(left: SizeConfig.heightMultiplier * 1.11),
                  child: Text(
                    "Sightseeing Places Covered:",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: SizeConfig.textMultiplier * 1.77,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding:
                    EdgeInsets.only(left: SizeConfig.heightMultiplier * 3.11),
                    child: (Sightseeing_Places_Covered.length > 1)
                        ? ListView.builder(
                        itemCount: Sightseeing_Places_Covered.length,
                        itemBuilder: (context, index) {
                          return Text(
                            Sightseeing_Places_Covered[index],
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                              fontSize: SizeConfig.textMultiplier * 1.77,
                              color: Colors.white,
                            ),
                          );
                        })
                        : Text(
                      "No Data Found",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig.textMultiplier * 1.77,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 2.44,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                  EdgeInsets.only(left: SizeConfig.heightMultiplier * 1.11),
                  child: Text(
                    "Hotel Details",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: SizeConfig.textMultiplier * 1.77,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding:
                    EdgeInsets.only(left: SizeConfig.heightMultiplier * 3.11),
                    child: (HotelDetails.length > 1)
                        ? ListView.builder(
                        itemCount: HotelDetails.length,
                        itemBuilder: (context, index) {
                          return Text(
                            HotelDetails[index].toString().substring(
                                0,
                                (HotelDetails[index].toString().length -
                                    HotelDetails[index]
                                        .toString()
                                        .split(":")[1]
                                        .length)) +
                                " (" +
                                HotelDetails[index].toString().split(":")[1] +
                                " Rating)",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                              fontSize: SizeConfig.textMultiplier * 1.77,
                              color: Colors.white,
                            ),
                          );
                        })
                        : Text(
                      "No Data Found",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig.textMultiplier * 1.77,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 2.44,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ElevatedButton(
                    onPressed: () async {
                      await buypackagedialog(context);
                    },
                    child: const Text(Strings.buypackage),
                    style: ElevatedButton.styleFrom(
                      onPrimary: Colors.black87,
                      primary: const Color.fromRGBO(6, 244, 44, 1.0),
                      minimumSize: Size(SizeConfig.widthMultiplier * 64.93,
                          SizeConfig.heightMultiplier * 5.39),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else if(datatype =="Hotel") {
      print("content page value:" + value);
      return Scaffold(
        body: SafeArea(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("locationDetails")
                .doc(value)
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading");
              }
              List Facilities = snapshot.data["hotel_facilities"].toString().split("|");
              List Room_Facilities = snapshot.data["room_facilities"].toString().split("|");
              List HotelDetails = snapshot.data["tad_stay_review_rating"].toString().split("|");
              return Column(
                children: [
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 4.11,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Hotel Details",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig.textMultiplier * 3.5,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 4.11,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Name: " + snapshot.data["property_name"].toString(),
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig.textMultiplier * 2.77,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2.11,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding:
                            EdgeInsets.only(left: SizeConfig.heightMultiplier * 1.11),
                            child: Text(
                              "Property Type: " + snapshot.data["property_type"].toString(),
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                fontSize: SizeConfig.textMultiplier * 1.77,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding:
                            EdgeInsets.only(right: SizeConfig.heightMultiplier * 1.11),
                            child: Text(
                              "Room Type: " + snapshot.data["room_type"].toString(),
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                fontSize: SizeConfig.textMultiplier * 1.77,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding:
                      EdgeInsets.only(left: SizeConfig.heightMultiplier * 1.11),
                      child: Text(
                        "Rating: " + snapshot.data["tad_review_rating"].toString(),
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          fontSize: SizeConfig.textMultiplier * 1.77,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding:
                      EdgeInsets.only(left: SizeConfig.heightMultiplier * 1.11),
                      child: Text(
                        "Address: " + snapshot.data["address"].toString(),
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          fontSize: SizeConfig.textMultiplier * 1.77,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2.44,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: SizeConfig.heightMultiplier * 1.11),
                      child: Text(
                        "City: " + snapshot.data["city"].toString(),
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          fontSize: SizeConfig.textMultiplier * 1.77,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2.44,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding:
                      EdgeInsets.only(left: SizeConfig.heightMultiplier * 1.11),
                      child: Text(
                        "Hotel Facilities:",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          fontSize: SizeConfig.textMultiplier * 1.77,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding:
                        EdgeInsets.only(left: SizeConfig.heightMultiplier * 3.11),
                        child: (Facilities.length > 1)
                            ? ListView.builder(
                            itemCount: Facilities.length,
                            itemBuilder: (context, index) {
                              return Text(
                                Facilities[index],
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                  fontSize: SizeConfig.textMultiplier * 1.77,
                                  color: Colors.white,
                                ),
                              );
                            })
                            : Text(
                          "No Data Found",
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                            fontSize: SizeConfig.textMultiplier * 1.77,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2.44,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding:
                      EdgeInsets.only(left: SizeConfig.heightMultiplier * 1.11),
                      child: Text(
                        "Room Facilities: ",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          fontSize: SizeConfig.textMultiplier * 1.77,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding:
                        EdgeInsets.only(left: SizeConfig.heightMultiplier * 3.11),
                        child: (Room_Facilities.length > 1)
                            ? ListView.builder(
                            itemCount: Room_Facilities.length,
                            itemBuilder: (context, index) {
                              return Text(
                                Room_Facilities[index].toString().trim(),
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                  fontSize: SizeConfig.textMultiplier * 1.77,
                                  color: Colors.white,
                                ),
                              );
                            })
                            : Text(
                          "No Data Found",
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                            fontSize: SizeConfig.textMultiplier * 1.77,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2.44,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding:
                      EdgeInsets.only(left: SizeConfig.heightMultiplier * 1.11),
                      child: Text(
                        "Hotel Details",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          fontSize: SizeConfig.textMultiplier * 1.77,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding:
                        EdgeInsets.only(left: SizeConfig.heightMultiplier * 3.11),
                        child: (HotelDetails.length > 1)
                            ? ListView.builder(
                            itemCount: HotelDetails.length,
                            itemBuilder: (context, index) {
                              return Text(
                                HotelDetails[index].toString().substring(
                                    0,
                                    (HotelDetails[index].toString().length -
                                        HotelDetails[index]
                                            .toString()
                                            .split("::")[1]
                                            .length)) +
                                    " (" +
                                    HotelDetails[index].toString().split("::")[1] +
                                    " Rating)",
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                  fontSize: SizeConfig.textMultiplier * 1.77,
                                  color: Colors.white,
                                ),
                              );
                            })
                            : Text(
                          "No Data Found",
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                            fontSize: SizeConfig.textMultiplier * 1.77,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Expanded(
                  //   child: Align(
                  //     alignment: Alignment.centerLeft,
                  //     child: Padding(
                  //       padding:
                  //       EdgeInsets.only(left: SizeConfig.heightMultiplier * 3.11),
                  //       child: (snapshot.data["tad_stay_review_rating"].length > 1)
                  //           ? ListView.builder(
                  //           itemCount: snapshot.data["tad_stay_review_rating"].length,
                  //           itemBuilder: (context, index) {
                  //             return Text(
                  //               snapshot.data["tad_stay_review_rating"][index].toString().substring(0,(snapshot.data["tad_stay_review_rating"][index].toString().length-snapshot.data["tad_stay_review_rating"][index].toString().split("::")[1].length-2)) +": ("+ snapshot.data["tad_stay_review_rating"][index].toString().split("::")[1]+" Rating)",
                  //               style: TextStyle(
                  //                 fontFamily: 'Montserrat',
                  //                 fontWeight: FontWeight.w500,
                  //                 fontSize: SizeConfig.textMultiplier * 1.77,
                  //                 color: Colors.white,
                  //               ),
                  //             );
                  //           })
                  //           : Text(
                  //         "No Data Found",
                  //         style: TextStyle(
                  //           fontFamily: 'Montserrat',
                  //           fontWeight: FontWeight.w500,
                  //           fontSize: SizeConfig.textMultiplier * 1.77,
                  //           color: Colors.white,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2.44,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding:
                        EdgeInsets.only(left: SizeConfig.heightMultiplier * 1.11),
                        child: SingleChildScrollView(
                          child: Text(
                            "Hotel Description: " + snapshot.data["hotel_description"],
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                              fontSize: SizeConfig.textMultiplier * 1.77,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );
    } else{
      //print(value);
      List pagedata = value.split("*");
      for(var x in pagedata) print(x);
      List Facilities = pagedata[7].toString().split("|");
      List Sightseeing_Places_Covered = pagedata[23].toString().split("|");
      List Nights = pagedata[7].toString().split('.');
      List HotelDetails = pagedata[30].toString().split("|");
      //print(HotelDetails.length);
      return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.heightMultiplier * 4.11,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "Hotel Details",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: SizeConfig.textMultiplier * 3.5,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "Name: " + pagedata[17].toString(),
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: SizeConfig.textMultiplier * 2.77,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding:
                        EdgeInsets.only(left: SizeConfig.heightMultiplier * 1.11),
                        child: Text(
                          "Property Type: " + pagedata[18].toString(),
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                            fontSize: SizeConfig.textMultiplier * 1.77,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding:
                        EdgeInsets.only(right: SizeConfig.heightMultiplier * 1.11),
                        child: Text(
                          "Room Type: " + pagedata[24].toString(),
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                            fontSize: SizeConfig.textMultiplier * 1.77,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                  EdgeInsets.only(left: SizeConfig.heightMultiplier * 1.11),
                  child: Text(
                    "Rating: " + pagedata[8].toString(),
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: SizeConfig.textMultiplier * 1.77,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                  EdgeInsets.only(left: SizeConfig.heightMultiplier * 1.11),
                  child: Text(
                    "Address: " + pagedata[0].toString(),
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: SizeConfig.textMultiplier * 1.77,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 2.44,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.heightMultiplier * 1.11),
                  child: Text(
                    "City: " + pagedata[2].toString(),
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: SizeConfig.textMultiplier * 1.77,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 2.44,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                  EdgeInsets.only(left: SizeConfig.heightMultiplier * 1.11),
                  child: Text(
                    "Hotel Facilities:",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: SizeConfig.textMultiplier * 1.77,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding:
                    EdgeInsets.only(left: SizeConfig.heightMultiplier * 3.11),
                    child: (Facilities.length > 1)
                        ? ListView.builder(
                        itemCount: Facilities.length,
                        itemBuilder: (context, index) {
                          return Text(
                            Facilities[index],
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                              fontSize: SizeConfig.textMultiplier * 1.77,
                              color: Colors.white,
                            ),
                          );
                        })
                        : Text(
                      "No Data Found",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig.textMultiplier * 1.77,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 2.44,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                  EdgeInsets.only(left: SizeConfig.heightMultiplier * 1.11),
                  child: Text(
                    "Room Facilites: ",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: SizeConfig.textMultiplier * 1.77,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding:
                    EdgeInsets.only(left: SizeConfig.heightMultiplier * 3.11),
                    child: (Sightseeing_Places_Covered.length > 1)
                        ? ListView.builder(
                        itemCount: Sightseeing_Places_Covered.length,
                        itemBuilder: (context, index) {
                          return Text(
                            Sightseeing_Places_Covered[index].toString().trim(),
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                              fontSize: SizeConfig.textMultiplier * 1.77,
                              color: Colors.white,
                            ),
                          );
                        })
                        : Text(
                      "No Data Found",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig.textMultiplier * 1.77,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 2.44,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                  EdgeInsets.only(left: SizeConfig.heightMultiplier * 1.11),
                  child: Text(
                    "Hotel Details",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: SizeConfig.textMultiplier * 1.77,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding:
                    EdgeInsets.only(left: SizeConfig.heightMultiplier * 3.11),
                    child: (HotelDetails.length > 1)
                        ? ListView.builder(
                        itemCount: HotelDetails.length,
                        itemBuilder: (context, index) {
                          return Text(
                            HotelDetails[index].toString().substring(0,(HotelDetails[index].toString().length-HotelDetails[index].toString().split("::")[1].length-2)) +": ("+ HotelDetails[index].toString().split("::")[1]+" Rating)",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                              fontSize: SizeConfig.textMultiplier * 1.77,
                              color: Colors.white,
                            ),
                          );
                        })
                        : Text(
                      "No Data Found",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig.textMultiplier * 1.77,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 2.44,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding:
                    EdgeInsets.only(left: SizeConfig.heightMultiplier * 1.11),
                    child: SingleChildScrollView(
                      child: Text(
                        "Hotel Description: " + pagedata[6],
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          fontSize: SizeConfig.textMultiplier * 1.77,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
