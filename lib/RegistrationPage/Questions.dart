import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_project/HomePage/HomePage.dart';
import 'package:flutter_project/LoginPage/loginpage2.dart';
import 'package:flutter_project/Orientationfiles/Strings.dart';
import 'package:flutter_project/Orientationfiles/orientation.dart';

class Questions extends StatefulWidget {
  const Questions({Key? key}) : super(key: key);

  @override
  _QuestionsState createState() => _QuestionsState();
}
enum radiobuttonitems {Solo,Group}
class _QuestionsState extends State<Questions> {

  List<List<dynamic>> data = [];
  List<List<dynamic>> data1 = [];
  List recommendation = [];
  List hotellist = [];


  TextEditingController noofdays = TextEditingController();
  TextEditingController bucketlist = TextEditingController();

  List store = [];

  double rating = 0;
  RangeValues SelectedRange = const RangeValues(0.2, 0.8);
  String colorGroupValue = 'blue';
  final ScrollController controller = ScrollController();
  bool ischecked1=false;
  bool ischecked2=false;
  bool ischecked3=false;
  bool ischecked4=false;
  String dropdownvalue = 'Darjeeling';

  // List of items in our dropdown menu
  var items = [
    'Darjeeling',
    'Manali',
    'Udaipur',
    'Goa',
    'Shimla',
  ];

