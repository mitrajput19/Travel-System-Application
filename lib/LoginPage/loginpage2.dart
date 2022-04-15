import 'package:csv/csv.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_project/HomePage/HomePage.dart';
import 'package:flutter_project/Orientationfiles/Images.dart';
import 'package:flutter_project/Orientationfiles/Strings.dart';
import 'package:flutter_project/Orientationfiles/Styling.dart';
import 'package:flutter_project/Orientationfiles/orientation.dart';
import 'package:flutter_project/RegistrationPage/registration.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'ForgetPage.dart';

List<List<dynamic>> data = [];
 class loginpage2 extends StatefulWidget {
  static String id = 'Login_page';

  loginpage2({Key? key}) : super(key: key);

  @override
  _loginpage2State createState() => _loginpage2State();
}

class _loginpage2State extends State<loginpage2> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  void getlocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      print('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        print('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      print(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition();
    
  }

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.black87,
    primary: const Color.fromRGBO(45, 156, 219, 1.0),
    minimumSize: Size(
        SizeConfig.widthMultiplier * 64.93, SizeConfig.heightMultiplier * 5.39),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
  );

  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputPass = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    inputEmail.dispose();
    inputPass.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppTheme.appBackgroundColor,
      body: SafeArea(
        bottom: false,
        left: false,
        right: false,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Images.loginimage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: SizeConfig.heightMultiplier * 16.85,
                  ),
                ),
                Column(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Travel System',
                        style: TextStyle(
                          fontSize: SizeConfig.heightMultiplier * 3.14,
                          fontFamily: 'Montserrat',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  'Find your best place here',
                  style: TextStyle(
                    fontSize: SizeConfig.textMultiplier * 1.8,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: SizeConfig.heightMultiplier * 16.85,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: SizeConfig.heightMultiplier * 16.85,
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      child: Form(
                        key: _formkey,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(
                                    SizeConfig.widthMultiplier * 4.86,
                                    SizeConfig.heightMultiplier * 3.7,
                                    SizeConfig.widthMultiplier * 4.86,
                                    0),
                                child: TextFormField(
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
                                    labelStyle: TextStyle(color: Colors.white),
                                    labelText: Strings.Email,
                                    prefixIcon:
                                    Icon(Icons.email, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(
                                    SizeConfig.widthMultiplier * 4.86,
                                    SizeConfig.heightMultiplier * 11.57,
                                    SizeConfig.widthMultiplier * 4.86,
                                    0),
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
                                  controller: inputPass,
                                  obscureText: hiddenpass,
                                  decoration: InputDecoration(
                                    labelStyle: TextStyle(color: Colors.white),
                                    prefixIcon:
                                    Icon(Icons.lock, color: Colors.white),
                                    labelText: Strings.Password,
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        setState(() {
                                          hiddenpass = !hiddenpass;
                                        });
                                      },
                                      child: Icon(
                                        visi(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: SizeConfig.heightMultiplier * 21.67),
                                child: ElevatedButton(
                                  style: raisedButtonStyle,
                                  child: const Text('Login'),
                                  onPressed: () async {

                                    //Navigator.pushNamed(context, homepage.id);
                                    if (_formkey.currentState!.validate()) {
                                      //circularavatar();
                                      //getlocation();
                                      // final SharedPreferences sharedPreference = await SharedPreferences.getInstance();
                                      // sharedPreference.setString('Email', inputEmail.text);
                                      FirebaseAuth.instance
                                          .signInWithEmailAndPassword(
                                          email: inputEmail.text,
                                          password: inputPass.text)
                                          .then((value) async {
                                        setState(() {
                                          Strings.isLoading = true;
                                        });
                                        Strings.email = inputEmail.text;
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => const homepage()));

                                        //Navigator.push(context, MaterialPageRoute(builder: (context) => const homepage()));
                                      }).catchError((error){
                                        Fluttertoast.showToast(msg: error!.message);
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      height: 330,
                      width: 317,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        borderRadius:
                        const BorderRadius.all(Radius.circular(40)),
                        color: Colors.white.withOpacity(0.2),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: TextButton(
                    child: const Text(
                      'Forgotten password?',
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const forgetpassword()));
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: SizeConfig.heightMultiplier * 16.85,
                  ),
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Don't Have An Account?",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: TextButton(
                    child: const Text(
                      'Sign Up',
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()));
                      //Navigator.pushNamed(context, RegistrationPage.id);
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: SizeConfig.heightMultiplier * 16.85,
                  ),
                ),
              ],
            ),
            circularavatar(Alignment.topCenter),
          ],
        ),
      ),
    );
  }
}

Widget circularavatar(Alignment alignment){
  return Align(
    alignment: alignment,
    child: (Strings.isLoading)
        ? Padding(
      padding: EdgeInsets.only(top: SizeConfig.heightMultiplier*29.641),
      child:SizedBox(
          width: SizeConfig.widthMultiplier*12.165,
          height:SizeConfig.heightMultiplier*5.928,
          child: CircularProgressIndicator(
            color: Colors.blue,
            strokeWidth: 3.5,
          )),
    )
        : const Text(''),
  );
}