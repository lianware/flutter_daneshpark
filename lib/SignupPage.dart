import 'package:flutter/material.dart';
import 'Generate.dart';

import 'CustomStyles.dart';
import 'SendRequest.dart';

class Signup extends StatefulWidget {
  BuildContext context;
  Signup(this.context);
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _nationalCodeController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordRepeatController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  final _messengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        scaffoldMessengerKey: _messengerKey,
        home: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                "ثبت نام",
                style: TextStyle(
                    fontFamily: "Irs", fontSize: 20, color: Colors.black45),
              ),
              leading: InkWell(
                onTap: () {
                  Navigator.of(widget.context).pop();
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black45,
                ),
              ),
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: signupUI(),
          );
        }));
  }

  Widget signupUI() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Container(
              height: 753,
              margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                elevation: 4,
                child: Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      CustomStyles.textFieldStyle1(
                          "نام",
                          "نام",
                          TextInputType.name,
                          false,
                          Icons.check_box,
                          _firstNameController),
                      SizedBox(
                        height: 25,
                      ),
                      CustomStyles.textFieldStyle1(
                          "نام خانوادگی",
                          "نام خانوادگی",
                          TextInputType.name,
                          false,
                          Icons.check_box,
                          _lastNameController),
                      SizedBox(
                        height: 25,
                      ),
                      CustomStyles.textFieldStyle1(
                          "کد ملی",
                          "کد ملی",
                          TextInputType.number,
                          false,
                          Icons.safety_divider,
                          _nationalCodeController),
                      SizedBox(
                        height: 25,
                      ),
                      CustomStyles.textFieldStyle1(
                          "شماره همراه",
                          "شماره همراه",
                          TextInputType.number,
                          false,
                          Icons.phone_android,
                          _mobileNumberController),
                      SizedBox(
                        height: 25,
                      ),
                      CustomStyles.textFieldStyle1(
                          "نام کاربری",
                          "پست الکترونیک",
                          TextInputType.emailAddress,
                          false,
                          Icons.email,
                          _usernameController),
                      SizedBox(
                        height: 25,
                      ),
                      CustomStyles.textFieldStyle1(
                          "رمز عبور",
                          "رمز عبور",
                          TextInputType.visiblePassword,
                          true,
                          Icons.lock,
                          _passwordController),
                      SizedBox(
                        height: 25,
                      ),
                      CustomStyles.textFieldStyle1(
                          "تکرار رمز عبور",
                          "تکرار رمز عبور",
                          TextInputType.visiblePassword,
                          true,
                          Icons.lock,
                          _passwordRepeatController),
                      SizedBox(
                        height: 35,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            TextButton(
              onPressed: () {
                if (_passwordController.text !=
                    _passwordRepeatController.text) {
                  Generate.showMySnackBar(context,
                      "رمز عبور و تکرار آن مطابقت ندارند", _messengerKey);
                } else {
                  SendRequest.signupReq(
                    context: context,
                    firstName: _firstNameController.text,
                    lastName: _lastNameController.text,
                    username: _usernameController.text,
                    password: _passwordController.text,
                    nationalCode: _nationalCodeController.text,
                    phoneNumber: _mobileNumberController.text,
                    messengerKey: _messengerKey,
                  );
                }
              },
              child: Text('ثبت نام'),
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                fixedSize: Size(MediaQuery.of(context).size.width - 70, 60),
                primary: Colors.white,
                backgroundColor: Colors.blueAccent,
                elevation: 10,
                textStyle: TextStyle(fontSize: 22, fontFamily: "Irs"),
              ),
            ),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
