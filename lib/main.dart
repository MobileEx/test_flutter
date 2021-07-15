import 'package:flutter/material.dart';
import 'package:test_project/view/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

var val;
var user;
final firestoreInstance = Firestore.instance;
void main() async {
  runApp(MyApp());
}

bool t = false;

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  testuser() async {
    var uid = "houssam";
    if (await firstcame(uid) == null) {
      var t = await adduser(uid);
      firestoreInstance.collection("users").add({
        "uid": "houssam",
        "darkmode": false,
        "language": "English"
      }).then((value) {
        print(value.documentID);
      });
    } else {
      firestoreInstance
          .collection("users")
          .where("uid", isEqualTo: uid)
          .getDocuments()
          .then((value) {
        value.documents.forEach((result) {
          print(result.data);
          user = result;
          setState(() {});
        });
      });
    }
  }

  void initState() {
    super.initState();
    testuser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: user == null
          ? Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : screen1(user.data["darkmode"], user,user.data["language"]),
    );
  }
}

adduser(a) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var t = 'houssam';
  prefs.setInt(a, 1);
  return 1;
}

firstcame(t) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return int
  int intValue = prefs.getInt(t);
  print(intValue);
  return intValue;
}
