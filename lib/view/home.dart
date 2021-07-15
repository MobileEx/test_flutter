import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import "package:test_project/view/screen2.dart";
import 'package:page_transition/page_transition.dart';
import 'package:translator/translator.dart';

import '../main.dart';

class screen1 extends StatefulWidget {
  var darkmode;
  var user;
  String i;
  screen1(this.darkmode, this.user, this.i);

  @override
  _screen1State createState() => _screen1State();
}

class _screen1State extends State<screen1> {
  var translation;
  var translation1;
  var translation2;
  var boo = false;
  void trans(word, word1, word2) async {
    final translator = new GoogleTranslator();
    switch (widget.user.data["language"]) {
      case "English":
        translation = await translator.translate(word, to: "en");
        translation1 = await translator.translate(word1, to: "en");
        translation2 = await translator.translate(word2, to: "en");

        break;
      case "German":
        translation = await translator.translate(word, to: "de");
        translation1 = await translator.translate(word1, to: "de");
        translation2 = await translator.translate(word2, to: "de");

        break;
      case "Spanish":
        translation = await translator.translate(word, to: "es");
        translation1 = await translator.translate(word1, to: "es");
        translation2 = await translator.translate(word2, to: "es");
        break;
      case "Russian":
        translation = await translator.translate(word, to: "ru");
        translation1 = await translator.translate(word1, to: "ru");
        translation2 = await translator.translate(word2, to: "ru");
        break;
      case "Chinese":
        translation = await translator.translate(word, to: "zh-cn");
        translation1 = await translator.translate(word1, to: "zh-cn");
        translation2 = await translator.translate(word2, to: "zh-cn");
        break;
      default:
    }

    // prints Hello. Are you okay?
    print(translation);
    boo = true;
    setState(() {});

    // prints Dart jest bardzo fajny!

    // prints exemplo
  }

  void initState() {
    super.initState();
    trans("hello world", "darkmode", "language");
  }

  @override
  Widget build(BuildContext context) {
    return boo == false
        ? Scaffold(
            backgroundColor:
                widget.darkmode == true ? Colors.black : Colors.white,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor:
                  widget.darkmode == true ? Colors.black : Colors.white,
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: screen2(
                                darkmode: widget.darkmode,
                                user: widget.user,
                                word1: translation1,
                                word2: translation2)));
                  },
                  icon: Icon(
                    MdiIcons.dotsVertical,
                    size: 40,
                  ),
                  color: widget.darkmode == true ? Colors.white : Colors.black,
                ),
              ],
            ),
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: widget.darkmode == true ? Colors.black : Colors.white,
              child: Center(
                child: Container(
                    width: 200,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.red,
                        width: 9, //                   <--- border width here
                      ),
                    ),
                    child: Center(
                      child: Text(
                        translation,
                        style: TextStyle(
                            fontSize: 30,
                            color: widget.darkmode == true
                                ? Colors.white
                                : Colors.black),
                      ),
                    )),
              ),
            ),
          );
  }
}
