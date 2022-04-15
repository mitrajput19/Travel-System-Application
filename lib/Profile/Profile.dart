import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/HomePage/HomePage.dart';
import 'package:flutter_project/Orientationfiles/Strings.dart';
import 'package:flutter_project/Orientationfiles/orientation.dart';

import 'editprofile.dart';
//void main() => runApp(const Profile());

class Profile extends StatefulWidget {
  static String id = 'Profile_page';
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    Future<bool> exitDilaoge() async {
      return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Log out"),
          content: Text("Do you want to logout from the application?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("No"),
            ),
            TextButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              child: Text("Yes"),
            ),
          ],
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: const Color.fromRGBO(33, 37, 48, 1.0),
            leading: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => homepage()));
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
            title: Text(
              'Profile',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: SizeConfig.textMultiplier * 3.11,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EditProfile()));
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color.fromRGBO(33, 37, 48, 1.0),
          body: SafeArea(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("UserDetails")
                  .doc(Strings.email)
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("");
                }
                return Column(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.account_circle_rounded,
                            color: Colors.white,
                          ),
                          iconSize: SizeConfig.heightMultiplier * 10.56,
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  snapshot.data['Username'].toString(),
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: SizeConfig.textMultiplier * 1.77,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                )),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              snapshot.data['Address'].toString(),
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: SizeConfig.textMultiplier * 1.77,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.widthMultiplier * 5.83,
                            right: SizeConfig.widthMultiplier * 5.83),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Username',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: SizeConfig.textMultiplier * 1.55,
                                color: const Color.fromRGBO(255, 255, 255, 0.5),
                              ),
                            ),
                            Text(
                              snapshot.data['Username'].toString(),
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: SizeConfig.textMultiplier * 1.77,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: SizeConfig.widthMultiplier * 2.676,
                          right: SizeConfig.widthMultiplier * 2.676),
                      child: const Divider(
                        height: 1,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.widthMultiplier * 5.83,
                            right: SizeConfig.widthMultiplier * 5.83),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Email',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: SizeConfig.textMultiplier * 1.55,
                                color: const Color.fromRGBO(255, 255, 255, 0.5),
                              ),
                            ),
                            Text(
                              snapshot.data['Email'].toString(),
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: SizeConfig.textMultiplier * 1.77,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: SizeConfig.widthMultiplier * 2.676,
                          right: SizeConfig.widthMultiplier * 2.676),
                      child: const Divider(
                        height: 1,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.widthMultiplier * 5.83,
                            right: SizeConfig.widthMultiplier * 5.83),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Phone',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: SizeConfig.textMultiplier * 1.55,
                                color: const Color.fromRGBO(255, 255, 255, 0.5),
                              ),
                            ),
                            Text(
                              snapshot.data['Phone'].toString(),
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: SizeConfig.textMultiplier * 1.77,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: SizeConfig.widthMultiplier * 2.676,
                          right: SizeConfig.widthMultiplier * 2.676),
                      child: const Divider(
                        height: 1,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.widthMultiplier * 5.83,
                            right: SizeConfig.widthMultiplier * 5.83),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Date of birth',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: SizeConfig.textMultiplier * 1.55,
                                color: const Color.fromRGBO(255, 255, 255, 0.5),
                              ),
                            ),
                            Text(
                              snapshot.data['DateOfBirth'].toString(),
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: SizeConfig.textMultiplier * 1.77,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: SizeConfig.widthMultiplier * 2.676,
                          right: SizeConfig.widthMultiplier * 2.676),
                      child: const Divider(
                        height: 1,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.widthMultiplier * 5.83,
                            right: SizeConfig.widthMultiplier * 5.83),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Address',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: SizeConfig.textMultiplier * 1.55,
                                color: const Color.fromRGBO(255, 255, 255, 0.5),
                              ),
                            ),
                            Text(
                              snapshot.data['Address'].toString(),
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: SizeConfig.textMultiplier * 1.77,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: SizeConfig.widthMultiplier * 2.676,
                          right: SizeConfig.widthMultiplier * 2.676),
                      child: const Divider(
                        height: 1,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.widthMultiplier * 5.83,
                            right: SizeConfig.widthMultiplier * 5.83),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Travel Coins',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: SizeConfig.textMultiplier * 1.55,
                                color: const Color.fromRGBO(255, 255, 255, 0.5),
                              ),
                            ),
                            Text(
                              snapshot.data['Travel Coins'].toString(),
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: SizeConfig.textMultiplier * 1.77,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: SizeConfig.widthMultiplier * 2.676,
                          right: SizeConfig.widthMultiplier * 2.676),
                      child: const Divider(
                        height: 1,
                        color: Colors.white,
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: SizeConfig.heightMultiplier * 5.33,
                        width: SizeConfig.widthMultiplier * 79.56,
                        child: ElevatedButton(
                          onPressed: () async {
                            FirebaseAuth.instance.signOut().then((value) {
                              exitDilaoge().then((value) {
                                Strings.email = "";
                              });
                            }).catchError((e) {
                              print(e);
                            });
                          },
                          child: const Text('Sign Out'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.black,
                            fixedSize: Size(SizeConfig.widthMultiplier * 79.56,
                                SizeConfig.heightMultiplier * 5.33),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
