import "package:flutter/material.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/LoginPage/loginpage2.dart';
import 'package:flutter_project/Orientationfiles/Strings.dart';
import 'package:flutter_project/Orientationfiles/orientation.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_project/RegistrationPage/Questions.dart';



class RegistrationPage extends StatefulWidget {
  static String id = 'Registration_page';

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();


  late String _email, _pass;

  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputPass = TextEditingController();
  TextEditingController inputConfPass = TextEditingController();
  TextEditingController inputusername = TextEditingController();


  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    inputEmail.dispose();
    inputPass.dispose();
    inputusername.dispose();
    inputConfPass.dispose();
    super.dispose();
  }
  bool hiddenpass = true;
  IconData visi() {
    if (hiddenpass) {
      return Icons.visibility_off;
    } else {
      return Icons.visibility;
    }
  }

  bool hiddenconpass = true;
  IconData visi1() {
    if (hiddenconpass) {
      return Icons.visibility_off;
    } else {
      return Icons.visibility;
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromRGBO(33, 37, 48, 1.0),
        body: SafeArea(
          child: Form(
            key: _formkey,
            child: Padding(
              padding: EdgeInsets.only(left: SizeConfig.heightMultiplier*1.5, right: SizeConfig.widthMultiplier*4.866),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: SizeConfig.heightMultiplier*6.34,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      Strings.createaccount,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: SizeConfig.textMultiplier*3.11,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier*3.89,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Username is Required";
                        }
                      },
                      controller: inputusername,
                      enableSuggestions: true,
                      autocorrect: true,
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        icon: Icon(Icons.account_circle_rounded,color: Colors.white,),
                        //contentPadding: EdgeInsets.only(top: 13),
                        labelText: "Username",
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier*2.44,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      validator: (value) {
                        RegExp emailexp= new RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                        if(value!.isEmpty){
                          return "Email is required";
                        }else
                        if(!emailexp.hasMatch(value)){
                          return "Email is badly formatted. Please enter valid email";
                        }
                      },
                      controller: inputEmail,
                      enableSuggestions: true,
                      autocorrect: true,
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        labelStyle: TextStyle(color: Colors.white),
                        contentPadding: EdgeInsets.only(top: 5),
                        labelText: "Email",
                        icon: Icon(Icons.email, color: Colors.white,),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier*2.44,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: TextFormField(
                      validator: (value){
                        RegExp regex = new RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$');
                        if(value!.isEmpty){
                          return "Enter password";
                        }else
                        if (!regex.hasMatch(value)) {
                          return "Enter valid password & must be 6 character long";
                        }
                      },
                      style: TextStyle(color: Colors.white),
                      controller: inputPass,
                      obscureText: hiddenpass,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        labelStyle: TextStyle(color: Colors.white),
                        icon: Icon(Icons.lock,color: Colors.white,),
                        contentPadding: EdgeInsets.only(top:5),
                        labelText: 'Password',
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              hiddenpass = !hiddenpass;
                            });
                          },
                          child: Icon(
                            visi(),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier*2.44,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: TextFormField(
                      validator: (value){
                        if(value != inputPass.text){
                          return "Not Match";
                        }
                      },
                      style: TextStyle(color: Colors.white),
                      controller: inputConfPass,
                      obscureText: hiddenconpass,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        labelStyle: TextStyle(color: Colors.white),
                        icon: Icon(Icons.verified_user_rounded,color: Colors.white,),
                        contentPadding: EdgeInsets.only(top:5),
                        labelText: 'Confirm Password',
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              hiddenconpass = !hiddenconpass;
                            });
                          },
                          child: Icon(
                            visi1(),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier*6.34,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          onPrimary: Colors.black87,
                          primary: const Color.fromRGBO(45, 156, 219, 1.0),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                        ),
                        child: const Text(Strings.submitbutton),
                        onPressed: () {
                          if(_formkey.currentState!.validate()){
                            _formkey.currentState!.save();
                            if(inputPass.text==inputConfPass.text){
                              FirebaseAuth.instance.createUserWithEmailAndPassword(
                                email: inputEmail.text,
                                password: inputPass.text,
                              ).then((value) {
                                Map<String, dynamic> store = {
                                  "Username": inputusername.text,
                                  "Email": inputEmail.text,
                                  "Address": "NA",
                                  "DateOfBirth": "NA",
                                  "Phone": "NA",
                                  "Travel Coins": 1000000,
                                  "Recommendation": {},
                                  "Recommendationlist": {},
                                  "HotelDetails": {},
                                  "Travel Info" : [],
                                };
                                FirebaseFirestore.instance.collection("UserDetails").doc(inputEmail.text).set(store).then((value){
                                  print("gaya");
                                  Strings.email = inputEmail.text;
                                }).catchError((e){
                                  Fluttertoast.showToast(msg: e!.message);
                                });
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const Questions()));
                              }).catchError((e){
                                Fluttertoast.showToast(msg: e!.message);
                              });
                            }
                          }

                        },
                      ),
                      height: SizeConfig.heightMultiplier * 5.33,
                      width: SizeConfig .widthMultiplier * 79.56,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        borderRadius:
                        const BorderRadius.all(Radius.circular(16)),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier*2.89,
                  ),
                  const Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      Strings.haveaccount,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: TextButton(
                      child: const Text(
                        'Sign In',
                      ),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => loginpage2()));
                      },
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier*2.89,
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );

  }

}

