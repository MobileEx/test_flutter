import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:test_project/modele/languages.dart';
import 'package:test_project/view/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:test_project/view/lang.dart';
import 'package:translator/translator.dart';

import '../main.dart';

class screen2 extends StatefulWidget {
  var darkmode;
  var user;
  var i;
  var word1;
  var word2;
  screen2({this.darkmode, this.user, this.i, this.word1, this.word2});

  @override
  _screen2State createState() => _screen2State();
}

class _screen2State extends State<screen2> {
  var j;
  var lang;
  testcolor() {
    j = widget.darkmode;
  }

  Future<languages> fetchAlbum() async {
    final response = await http.get('http://165.22.19.126:4000/');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      lang = languages.fromJson(json.decode(response.body));
      return lang;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    super.initState();
    testcolor();
    fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        actions: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width / 6.5,
            color: j ? Colors.black : Colors.white,
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.leftToRightWithFade,
                        child: screen1(j, widget.user, widget.i)));
              },
              icon: Icon(
                MdiIcons.dotsVertical,
                size: 40,
              ),
              color: j ? Colors.white : Colors.black,
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey[500],
            ),
          )
        ],
      ),
      body: Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width / 6.5,
            height: MediaQuery.of(context).size.height,
            color: j ? Colors.black : Colors.white,
          ),
          Expanded(
            child: Container(
                color: Colors.grey[500],
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 6.5,
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(50.0),
                          child: Text(
                            widget.word1,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        CupertinoSwitch(
                            value: j,
                            onChanged: (bool value) async {
                              if (value != j) {
                                j = value;
                                firestoreInstance
                                    .collection("users")
                                    .document(widget.user.documentID)
                                    .updateData({"darkmode": j}).then((_) {
                                  print("success!");
                                });
                                setState(() {});
                              }
                            }),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => langsc(
                                    darkmode: j,
                                    user: widget.user,
                                    langa: lang,
                                    word1:  widget.word2,
                                    word2:  widget.word2)));
                      },
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(50.0),
                              child: Text(
                                widget.word2,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 30,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
