import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'Books.dart';

import 'package:flutter/material.dart';
import 'Generate.dart';

import 'CustomStyles.dart';

class BuyBook extends StatefulWidget {
  var bookDetails, userId, userToken;
  BuyBook(this.bookDetails, this.userId, this.userToken);
  @override
  _BuyBookState createState() => _BuyBookState();
}

class _BuyBookState extends State<BuyBook> {
  final _messengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _messengerKey,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Directionality(
              textDirection: TextDirection.rtl,
              child: Text(widget.bookDetails.name,
                  style: CustomStyles.titleStyle3)),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
              Response response = await post(Uri.parse(
                  "http://daneshpark.ir/buy/book?id=" +
                      widget.bookDetails.id +
                      "&token=" +
                      widget.userToken));
              if (response.statusCode == 200) {
                Generate.showMySnackBar(
                    context, "خرید شما با موفقیت انجام شد", _messengerKey);
              } else {
                var BuyJson = json.decode(utf8.decode(response.bodyBytes));
                Generate.showMySnackBar(context, BuyJson['message']
                   , _messengerKey);
            }
          },
          child: Icon(Icons.payments_outlined, color: Colors.white),
          backgroundColor: Colors.teal,
        ),
      ),
    );
  }
}
