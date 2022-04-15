
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import "package:flutter/material.dart";
import 'package:email_auth/email_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/LoginPage/loginpage2.dart';
import 'package:flutter_project/Orientationfiles/Images.dart';
import 'package:flutter_project/Orientationfiles/Strings.dart';
import 'package:flutter_project/Orientationfiles/orientation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
//void main() => runApp( TransactionModule());

class TransactionModule extends StatefulWidget {
  static String id = 'Transaction_page';

  const TransactionModule({Key? key}) : super(key: key);

  @override
  _TransactionModuleState createState() => _TransactionModuleState();
}

class _TransactionModuleState extends State<TransactionModule> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  GlobalKey<FormState> _formkey1 = GlobalKey<FormState>();
  EmailAuth emailAuth = new EmailAuth(sessionName: 'OTP Verification');
  final TextEditingController _getamount = TextEditingController();
  final TextEditingController _getotp = TextEditingController();

  List transactiondata = [];
  @override
  void dispose() {
    _getamount.dispose();
    _getotp.dispose();
    super.dispose();
  }

  void sendOtp() async {
    var res = await emailAuth.sendOtp(recipientMail: Strings.email);
    if (res) {
      print("otp sent");
    }
  }

  void VerifyOtp() async {
    var res = emailAuth.validateOtp(
        recipientMail: Strings.email, userOtp: _getotp.text);
    if (res) {
      FirebaseFirestore.instance
          .collection("UserDetails")
          .doc(Strings.email)
          .get()
          .then((snapshot) {
        Map<String, dynamic>? store = snapshot.data();
        double value = double.parse(store!['Travel Coins'].toString());
        FirebaseFirestore.instance
            .collection("UserDetails")
            .doc(Strings.email)
            .update({'Travel Coins': value + int.parse(_getamount.text)}).then(
                (value) {
          Fluttertoast.showToast(msg: "Successful");
          transactiondata.add(generateRandomNumber().toString());
          transactiondata.add(currentdate().toString());
          transactiondata.add("+" + _getamount.text);
          transactiondata.add("Successful");
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
              
              //concat = "";
              transactiondata.removeRange(0, transactiondata.length);
            });
          });
        }).catchError((error) {
          print("error"+error);
          Fluttertoast.showToast(msg: error!.message);
        });
      }).catchError((error) {
        Fluttertoast.showToast(msg: error!.message);
      });
    } else {
      Fluttertoast.showToast(msg: "Failed");
      transactiondata.add(generateRandomNumber().toString());
      transactiondata.add(currentdate().toString());
      transactiondata.add("+" + _getamount.text);
      transactiondata.add("Failed");
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
            .update({"Travel Info": store}).then((valuverifye) {
          
          transactiondata.removeRange(0, transactiondata.length);
        });
      });
    }
  }

  bool isSendOTPAlert = false;
  bool isVerifyOTPAlert = false;

  //Generate Unique Random id
  generateRandomNumber() {
    var uuid = Uuid();
    var id = uuid.v4();
    return id;
  }

