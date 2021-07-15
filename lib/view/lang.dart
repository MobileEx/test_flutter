import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:test_project/modele/languages.dart';

import 'package:test_project/view/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_project/view/screen2.dart';
import 'package:translator/translator.dart';

import '../main.dart';

class langsc extends StatefulWidget {
  var darkmode;
  var user;
  var langa;
  var word1;
  var word2;
  langsc({this.darkmode, this.user, this.langa, this.word1, this.word2});

  @override
  _langscState createState() => _langscState();
}

class _langscState extends State<langsc> {
  var j;
  testcolor() {
    j = widget.darkmode;
  }

  var user1;
  var i;
  @override
  void initState() {
    i = widget.user.data["language"];
    super.initState();
    testcolor();
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
                        child: screen1(j, widget.user, i)));
              },
              icon: Icon(
                MdiIcons.dotsVertical,
                size: 40,
              ),
              color: j ? Colors.white : Colors.black,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 6.5,
            color: Colors.grey[500],
            child: IconButton(
              onPressed: () async {
                if (await trans("hello world", "darkmode", "language")) {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.leftToRightWithFade,
                          child: screen2(
                            user: user1 == null ? widget.user : user1,
                            darkmode: j,
                            i: i,
                            word1: translation1,
                            word2: translation2,
                          )));
                }
              },
              icon: Icon(
                MdiIcons.arrowLeft,
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
      body: Row(children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width / 6.5,
          height: MediaQuery.of(context).size.height,
          color: j ? Colors.black : Colors.white,
        ),
        Container(
          width: MediaQuery.of(context).size.width -
              MediaQuery.of(context).size.width / 6.5,
          height: MediaQuery.of(context).size.height,
          color: Colors.grey[500],
          child: GridView.builder(
            shrinkWrap: false,
            itemCount: widget.langa.language.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 5,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 1,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: 100,
                  height: 100,
                  child: Row(
                    children: <Widget>[
                      Text(
                        widget.langa.language[index],
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Checkbox(
                        value: widget.langa.language[index] == i,
                        onChanged: (value) async {
                          i = widget.langa.language[index];
                          firestoreInstance
                              .collection("users")
                              .document(widget.user.documentID)
                              .updateData({"language": i}).then((_) {
                            print("success!");
                          });
                          firestoreInstance
                              .collection("users")
                              .where("uid", isEqualTo: "houssam")
                              .getDocuments()
                              .then((value) {
                            value.documents.forEach((result) {
                              print(result.data);
                              user1 = result;
                            });
                          });

                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ]),
    );
  }

  var translation;
  var translation1;
  var translation2;
  var boo = false;
  Future<bool> trans(word, word1, word2) async {
    final translator = new GoogleTranslator();
    switch (user1.data["language"]) {
      case "English":
        translation = await translator.translate(word, to: "en");
        translation1 = await translator.translate(word1, to: "en");
        translation2 = await translator.translate(word2, to: "en");
        return true;
        break;
      case "German":
        translation = await translator.translate(word, to: "de");
        translation1 = await translator.translate(word1, to: "de");
        translation2 = await translator.translate(word2, to: "de");
        return true;
        break;
      case "Spanish":
        translation = await translator.translate(word, to: "es");
        translation1 = await translator.translate(word1, to: "es");
        translation2 = await translator.translate(word2, to: "es");
        return true;
        break;
      case "Russian":
        translation = await translator.translate(word, to: "ru");
        translation1 = await translator.translate(word1, to: "ru");
        translation2 = await translator.translate(word2, to: "ru");
        return true;
        break;
      case "Chinese":
        translation = await translator.translate(word, to: "zh-cn");
        translation1 = await translator.translate(word1, to: "zh-cn");
        translation2 = await translator.translate(word2, to: "zh-cn");
        return true;
        break;
      default:
    }
  }
}