  radiobuttonitems? _character =radiobuttonitems.Solo;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(33, 37, 48, 1.0),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: SizeConfig.heightMultiplier*4.11,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'To Know You Better',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig.textMultiplier*3.5,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier*2.44,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: SizeConfig.heightMultiplier*1.11),
                      child: Text(
                        Strings.FirstQuestion,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          fontSize: SizeConfig.textMultiplier*1.77,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(left: SizeConfig.heightMultiplier*1.11),
                      child: RangeSlider(
                        values: SelectedRange,
                        min: 0,
                        max: 100000,
                        divisions: 10,
                        labels: RangeLabels(
                          SelectedRange.start.round().toString(),
                          SelectedRange.end.round().toString(),
                        ),
                        onChanged: (RangeValues newRange) {
                          setState(() {
                            SelectedRange = newRange;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier*2.44,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: SizeConfig.heightMultiplier*1.11),
                      child: Text(
                        Strings.SecondQuestion,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          fontSize: SizeConfig.textMultiplier*1.77,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: SizeConfig.heightMultiplier*3),
                      child: DropdownButton(
                        value: dropdownvalue,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                            
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier*2.44,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: SizeConfig.heightMultiplier*1.11),
                      child: Text(
                        Strings.ThirdQuestion,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          fontSize: SizeConfig.textMultiplier*1.77,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        CheckboxListTile(
                          title: const Text("Summer",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          checkColor: Colors.white,
                          //secondary: Icon(Icons.access_alarm),
                          controlAffinity: ListTileControlAffinity.leading,

                          value: ischecked1,
                          onChanged: (bool? value) {
                            setState(() {
                              ischecked1 = value!;
                              
                            });
                          },
                        ),
                        CheckboxListTile(
                          title: const Text("Rainy",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          checkColor: Colors.white,
                          //secondary: Icon(Icons.access_alarm),
                          controlAffinity: ListTileControlAffinity.leading,
                          value: ischecked2,
                          onChanged: (bool? value) {
                            setState(() {
                              ischecked2 = value!;
                            });
                          },
                        ),
                        CheckboxListTile(
                          title: const Text("Monsoon",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          checkColor: Colors.white,
                          //secondary: Icon(Icons.access_alarm),
                          controlAffinity: ListTileControlAffinity.leading,

                          value: ischecked3,
                          onChanged: (bool? value) {
                            setState(() {
                              ischecked3= value!;
                            });
                          },
                        ),
                        CheckboxListTile(
                          title: const Text("Winter",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          checkColor: Colors.white,
                          //secondary: Icon(Icons.access_alarm),
                          controlAffinity: ListTileControlAffinity.leading,

                          value: ischecked4,
                          onChanged: (bool? value) {
                            setState(() {
                              ischecked4= value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier*2.44,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: SizeConfig.heightMultiplier*1.11),
                      child: Text(
                        Strings.FourthQuestion,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          fontSize: SizeConfig.textMultiplier*1.77,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: SizeConfig.heightMultiplier*3,right: SizeConfig.heightMultiplier*1.11),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: noofdays,
                        decoration: InputDecoration(
                          hintText: 'Number of days',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier*2.44,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: SizeConfig.heightMultiplier*1.11),
                      child: Text(
                        Strings.FifthQuestion,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          fontSize: SizeConfig.textMultiplier*1.77,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: SizeConfig.widthMultiplier*3),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text("Solo"),
                            leading: Radio<radiobuttonitems>(
                              value: radiobuttonitems.Solo,
                              groupValue: _character,
                              onChanged: (radiobuttonitems? value) {
                                setState(() {
                                  _character=value;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: Text("Group"),
                            leading: Radio<radiobuttonitems>(
                              value: radiobuttonitems.Group,
                              groupValue: _character,
                              onChanged: (radiobuttonitems? value) {
                                setState(() {
                                  _character=value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier*2.44,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: SizeConfig.heightMultiplier*1.11),
                      child: Text(
                        Strings.SixthQuestion,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          fontSize: SizeConfig.textMultiplier*1.77,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: SizeConfig.heightMultiplier*3,right: SizeConfig.heightMultiplier*1.11),
                      child: TextField(
                        controller: bucketlist,
                        decoration: InputDecoration(
                          hintText: 'Enter here..',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier*5,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: ElevatedButton(
                      onPressed: () async{
                        setState(() {
                          Strings.isLoading =true;
                        });
                        store.add(SelectedRange.start.round().toString());
                        store.add(SelectedRange.end.round().toString());
                        store.add(dropdownvalue);
                        if(ischecked1){
                          store.add("Summer");
                        }else if(ischecked2){
                          store.add("Rainy");
                        }else if(ischecked3){
                          store.add("Monsoon");
                        }else if(ischecked4){
                          store.add("Rainy");
                        }
                        store.add(noofdays.text);
                        store.add(_character);
                        store.add(bucketlist.text);
                        final mydata = await rootBundle.loadString("assets/makemytrip.csv");
                        final mydata1 = await rootBundle.loadString("assets/try1.csv");
                      
                        List<List<dynamic>> csvtable = const CsvToListConverter().convert(mydata);
                        List<List<dynamic>> csvtable1 = const CsvToListConverter().convert(mydata1);
                        data = csvtable;
                        data1 = csvtable1;
                        int count=0;
                        int count1=0;
                        for (int i = 1; i < 2000; i++) {
                          if (data[i][17].toDouble() <= double.parse(store[1]) &&
                              (data[i][2].toString().contains(store[2]) ||
                                  data[i][8].toString().contains(store[2]) ||
                                  data[i][18].toString().contains(store[2]))) {
                            String concat = data[i].join("*");
                            recommendation.add(concat);
                            count++;
                          }
                          if ((data1[i][0].toString().contains(store[2]) ||
                              data1[i][1].toString().contains(store[2]) ||
                              data1[i][6].toString().contains(store[2]) || data1[i][13].toString().contains(store[2])
                              || data1[i][17].toString().contains(store[2]))) {
                            String concat = data1[i].join("*");
                            hotellist.add(concat);
                            count1++;
                          }
                        }

                        LoadAsset();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => homepage()));
                        
                      },
                      child: const Text(Strings.submitbutton),
                      style: ElevatedButton.styleFrom(
                        onPrimary: Colors.black87,
                        primary: const Color.fromRGBO(45, 156, 219, 1.0),
                        minimumSize: Size(
                            SizeConfig.widthMultiplier * 64.93, SizeConfig.heightMultiplier * 5.39),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier*5,
                  ),
                ],
              ),
            ),
            circularavatar(Alignment.topCenter),
          ],
        ),
      ),
    );
  }
  LoadAsset() async {
    Map<String, dynamic> data = {"Recommendation":store};
    Map<String, dynamic> data1 = {"Recommendationlist":recommendation};
    Map<String, dynamic> data2 = {"HotelDetails":hotellist};
    DocumentReference users = FirebaseFirestore.instance.collection('UserDetails').doc(Strings.email);
  }

}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}
