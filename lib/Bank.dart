import 'dart:async';
import 'dart:convert';

import 'BuyLogs.dart';
import 'package:url_launcher/url_launcher.dart';
import 'OrderLogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';

import 'CustomStyles.dart';
import 'Generate.dart';

class Bank extends StatefulWidget {
  const Bank({Key? key}) : super(key: key);
  @override
  _BankState createState() => _BankState();
}

class _BankState extends State<Bank> {
  final List<OrderLogs> _Orderlogs = [];
  final List<BuyLogs> _Buylogs = [];

  String userAmount = "";
  String callBack = "";

  double _sliderDiscreteValue = 10;

  final _messengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    fetchPayment();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _messengerKey,
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text("بانک", style: CustomStyles.titleStyle2),
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
                    text: 'افزایش اعتبار',
                    icon: Icon(Icons.money),
                    iconMargin: EdgeInsets.fromLTRB(0, 0, 0, 3)),
                Tab(
                    text: 'افزایش و کاهش ',
                    icon: Icon(Icons.receipt_long),
                    iconMargin: EdgeInsets.fromLTRB(0, 0, 0, 3)),
                Tab(
                    text: 'خرید و فروش',
                    icon: Icon(Icons.receipt_long),
                    iconMargin: EdgeInsets.fromLTRB(0, 0, 0, 3)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              RefreshIndicator(
                onRefresh: fetchPayment,
                child: ListView(scrollDirection: Axis.vertical, children: [
                  Center(
                      child: Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 60,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "لیان ",
                                style: TextStyle(
                                  fontFamily: "Irs",
                                  fontSize: 14,
                                  color: Colors.black45,
                                ),
                              ),
                              Text(
                                userAmount,
                                style: TextStyle(
                                    fontFamily: "Irs",
                                    fontSize: 22,
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                " موجودی شما",
                                style: CustomStyles.titleStyle3,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 70,
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                          child: Slider(
                            value: _sliderDiscreteValue,
                            min: 1,
                            max: 100,
                            divisions: 100,
                            thumbColor: Colors.white,
                            label: _sliderDiscreteValue.floor().toString(),
                            onChanged: (value) {
                              setState(() {
                                _sliderDiscreteValue = value;
                              });
                            },
                          ),
                        ),
                        Container(
                          child: Column(children: [
                            Text(
                              _sliderDiscreteValue.floor().toString(),
                              style: TextStyle(
                                  fontFamily: "Irs",
                                  fontSize: 22,
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "لیان",
                              style: TextStyle(
                                fontFamily: "Irs",
                                fontSize: 14,
                                color: Colors.black45,
                              ),
                            ),
                          ]),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        TextButton(
                          onPressed: () {
                            _launchUrl((_sliderDiscreteValue.floor() * 10000)
                                .toString());
                          },
                          child: Text('پرداخت'),
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            fixedSize: Size(350, 60),
                            primary: Colors.white,
                            backgroundColor: Colors.blueAccent,
                            elevation: 10,
                            textStyle:
                                TextStyle(fontSize: 22, fontFamily: "Irs"),
                          ),
                        ),
                      ],
                    ),
                  )),
                ]),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: RefreshIndicator(
                    onRefresh: fetchPayment,
                    child: (_Orderlogs.isEmpty)
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
                              child: Container(
                                  width: 200,
                                  height: 100,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "رسید تراکنشی یافت نشد",
                                    style: TextStyle(fontFamily: "Irs"),
                                  )),
                            ),
                          )
                        : ListView(
                            scrollDirection: Axis.vertical,
                            children: List.generate(_Orderlogs.length,
                                (int position) {
                              return Generate.generateLogs1(
                                  _Orderlogs[position], context);
                            }),
                          ),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: RefreshIndicator(
                    onRefresh: fetchPayment,
                    child: (_Buylogs.isEmpty)
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
                        : ListView(
                            scrollDirection: Axis.vertical,
                            children:
                                List.generate(_Buylogs.length, (int position) {
                              return Generate.generateLogs2(
                                  _Buylogs[position], context);
                            }),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String amount) async {
    SharedPreferences logindata = await SharedPreferences.getInstance();
    if (!await launchUrl(
        Uri.parse("http://daneshpark.ir/add/money/" +
            amount +
            "?token=" +
            logindata.getString("token").toString()),
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch';
    }
  }

  Future<void> fetchPayment() async {
    _Orderlogs.clear();
    _Buylogs.clear();
    try {
      SharedPreferences logindata = await SharedPreferences.getInstance();
      // Response response1 = await get(Uri.parse(
      //     "http://daneshpark.ir:1585/public/api/get/user/charge/" +
      //         logindata.getString("id").toString() +
      //         "?token=" +
      //         logindata.getString("token").toString()));

      // Response response2 = await get(Uri.parse(
      //     "http://daneshpark.ir:1090/get/transactions/user?id=" +
      //         logindata.getString("id").toString()));
      // var logJson1 = json.decode(utf8.decode(response1.bodyBytes));
      // var logJson2 = json.decode(utf8.decode(response2.bodyBytes));
      // for (var tmp1 in logJson1["amount"]["data"]) {
      //   var myItem1 = OrderLogs(
      //       tmp1['order_date'],
      //       tmp1['amount'].toString(),
      //       tmp1['state'].toString(),
      //       tmp1['authority'],
      //       tmp1['ref_id'],
      //       tmp1['is_ok'].toString());
      //   setState(() {
      //     _Orderlogs.add(myItem1);
      //   });
      // }
      // for (var tmp2 in logJson2["resutls"]) {
      //   var myItem2 = BuyLogs(
      //       tmp2['_id'].toString(),
      //       tmp2['date'].toString(),
      //       tmp2['state'].toString(),
      //       tmp2['price'].toString(),
      //       tmp2['item_id'].toString(),
      //       tmp2['user_id'].toString(),
      //       tmp2['name']);
      //   setState(() {
      //     _Buylogs.add(myItem2);
      //   });
      // }
      setState(() {
        userAmount = logindata.getString('amount').toString();
      });
    } catch (e) {
      Generate.showMySnackBar(
          context, "اتصال شما با سرور قطع می باشد", _messengerKey);
    }
  }
}