//Generate current date
  currentdate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  Future<void> showInfoDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setstate) {
            return AlertDialog(
              actions: [
                TextButton(
                  onPressed: () {
                    Fluttertoast.showToast(msg: "Transaction cancelled");
                    _getamount.text = "";
                    _getotp.text = "";
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel"),
                ),
              ],
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Form(
                    key: _formkey,
                    child: TextFormField(
                      //key: _formkey,
                      controller: _getamount,
                      validator: (value) {
                        //RegExp amountnotstartfromzero = new RegExp(r'^[1-9][0-9]*$');
                        //RegExp removestartzero = new RegExp(r'^[0-9][1-9]*$');

                        if (value!.isEmpty) {
                          return "Enter Amount";
                        }
                        if (int.parse(value) < 1) {
                          return "Amount 0 isn't allowed to add";
                        }
                        // if (!amountnotstartfromzero.hasMatch(value)) {
                        //   return "Amount 0 isn't allowed to add";
                        // }
                        // if (!removestartzero.hasMatch(value)) {
                        //   return "Remove starting 0 to add amount";
                        // }
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                          hintText: "Amount",
                          suffixIcon: TextButton(
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                print("send button clicked");
                                sendOtp();
                              }
                            },
                            child: Text("Send OTP"),
                          )),
                    ),
                  ),
                  Form(
                    key: _formkey1,
                    child: TextFormField(
                      //key: _formkey1,
                      controller: _getotp,
                      validator: (value) {
                        RegExp otpexp = new RegExp(r'^([0-9]{6})$');
                        if (value!.isEmpty) {
                          return "Enter OTP for verification";
                        }
                        if (!otpexp.hasMatch(value)) {
                          return "OTP must be 6 characters";
                        }
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                          hintText: "OTP",
                          suffixIcon: TextButton(
                            onPressed: () {
                              if (_formkey1.currentState!.validate()) {
                                Navigator.of(context).pop();
                                VerifyOtp();
                              }

                              //Navigator.of(context).pop();
                            },
                            child: Text("Verify OTP"),
                          )),
                    ),
                  )
                ],
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.center,
            child: SizedBox(
              child: const Image(
                image: AssetImage(Images.transactioncoin),
              ),
              height: SizeConfig.heightMultiplier * 14.3061,
              width: SizeConfig.heightMultiplier * 24.81,
            ),
          ),
        ),
        SizedBox(
          height: SizeConfig.heightMultiplier * 1.5,
        ),
        StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("UserDetails")
              .doc(Strings.email)
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if(snapshot.hasError){
              return Text("Has Error");
            }
            if(snapshot.connectionState==ConnectionState.waiting){
              return circularavatar(Alignment.topCenter);
            }
            return Align(
              alignment: Alignment.center,
              child: Text(
                snapshot.data['Travel Coins'].toString(),
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                  fontSize: SizeConfig.textMultiplier * 3.55,
                  color: Colors.white,
                ),
              ),
            );
          },
        ),
        SizedBox(
          height: SizeConfig.heightMultiplier * 1.5,
        ),
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: SizeConfig.heightMultiplier * 5.89,
              width: SizeConfig.widthMultiplier * 48.66,
              child: ElevatedButton(
                onPressed: () async {
                  await showInfoDialog(context);
                },
                child: Text(
                  'Buy Coins',
                  style: TextStyle(
                    fontSize: SizeConfig.textMultiplier * 2.22,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Montserrat',
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.black,
                  primary: const Color.fromRGBO(6, 244, 44, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.fromLTRB(14, 7, 29, 7),
            child: Text(
              'Transaction History',
              style: TextStyle(
                color: Colors.white,
                fontSize: SizeConfig.textMultiplier * 1.77,
                fontFamily: 'Montserrat',
              ),
            ),
            decoration: BoxDecoration(
              border: Border.all(width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              color: const Color.fromRGBO(33, 150, 83, 1.0),
            ),
          ),
        ),
        SizedBox(
          height: SizeConfig.heightMultiplier * 1.66,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 21, right: 21),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'id',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                  fontSize: SizeConfig.textMultiplier * 1.77,
                  color: Colors.white,
                ),
              ),
              Text(
                'Amount',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                  fontSize: SizeConfig.textMultiplier * 1.77,
                  color: Colors.white,
                ),
              ),
              Text(
                'Date',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                  fontSize: SizeConfig.textMultiplier * 1.77,
                  color: Colors.white,
                ),
              ),
              Text(
                'Status',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                  fontSize: SizeConfig.textMultiplier * 1.77,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        const Divider(
          height: 1.5,
          color: Colors.white,
        ),
        Expanded(
          flex: 4,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("UserDetails")
                .doc(Strings.email)
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if(snapshot.hasError){
                return Text("Has Error");
              }
              if(snapshot.connectionState==ConnectionState.waiting){
                return circularavatar(Alignment.topCenter);
              }
              return ListView.builder(
                dragStartBehavior: DragStartBehavior.start,
                  reverse: false,
                  itemCount: snapshot.data["Travel Info"].length,
                  itemBuilder: (context, index) {
                    List transactiondetails = snapshot.data["Travel Info"]
                    [index]
                        .toString()
                        .split("*");
                    return Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 2.669,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Center(
                                  child: Text(
                                    transactiondetails[0],
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w500,
                                      fontSize:
                                      SizeConfig.textMultiplier * 1.77,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right: SizeConfig.widthMultiplier *
                                            7.299),
                                    child: Text(
                                      transactiondetails[2],
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w500,
                                        fontSize:
                                        SizeConfig.textMultiplier * 1.77,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Center(
                                  child: Text(
                                    transactiondetails[1],
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w500,
                                      fontSize:
                                      SizeConfig.textMultiplier * 1.77,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Center(
                                  child: Text(
                                    transactiondetails[3],
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w500,
                                      fontSize:
                                      SizeConfig.textMultiplier * 1.77,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 2.669,
                          ),
                          const Divider(
                            height: 1.5,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    );
                  });
            },
          ),
        ),
      ],
    ));
  }
}
