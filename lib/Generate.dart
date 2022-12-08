import 'package:flutter/material.dart';
import 'BuyBook.dart';
import 'Book.dart';
import 'OrderLogs.dart';
import 'BuyLogs.dart';
import 'Posts.dart';
import 'PostView.dart';

class Generate {
  static Widget generatePostItem(Posts ps, BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      elevation: 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                child: Container(
                  width: 200,
                  child: Text(
                    ps.name,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Colors.black, fontFamily: "Irs", fontSize: 16),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                child: Container(
                  width: 200,
                  child: Text(
                    ps.author,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontFamily: 'Irs',
                        color: Color.fromARGB(153, 131, 131, 131),
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          Stack(children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15)),
              child: Image.network(
                ps.image,
                fit: BoxFit.fill,
                width: 140,
                height: 140,
              ),
            ),
            Container(
              width: 140,
              height: 140,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PostView(ps.name, ps.link)));
                },
                icon: Icon(Icons.play_circle_fill_outlined),
                color: Colors.tealAccent,
                iconSize: 50,
              ),
            ),
          ]),
        ],
      ),
    );
  }

  static Widget generateBookItem(
      Book bk, BuildContext context, var userId, var userToken) {
    return Builder(builder: (context) {
      return InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => BuyBook(bk, userId, userToken)));
        },
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          elevation: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15)),
                child: Image.network(
                  "https://wallpaperaccess.com/full/676550.jpg",
                  fit: BoxFit.fill,
                  height: 100,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Container(
                  height: 40,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      bk.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black, fontFamily: "Irs", fontSize: 14),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "لیان ",
                        style: TextStyle(
                            fontFamily: 'Irs',
                            color: Color.fromARGB(153, 131, 131, 131),
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(bk.amount,
                          style: TextStyle(
                              fontFamily: 'Irs',
                              color: Color.fromARGB(153, 131, 131, 131),
                              fontSize: 14,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  static Widget generateMyBookItem(Book bk, BuildContext context) {
    return Builder(builder: (context) {
      return InkWell(
        onTap: () {},
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          elevation: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15)),
                child: Image.network(
                  "https://wallpaperaccess.com/full/676550.jpg",
                  fit: BoxFit.fill,
                  height: 100,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Container(
                  height: 20,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      bk.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black, fontFamily: "Irs", fontSize: 14),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  static Widget generateLogs1(OrderLogs log, BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
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
                  log.amount,
                  style: TextStyle(
                      fontFamily: "Irs",
                      fontSize: 22,
                      color: Colors.teal,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Container(
              child: Text(
                "کد رهگیری " + log.ref_id,
                textAlign: TextAlign.right,
                style: TextStyle(
                    color: Colors.black, fontFamily: 'Irs', fontSize: 18),
              ),
            ),
            Container(
              child: Text(
                "در تاریخ " + log.order_date,
                style: TextStyle(fontFamily: 'Irs'),
              ),
            ),
            Container(
              child: Text(
                ((log.state == "OK") ? "پرداخت موفق" : " پرداخت ناموفق"),
                style: TextStyle(fontFamily: 'Irs', fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget generateLogs2(BuyLogs log, BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
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
                  log.price,
                  style: TextStyle(
                      fontFamily: "Irs",
                      fontSize: 22,
                      color: Colors.teal,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Container(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Text(
                  log.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black, fontFamily: 'Irs', fontSize: 18),
                ),
              ),
            ),
            Container(
              child: Text(
                "در تاریخ " + log.date,
                style: TextStyle(fontFamily: 'Irs'),
              ),
            ),
            Container(
              child: Text(
                (log.state == "-1")
                    ? "خرید محصول از فروشگاه کتاب هوشمند"
                        : (log.state == "1")
                            ? "خرید تور آموزشی"
                                : "خرید محصول از دکه",
                style: TextStyle(
                  fontFamily: 'Irs',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void showMySnackBar(
      BuildContext context, String message, var messengerKey) {
    messengerKey.currentState!.showSnackBar(SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        message,
        style: TextStyle(
            fontFamily: "Irs",
            fontSize: 17,
            color: Colors.white,
            fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      elevation: 5,
      duration: Duration(seconds: 10),
      action: SnackBarAction(
        label: 'تایید',
        onPressed: () {},
        textColor: Colors.yellowAccent,
      ),
    ));
  }
}
