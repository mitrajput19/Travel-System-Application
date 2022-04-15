import 'dart:math';

import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/Orientationfiles/Strings.dart';
import 'package:flutter_project/Orientationfiles/orientation.dart';
import 'package:ibm_watson_assistant/ibm_watson_assistant.dart';
import '../content.dart';
import 'hero_dialog_route.dart';

class AddTodoButton extends StatelessWidget {
  /// {@macro add_todo_button}
  const AddTodoButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            HeroDialogRoute(
              builder: (context) {
                return const _AddTodoPopupCard();
              },
            ),
          );
        },
        child: Hero(
          tag: _heroAddTodo,
          child: Material(
            color: Colors.grey,
            elevation: 2,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            child: const Icon(
              Icons.add_rounded,
              size: 50,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

const String _heroAddTodo = 'add-todo-hero';

class _AddTodoPopupCard extends StatefulWidget {
  const _AddTodoPopupCard({Key? key}) : super(key: key);

  @override
  _AddTodoPopupCardState createState() => _AddTodoPopupCardState();
}

class _AddTodoPopupCardState extends State<_AddTodoPopupCard> {
  TextEditingController chat = TextEditingController();

  List<Map> messsages = [];


  void chatbot(String input) async {
    final auth = IbmWatsonAssistantAuth(
      assistantId: '',//Enter Assistant ID
      url: '',//Enter URL
      apikey: '',//Enter API key
    );
    final bot = IbmWatsonAssistant(auth);
    //change this it creates new session everytime the chatbot is called
    final sessionId = await bot.createSession();
    final botRes = await bot.sendInput(input, sessionId: sessionId);
    if(botRes.responseText!.contains("Value123456Project")){
      FirebaseFirestore.instance.collection("UserDetails").doc(Strings.email).get().then((value) {
        Map<String, dynamic> store =value.data() as Map<String, dynamic>;
        
        String send = store["Recommendationlist"][Random().nextInt(
            store["Recommendationlist"].length)];
        setState(() {
          messsages.insert(0, {
            "data": 0,
            "message": send,
          });
        });
      });
    }else{
      setState(() {
        messsages.insert(0, {
          "data": 0,
          "message": botRes.responseText,
        });
      });
    }
    //bot.deleteSession(sessionId.toString());
  }


  TextStyle changecolor(int data) {
    if (data == 0) {
      return TextStyle(color: Colors.black, fontWeight: FontWeight.bold);
    } else {
      return TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: SizeConfig.heightMultiplier * 55.61,
        width: SizeConfig.widthMultiplier * 85.15,
        child: Hero(
          tag: _heroAddTodo,
          child: Material(
            color: Colors.white.withOpacity(0.4),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: SizeConfig.heightMultiplier * 47.9,
                    width: SizeConfig.widthMultiplier * 83,
                    child: ListView.builder(
                      reverse: true,
                      itemCount: messsages.length,
                      itemBuilder: (context, index) => chatscreen(
                        messsages[index]["message"].toString(),
                        messsages[index]["data"],
                      ),
                    ),
                  ),
                  Container(
                    child: ListTile(
                      title: Container(
                        height: SizeConfig.heightMultiplier * 4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Color.fromRGBO(220, 220, 220, 1),
                        ),
                        padding: EdgeInsets.only(
                            top: SizeConfig.heightMultiplier * 1.89,
                            left: SizeConfig.widthMultiplier * 3),
                        child: TextField(
                          controller: chat,
                          decoration: InputDecoration(
                            hintText: "Enter a Message...",
                            hintStyle: TextStyle(color: Colors.black26),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                          style: TextStyle(
                              fontSize: SizeConfig.textMultiplier * 1.77,
                              color: Colors.black),
                          onChanged: (value) {},
                        ),
                      ),
                      trailing: IconButton(
                          icon: Icon(
                            Icons.send,
                            size: SizeConfig.heightMultiplier * 3.33,
                            color: Colors.greenAccent,
                          ),
                          onPressed: () {
                            if (chat.text.isEmpty) {
                              print("empty message");
                            } else {
                              setState(() {
                                messsages.insert(
                                    0, {"data": 1, "message": chat.text});
                              });
                              chatbot(chat.text);
                              if (chat.text == "mumbai") {
                                
                              }
                              chat.clear();
                            }
                            FocusScopeNode currentFocus =
                            FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget chatscreen(String message, int data) {
    return Container(
      padding: EdgeInsets.only(
          left: SizeConfig.widthMultiplier * 4.866,
          right: SizeConfig.widthMultiplier * 4.866),
      child: Row(
        mainAxisAlignment:
        data == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          data == 0
              ? Padding(
            padding: EdgeInsets.only(
                top: SizeConfig.heightMultiplier * 3.33,
                right: SizeConfig.widthMultiplier * 1.216),
            child: Container(
              height: SizeConfig.heightMultiplier * 1.11,
              width: SizeConfig.widthMultiplier * 2.433,
              child: CircleAvatar(
                backgroundColor: Colors.green,
              ),
            ),
          )
              : Container(),
          Padding(
            padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 1.11),
            child: Bubble(
              radius: Radius.circular(15.0),
              color: data == 0 ? Colors.white : Colors.green,
              elevation: 0.0,
              child: Padding(
                padding: EdgeInsets.all(2.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      width: SizeConfig.widthMultiplier * 2.433,
                    ),
                    data == 1
                        ? Flexible(
                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth:
                            SizeConfig.widthMultiplier * 48.661),
                        child: Text(
                          message,
                          style: changecolor(data),
                        ),
                      ),
                    )
                        : Flexible(
                      child: InkWell(
                        onTap: () {
                          if (message.contains("*")) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Content(
                                    value: message,
                                    datatype: "Recommendation",
                                  ),
                                ));
                          }
                        },
                        child: Container(
                          constraints: BoxConstraints(
                              maxWidth:
                              SizeConfig.widthMultiplier * 48.661),
                          child: Text(
                            (message.contains("*"))
                                ? message.split("*")[2]
                                : message,
                            style: changecolor(data),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          data == 1
              ? Padding(
            padding: EdgeInsets.only(
                top: SizeConfig.heightMultiplier * 3.33,
                left: SizeConfig.widthMultiplier * 1.21),
            child: Container(
              height: SizeConfig.heightMultiplier * 3.33,
              width: 10,
              child: CircleAvatar(
                backgroundColor: Colors.grey,
              ),
            ),
          )
              : Container(),
        ],
      ),
    );
  }
}
