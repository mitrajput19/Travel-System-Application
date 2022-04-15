import 'package:csv/csv.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'HomePage/HomePage.dart';
import 'LoginPage/loginpage2.dart';
import 'Orientationfiles/Strings.dart';
import 'Orientationfiles/Styling.dart';
import 'Orientationfiles/orientation.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const myapp());
}

class myapp extends StatefulWidget {
  const myapp({Key? key}) : super(key: key);

  
  @override
  _myappState createState() => _myappState();
}

class _myappState extends State<myapp> {

void  set()async{
  final mydata = await rootBundle.loadString("assets/makemytrip.csv");
  final mydata1 = await rootBundle.loadString("assets/try1.csv");
  List<List<dynamic>> csvtable = const CsvToListConverter().convert(mydata);
  List<List<dynamic>> csvtable1 = const CsvToListConverter().convert(mydata1);
  Strings.makemytripdata = csvtable;
  Strings.data = csvtable1;
}
  @override
  Widget build(BuildContext context) {
    if(FirebaseAuth.instance.currentUser!=null){
      set();
      Strings.email = FirebaseAuth.instance.currentUser!.email!;
      return LayoutBuilder(
        builder: ( context , constraints) {
          return OrientationBuilder(
            builder: (context, orientation){
              SizeConfig().init(constraints, orientation);
              //var id;
              return MaterialApp(
                theme: AppTheme.darkTheme,
                debugShowCheckedModeBanner: false,
                home:homepage(),
              );
            },
          );
        },
      );
    }else{
      set();
      return LayoutBuilder(
        builder: ( context , constraints) {
          return OrientationBuilder(
            builder: (context, orientation){
              SizeConfig().init(constraints, orientation);
              //var id;
              return MaterialApp(
                theme: AppTheme.darkTheme,
                debugShowCheckedModeBanner: false,
                home:loginpage2(),
              );
            },
          );
        },
      );
    }

  }
}

