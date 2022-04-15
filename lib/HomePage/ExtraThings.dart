import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_project/Orientationfiles/Strings.dart';
import 'package:flutter_project/Orientationfiles/orientation.dart';

import '../content.dart';


final ScrollController controller = ScrollController();


class DataSearch extends StatefulWidget {
  const DataSearch({Key? key}) : super(key: key);

  @override
  _DataSearchState createState() => _DataSearchState();
}

class _DataSearchState extends State<DataSearch> {
  var location = [];
  var recentcities = [];
  TextEditingController _search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: const Color.fromRGBO(33, 37, 48, 1.0),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
            Container(
              width: SizeConfig.widthMultiplier * 75,
              child: TextField(
                controller: _search,
                onChanged: (val){
                  setState(() {
                    recentcities = Strings.makemytripdata.where((element){
                      return element[2].contains(val);
                    }).toList();
                  });
                },
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.white),
                    hintText: "Search.."),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _search.text ="";
                });
              },
              icon: const Icon(
                Icons.clear,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: ListView.builder(
            itemCount: _search.text.isNotEmpty? recentcities.length : Strings.makemytripdata.length,
            itemBuilder: (context, index){
              // return ListTile(
              //   leading: Icon(Icons.location_city,color: Colors.white,),
              //   title: Text(
              //     _search.text.isEmpty? recentcities[index][2].toString() :Strings.makemytripdata[index][2].toString(),
              //     style: TextStyle(color: Colors.white),
              //   ),
              //   subtitle: Text(
              //     _search.text.isEmpty? recentcities[index][2].toString() :Strings.makemytripdata[index][2].toString(),
              //     style: TextStyle(color: Colors.white),
              //   ),
              // );
              return Row(
                children: [
                  // ListTile(
                  //   leading: Icon(Icons.location_city),
                  //   title: Text(
                  //     _search.text.isEmpty? recentcities[index][2].toString() :Strings.makemytripdata[index][2].toString(),
                  //     style: TextStyle(color: Colors.white),),
                  // ),
                  CircleAvatar(
                    child: Icon(Icons.location_city),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(child: InkWell(
                    onTap: (){
                      List some = Strings.makemytripdata[index];
                      String send = some.join("*");
                      
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Content(value: send, datatype: "Recommendation",)));
                    },
                    child: Text(
                      _search.text.isNotEmpty? recentcities[index][2].toString() :Strings.makemytripdata[index][2].toString(),
                      style: TextStyle(color: Colors.white),),
                  ),),
                ],
              );
            }),
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    // etc.
  };
}