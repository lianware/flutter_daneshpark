import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Posts.dart';

import 'CustomStyles.dart';
import 'Generate.dart';

class Gaahnaame extends StatefulWidget {
  const Gaahnaame({Key? key}) : super(key: key);
  @override
  _GaahnaameState createState() => _GaahnaameState();
}

class _GaahnaameState extends State<Gaahnaame> {
  final List<Posts> _items = [];

  final _messengerKey = GlobalKey<ScaffoldMessengerState>();


  @override
  void initState() {
    fetchContent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _messengerKey,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("گاهنامه دانشپارک", style: CustomStyles.titleStyle2),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 5,
          automaticallyImplyLeading: false,
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black45,
            ),
          ),
        ),
        body: Column(children: [contentUI()]),
      ),
    );
  }

  Widget contentUI() {
    return Builder(builder: (context) {
      return Center(
        child: (_items.isEmpty)
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
                  child: Container(
                      width: 200,
                      height: 100,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator()),
                ),
              )
            : Container(
                height: 500,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: RefreshIndicator(
                    onRefresh: fetchContent,
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: List.generate(_items.length, (int position) {
                        return Generate.generatePostItem(
                            _items[position], context);
                      }),
                    ),
                  ),
                ),
              ),
      );
    });
  }

  Future<void> fetchContent() async {
    _items.clear();
    try {
      Response response1 = await get(Uri.parse('http://daneshpark.ir:1085'));
      var itemsJson = json.decode(utf8.decode(response1.bodyBytes));
      for (var tmp1 in itemsJson['data']) {
        var myItem1 = Posts(tmp1['title'], tmp1['cover_image'], tmp1['date'],
            tmp1['id'].substring(10));
        setState(() {
          _items.add(myItem1);
        });
      }
    } catch (e) {
      Generate.showMySnackBar(
          context, "اتصال شما با اینترنت قطع می باشد", _messengerKey);
    }
  }
}
