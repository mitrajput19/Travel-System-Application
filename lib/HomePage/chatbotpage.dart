import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
import 'package:flutter_project/Orientationfiles/orientation.dart';

import '../main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const myapp());
}
class chatbot extends StatefulWidget {
  const chatbot({Key? key}) : super(key: key);

  @override
  _chatbotState createState() => _chatbotState();
}

class _chatbotState extends State<chatbot> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Scaffold(
        body:SafeArea(
          child:Container(
            child: Column(
              children: [
               Padding(
                   padding: EdgeInsets.only(top:SizeConfig.heightMultiplier*1.1),
                 child:Text("Ask query"),
               ),

              ],

            ),
          ),

          ),
        ),
      );


  }
}
