import 'Books.dart';

import 'Bank.dart';

import 'Gaahnaame.dart';

import 'LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CustomStyles.dart';

void main() {
  runApp(Home());
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String callBack = "";

  final _messengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
  }

  void logOut() async {
    SharedPreferences logindata = await SharedPreferences.getInstance();
    logindata.remove('login');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _messengerKey,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text("دانشپارک", style: CustomStyles.titleStyle2),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 5,
            actions: <Widget>[
              IconButton(
                  onPressed: () {
                    logOut();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (route) => false);
                  },
                  icon: Icon(
                    Icons.logout,
                    color: Colors.black45,
                  ))
            ],
            automaticallyImplyLeading: false,
          ),
          body: mainUI()),
    );
  }

  Widget mainUI() {
    return Builder(builder: (context) {
      return Container(
        padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 2,
          mainAxisSpacing: 5,
          children: [
            Column(children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Gaahnaame()));
                },
                icon: Icon(Icons.newspaper),
                color: Colors.teal,
                iconSize: 80,
              ),
              Text("گاهنامه",
                  style: TextStyle(
                      fontFamily: "Irs",
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ]),
            Column(children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Bank()));
                },
                icon: Icon(Icons.payments),
                color: Colors.teal,
                iconSize: 80,
              ),
              Text("بانک",
                  style: TextStyle(
                      fontFamily: "Irs",
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ]),
            Column(children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Books()));
                },
                icon: Icon(Icons.book),
                color: Colors.teal,
                iconSize: 80,
              ),
              Text("کتاب هوشمند",
                  style: TextStyle(
                      fontFamily: "Irs",
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ]),
            Column(children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Books()));
                },
                icon: Icon(Icons.quiz),
                color: Colors.teal,
                iconSize: 80,
              ),
              Text("شناسه",
                  style: TextStyle(
                      fontFamily: "Irs",
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ]),
          ],
        ),
      );
    });
  }
}
