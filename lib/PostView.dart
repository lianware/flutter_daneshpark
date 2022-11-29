import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'CustomStyles.dart';

class PostView extends StatefulWidget {
  late String postTitle;
  late String postUrl;
  PostView(this.postTitle, this.postUrl);
  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.postTitle,
            style: CustomStyles.titleStyle(Colors.white, 19, FontWeight.normal),
          ),
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: WebView(
          initialUrl: "http://emag.daneshpark.org/post/" + widget.postUrl,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
