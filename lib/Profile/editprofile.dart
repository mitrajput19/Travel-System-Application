import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:flutter_project/Orientationfiles/Strings.dart';
import 'package:flutter_project/Orientationfiles/orientation.dart';

import 'Profile.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController Usernamecontroller = TextEditingController();
  TextEditingController Emailcontroller = TextEditingController();
  TextEditingController Addresscontroller = TextEditingController();
  TextEditingController DateOfBirthcontroller = TextEditingController();
  TextEditingController Phonecontroller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
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
                      MaterialPageRoute(builder: (context) => Profile()));
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
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
                  Usernamecontroller.text = snapshot.data['Username'].toString();
                  Emailcontroller.text = snapshot.data['Email'].toString();
                  Addresscontroller.text = snapshot.data['Address'].toString();
                  DateOfBirthcontroller.text =
                      snapshot.data['DateOfBirth'].toString();
                  Phonecontroller.text = snapshot.data['Phone'].toString();

                  return Column(children: [
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2.11,
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        Strings.updateprofile,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          fontSize: SizeConfig.textMultiplier * 3.5,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 5.34,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.widthMultiplier * 3.649),
                        child: Text(
                          "Username",
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                            fontSize: SizeConfig.textMultiplier * 1.8,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding:
                        EdgeInsets.all(SizeConfig.widthMultiplier * 3.649),
                        child: Container(
                          child: TextField(
                            controller: Usernamecontroller,
                            enableSuggestions: true,
                            autocorrect: true,
                            decoration: InputDecoration(
                              //labelText: snapshot.data['Username'].toString(),
                              //hintText: Strings.username,
                            ),
                          ),
                          padding: EdgeInsets.only(
                              left: SizeConfig.widthMultiplier * 1.866,
                              right: SizeConfig.widthMultiplier * 3.866),
                          // height: SizeConfig.heightMultiplier * 5.33,
                          // width: SizeConfig.widthMultiplier * 79.56,
                          decoration: BoxDecoration(
                            //border: Border.all(width: 1),
                            borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1.5,
                    ),
                    // Align(
                    //   alignment: Alignment.topLeft,
                    //   child: Padding(
                    //     padding: EdgeInsets.only(
                    //         left: SizeConfig.widthMultiplier * 3.649),
                    //     child: Text(
                    //       "Email",
                    //       style: TextStyle(
                    //         fontFamily: 'Montserrat',
                    //         fontWeight: FontWeight.w500,
                    //         fontSize: SizeConfig.textMultiplier * 1.8,
                    //         color: Colors.white,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Align(
                    //   alignment: Alignment.topCenter,
                    //   child: Padding(
                    //     padding:
                    //         EdgeInsets.all(SizeConfig.widthMultiplier * 3.649),
                    //     child: Container(
                    //       child: TextField(
                    //         controller: Emailcontroller,
                    //         enableSuggestions: true,
                    //         autocorrect: true,
                    //         decoration: InputDecoration(
                    //             //labelText: snapshot.data['Email'].toString(),
                    //             //hintText: Strings.Email,
                    //             ),
                    //       ),
                    //       padding: EdgeInsets.only(
                    //           left: SizeConfig.widthMultiplier * 1.866,
                    //           right: SizeConfig.widthMultiplier * 3.866),
                    //       // height: SizeConfig.heightMultiplier * 5.33,
                    //       // width: SizeConfig.widthMultiplier * 79.56,
                    //       decoration: BoxDecoration(
                    //         //border: Border.all(width: 1),
                    //         borderRadius:
                    //             const BorderRadius.all(Radius.circular(8)),
                    //         color: Colors.white,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: SizeConfig.heightMultiplier * 1.5,
                    // ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.widthMultiplier * 3.649),
                        child: Text(
                          "Address",
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                            fontSize: SizeConfig.textMultiplier * 1.8,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding:
                        EdgeInsets.all(SizeConfig.widthMultiplier * 3.649),
                        child: Container(
                          child: TextField(
                            controller: Addresscontroller,
                            enableSuggestions: true,
                            autocorrect: true,
                            decoration: InputDecoration(
                              //labelText: snapshot.data['Email'].toString(),
                              //hintText: Strings.Email,
                            ),
                          ),
                          padding: EdgeInsets.only(
                              left: SizeConfig.widthMultiplier * 1.866,
                              right: SizeConfig.widthMultiplier * 3.866),
                          // height: SizeConfig.heightMultiplier * 5.33,
                          // width: SizeConfig.widthMultiplier * 79.56,
                          decoration: BoxDecoration(
                            //border: Border.all(width: 1),
                            borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1.5,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.widthMultiplier * 3.649),
                        child: Text(
                          "Phone",
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                            fontSize: SizeConfig.textMultiplier * 1.8,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding:
                        EdgeInsets.all(SizeConfig.widthMultiplier * 3.649),
                        child: Container(
                          child: TextField(
                            controller: Phonecontroller,
                            enableSuggestions: true,
                            autocorrect: true,
                            decoration: InputDecoration(
                              //labelText: snapshot.data['Email'].toString(),
                              //hintText: Strings.Email,
                            ),
                          ),
                          padding: EdgeInsets.only(
                              left: SizeConfig.widthMultiplier * 1.866,
                              right: SizeConfig.widthMultiplier * 3.866),
                          // height: SizeConfig.heightMultiplier * 5.33,
                          // width: SizeConfig.widthMultiplier * 79.56,
                          decoration: BoxDecoration(
                            //border: Border.all(width: 1),
                            borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1.5,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.widthMultiplier * 3.649),
                        child: Text(
                          "Date Of Birth (dd/MM/yyyy)",
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                            fontSize: SizeConfig.textMultiplier * 1.8,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.all(SizeConfig.widthMultiplier * 3.649),
                        child: Container(
                          child: TextField(
                            controller: DateOfBirthcontroller,
                            enableSuggestions: true,
                            autocorrect: true,
                            decoration: InputDecoration(
                              //labelText: snapshot.data['DateOfBirth'].toString(),
                            ),
                          ),
                          padding: EdgeInsets.only(
                              left: SizeConfig.widthMultiplier * 1.866,
                              right: SizeConfig.widthMultiplier * 3.866),
                          // height: SizeConfig.heightMultiplier * 5.33,
                          // width: SizeConfig.widthMultiplier * 79.56,
                          decoration: BoxDecoration(
                            //border: Border.all(width: 1),
                            borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1,
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.all(SizeConfig.widthMultiplier * 3.649),
                        child: Container(
                          height: SizeConfig.heightMultiplier*5.335,
                          width: SizeConfig.widthMultiplier * 60.827,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              onPrimary: Colors.black87,
                              primary: const Color.fromRGBO(45, 156, 219, 1.0),
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(8)),
                              ),
                            ),
                            child: const Text("Update Profile"),
                            onPressed: () {
                              var db = FirebaseFirestore.instance
                                  .collection("UserDetails");
                              Map<String, dynamic> mydata = {
                                "Username": Usernamecontroller.text,
                                "Email": Emailcontroller.text,
                                "Address": Addresscontroller.text,
                                "DateOfBirth": DateOfBirthcontroller.text,
                                "Phone": Phonecontroller.text
                              };
                              db.doc(Strings.email).update(mydata);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Profile(),
                                ),
                              );
                              //Navigator.pushNamed(context, Profile.id);
                            },
                          ),
                          // height: SizeConfig.heightMultiplier * 5.33,
                          // width: SizeConfig.widthMultiplier * 79.56,
                          // decoration: BoxDecoration(
                          //   //border: Border.all(width: 1),
                          //   borderRadius:
                          //       const BorderRadius.all(Radius.circular(8)),
                          //   color: Colors.white,
                          // ),
                        ),
                      ),
                    ),
                  ]);
                },
              ),
            ),
          )),
    );
  }
}
