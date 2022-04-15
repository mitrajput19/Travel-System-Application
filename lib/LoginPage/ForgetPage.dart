import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:flutter_project/Orientationfiles/Strings.dart';
import 'package:flutter_project/Orientationfiles/orientation.dart';
import 'package:fluttertoast/fluttertoast.dart';

class forgetpassword extends StatefulWidget {
  const forgetpassword({Key? key}) : super(key: key);

  @override
  _forgetpasswordState createState() => _forgetpasswordState();
}

class _forgetpasswordState extends State<forgetpassword> {
  TextEditingController forgotfield=TextEditingController();
  @override
  void dispose()
  {
    forgotfield.dispose();
    super.dispose();
  }
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromRGBO(33, 37, 48, 1.0),
        body: SafeArea(
          child: Form(
            key:_formkey,
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.heightMultiplier * 10.34,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    Strings.forgotpassword,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.textMultiplier*3.11,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 10.34,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding:EdgeInsets.fromLTRB(SizeConfig.widthMultiplier*3, 0, SizeConfig.widthMultiplier*8, 0),
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
                      controller: forgotfield,
                      //obscureText: true,
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        labelStyle: TextStyle(color: Colors.white),
                        icon: Icon(Icons.email,color: Colors.white,),
                        contentPadding: EdgeInsets.only(top:5),
                        labelText: 'Registered Email',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 1.34,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: SizeConfig.heightMultiplier * 2.67),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        onPrimary: Colors.black,
                        fixedSize: Size(SizeConfig.widthMultiplier*79.56, SizeConfig.heightMultiplier*5.33),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text('Reset Password'),
                      onPressed: () {
                        resetPassword();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    
  }
  void resetPassword() async{
    if(_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      showDialog(context: context,
        barrierDismissible: false,
        builder: (context) =>
            Center(
                child: CircularProgressIndicator()
            ),
      );

      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(
            email: forgotfield.text);
        //Utils.showSnackBar("Password Reset Email Sent");
        Fluttertoast.showToast(msg: "Password reset email sent",
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
      on FirebaseAuthException catch (e) {
        Fluttertoast.showToast(msg: "This email is not registered",
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Navigator.of(context).pop();
      }
    }
  }
}
