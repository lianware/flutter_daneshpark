import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Book.dart';
import 'CustomStyles.dart';
import 'Generate.dart';

class Books extends StatefulWidget {
  const Books({Key? key}) : super(key: key);
  @override
  _BooksState createState() => _BooksState();
}

class _BooksState extends State<Books> {
  final List<Book> _BooksItems = [];
  final List<Book> _myBookItems = [];
  var userId = "";
  var userToken = "";
  String callBack = "";

  final _messengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    fetchBookItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _messengerKey,
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("کتاب هوشمند", style: CustomStyles.titleStyle2),
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
            bottom: TabBar(
              indicatorColor: Colors.teal,
              labelColor: Colors.teal,
              unselectedLabelColor: Colors.black12,
              labelStyle: TextStyle(
                fontFamily: "Irs",
              ),
              tabs: [
                Tab(
                    text: 'فروشگاه کتاب',
                    icon: Icon(Icons.menu_book),
                    iconMargin: EdgeInsets.fromLTRB(0, 0, 0, 3)),
                Tab(
                    text: 'کتاب های من',
                    icon: Icon(Icons.my_library_books),
                    iconMargin: EdgeInsets.fromLTRB(0, 0, 0, 3)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              shopBooksUI(),
              myBooksUI(),
            ],
          ),
        ),
      ),
    );
  }

  Widget shopBooksUI() {
    return Builder(builder: (context) {
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: 500,
              padding: EdgeInsets.all(20),
              child: (_BooksItems.isEmpty)
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
                  : GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 15,
                      children:
                          List.generate(_BooksItems.length, (int position) {
                        return Generate.generateBookItem(
                            _BooksItems[position], context, userId, userToken);
                      }),
                    ),
            ),
          ],
        ),
      );
    });
  }

  Widget myBooksUI() {
    return Builder(builder: (context) {
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: 500,
              padding: EdgeInsets.all(20),
              child: (_myBookItems.isEmpty)
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
                        child: Container(
                            width: 200,
                            height: 100,
                            alignment: Alignment.center,
                            child: Text(
                              "کتابی یافت نشد",
                              style: TextStyle(fontFamily: "Irs"),
                            )),
                      ),
                    )
                  : GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 15,
                      children:
                          List.generate(_myBookItems.length, (int position) {
                        return Generate.generateMyBookItem(
                            _myBookItems[position], context);
                      }),
                    ),
            ),
          ],
        ),
      );
    });
  }

  Future<void> fetchBookItems() async {
    _BooksItems.clear();
    _myBookItems.clear();
    try {
      SharedPreferences logindata = await SharedPreferences.getInstance();
      Response response1 = await get(
          Uri.parse('http://daneshpark.ir/get/books'));
      Response response2 = await get(Uri.parse(
          'http://daneshpark.ir/get/book?token=' +
              logindata.getString("token").toString()));
      var itemsJson1 = json.decode(utf8.decode(response1.bodyBytes));
      var itemsJson2 = json.decode(utf8.decode(response2.bodyBytes));
      for (var tmp1 in itemsJson1['results']) {
        var myItem1 = Book(
            tmp1['_id'].toString(),
            tmp1['name'].toString(),
            tmp1['image_url'].toString(),
            tmp1['user_id'].toString(),
            tmp1['status'].toString(),
            tmp1['price'].toString(),
            tmp1['about'].toString());
        setState(() {
          _BooksItems.add(myItem1);
        });
      }
      if (response2.statusCode != 404) {
        for (var tmp2 in itemsJson2['results']) {
          var myItem2 = Book(
              tmp2['_id'].toString(),
              tmp2['name'].toString(),
              tmp2['image_url'].toString(),
              tmp2['user_id'].toString(),
              tmp2['status'].toString(),
              tmp2['price'].toString(),
              tmp2['about'].toString());
          setState(() {
            _myBookItems.add(myItem2);
          });
        }
      }
      setState(() {
        userId = logindata.getString("id").toString();
        userToken = logindata.getString("token").toString();
      });
    } catch (e) {
      Generate.showMySnackBar(
          context, "اتصال شما با سرور قطع می باشد", _messengerKey);
    }
  }
}
