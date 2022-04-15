import 'dart:math';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:flutter_project/Orientationfiles/Strings.dart';
import 'package:flutter_project/Orientationfiles/orientation.dart';
import 'package:flutter_project/Profile/Profile.dart';
import 'package:flutter_project/Transaction/Transaction.dart';
import '../content.dart';
import 'add_todo_button.dart';
import 'ExtraThings.dart';

//final String username = 'mit@gmail.com';

class homepage extends StatefulWidget {
  static String id = 'Home_page';

  const homepage({Key? key}) : super(key: key);

  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  int _index = 0;
  List userpref = [];

  // static double _width = SizeConfig.widthMultiplier * 13.38;
  // static double _height = SizeConfig.heightMultiplier * 6.11;
  // static Color _color = Colors.grey;

  @override
  Widget build(BuildContext context) {
    Strings.isLoading=false;
    final appbar = [
      AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: const Color.fromRGBO(33, 37, 48, 1.0),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const DataSearch()));
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ],
      ),
      AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: const Color.fromRGBO(33, 37, 48, 1.0),
        title: Center(
          child: Text(
            'Transaction',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: SizeConfig.textMultiplier * 3,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ];
    final Screens = [
      HomePage(),
      TransactionModule(),
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(33, 37, 48, 1.0),
      appBar: appbar[_index],
      body: IndexedStack(
        index: _index,
        children: Screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        showUnselectedLabels: false,
        backgroundColor: const Color.fromRGBO(33, 37, 48, 1.0),
        currentIndex: _index,
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: const Icon(
                Icons.account_balance), // can add account_balance_wallet
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: IconButton(icon: Icon(Icons.account_circle_rounded),onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> Profile()));
            },),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: SafeArea(
        child: Stack(
          children: [
            const Align(
              alignment: Alignment.topCenter,
              child: Image(
                image: AssetImage('assets/images/homepage.png'),
                fit: BoxFit.contain,
              ),
            ),
            ScrollConfiguration(
              behavior: MyCustomScrollBehavior(),
              child: ListView(
                controller: controller,
                scrollDirection: Axis.vertical,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 520, 134, 24),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(14, 7, 29, 7),
                        child: const Text(
                          'Recommendation for you',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius:
                          const BorderRadius.all(Radius.circular(16)),
                          color: const Color.fromRGBO(33, 150, 83, 1.0),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: ScrollConfiguration(
                      behavior: MyCustomScrollBehavior(),
                      child: SizedBox(
                        height: 131.0,
                        //width: 500,
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("UserDetails")
                                .doc(Strings.email)
                                .snapshots(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasError) {
                                return const Text('Something went wrong');
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Text("Loading");
                              }
                              return Container(
                                height: 131,
                                //width: 300,
                                child: ListView.builder(
                                    itemCount: 20,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      List tourpackagedetails = snapshot
                                          .data["Recommendationlist"][index]
                                          .toString()
                                          .split("*");
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Content(
                                                  value: snapshot.data["Recommendationlist"][index], datatype: "Recommendation",),));
                                        },
                                        child: Container(
                                          width: 204.0,
                                          //height: 100,
                                          margin: EdgeInsets.only(left: 10),
                                          padding: EdgeInsets.all(10),
                                          color: Colors.primaries[Random()
                                              .nextInt(Colors.primaries.length)],
                                          child: Center(
                                              child: Text(tourpackagedetails[2])),
                                        ),
                                      );
                                    }),
                              );
                            }),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 24, 134, 24),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(14, 7, 29, 7),
                        child: const Text(
                          'Hotels for you',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius:
                          const BorderRadius.all(Radius.circular(16)),
                          color: const Color.fromRGBO(33, 150, 83, 1.0),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: ScrollConfiguration(
                      behavior: MyCustomScrollBehavior(),
                      child: SizedBox(
                        height: 131.0,
                        //width: 500,
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("UserDetails")
                                .doc(Strings.email)
                                .snapshots(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasError) {
                                return const Text('Something went wrong');
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {  
                                return const Text("Loading");
                              }
                              return Container(
                                height: 131,
                                //width: 300,
                                child: ListView.builder(
                                    itemCount: 4,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      List hoteldetails = snapshot
                                          .data["HotelDetails"][index]
                                          .toString()
                                          .split("*");
                                      List hotelimagesurl =
                                      hoteldetails[10].toString().split("|");
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Content(value: snapshot.data["HotelDetails"][index].toString(), datatype: "RecommendedHotels",)));
                                        },
                                        child: Container(
                                          //width: 204.0,
                                          //height: 100,
                                          margin: EdgeInsets.only(left: 10),
                                          //padding: EdgeInsets.all(10),
                                          color: Colors.primaries[Random()
                                              .nextInt(Colors.primaries.length)],
                                          child: Stack(
                                            children: [
                                              Image.network(
                                                  hotelimagesurl[Random().nextInt(
                                                    hotelimagesurl.length)],
                                                fit: BoxFit.fill,
                                              ),
                                              Padding(
                                                  padding:
                                                  EdgeInsets.only(top: 110),
                                                  child: Text(hoteldetails[0])),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              );
                            }),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 24, 134, 24),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(14, 7, 29, 7),
                        child: const Text(
                          'Top Rating Hotels',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius:
                          const BorderRadius.all(Radius.circular(16)),
                          color: const Color.fromRGBO(33, 150, 83, 1.0),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: ScrollConfiguration(
                      behavior: MyCustomScrollBehavior(),
                      child: SizedBox(
                        height: 131.0,
                        //width: 500,
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("locationDetails")
                                .where("tad_review_rating", isEqualTo: 5)
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return const Text('Something went wrong');
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Text("Loading");
                              }
                              return ListView(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                children: snapshot.data!.docs.map((document) {
                                  List hotelimagesurl = document["image_urls"]
                                      .toString()
                                      .split("|");
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Content(value: document.id, datatype: "Hotel",)));
                                    },
                                    child: Container(
                                      //width: 204.0,
                                      //height: 100,
                                      margin: EdgeInsets.only(left: 10),
                                      //padding: EdgeInsets.all(10),
                                      color: Colors.primaries[Random()
                                          .nextInt(Colors.primaries.length)],
                                      child: Stack(
                                        children: [
                                          (hotelimagesurl[Random().nextInt(hotelimagesurl.length)].toString().length > 5)
                                              ? new Image.network(
                                            hotelimagesurl[Random().nextInt(
                                                hotelimagesurl.length)],
                                            fit: BoxFit.fill,
                                          )
                                              : new Text("no Image Found"),
                                          Padding(
                                              padding: EdgeInsets.only(top: 110),
                                              child: Text(
                                                  document["area"].toString())),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              );
                            }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Align(
              alignment: Alignment.bottomRight,
              child: AddTodoButton(),
            ),
          ],
        ),
      ),
    );
  }
}