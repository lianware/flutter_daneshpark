import 'SignupPage.dart';

import 'SendRequest.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Generate.dart';
import 'package:flutter/material.dart';

import 'Home.dart';
import 'CustomStyles.dart';

void main() {
  runApp(LoginPage());
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final _messengerKey = GlobalKey<ScaffoldMessengerState>();

  late SharedPreferences logindata;
  late bool newuser;
  @override
  void initState() {
    super.initState();
    checkAlreadyLogin();
  }

  void checkAlreadyLogin() async {
    logindata = await SharedPreferences.getInstance();
    if ((logindata.getBool('login') ?? true) == false) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _messengerKey,
      home: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "ورود",
              style: TextStyle(
                  fontFamily: "Irs", fontSize: 20, color: Colors.black45),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: LoginUI(
              context, _usernameController, _passwordController, _messengerKey),
        );
      }),
    );
  }
}

Widget LoginUI(
  BuildContext context,
  TextEditingController _usernameController,
  TextEditingController _passwordController,
  GlobalKey<ScaffoldMessengerState> _messengerKey,
) {
  return SingleChildScrollView(
    child: Center(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Container(
            height: 341,
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
                        "نام کاربری",
                        "کد ملی",
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
                      height: 70,
                    ),
                    TextButton(
                      onPressed: () {
                        if (_usernameController.text == "") {
                          Generate.showMySnackBar(
                              context,
                              "لطفا نام کاربری خود را وارد نمایید",
                              _messengerKey);
                        } else if (_passwordController.text == "") {
                          Generate.showMySnackBar(
                              context,
                              "لطفا کلمه عبور خود را وارد نمایید",
                              _messengerKey);
                        } else {
                          SendRequest.loginReq(
                              context: context,
                              username: _usernameController.text,
                              password: _passwordController.text,
                              messengerKey: _messengerKey);
                        }
                      },
                      child: Text('ورود'),
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10))),
                        fixedSize: Size(MediaQuery.of(context).size.width, 60),
                        primary: Colors.white,
                        backgroundColor: Colors.blueAccent,
                        textStyle: TextStyle(fontSize: 22, fontFamily: "Irs"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Signup(context)));
            },
            child: Text('ثبت نام'),
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 8,
              fixedSize: Size(MediaQuery.of(context).size.width - 70, 60),
              primary: Colors.blueAccent,
              backgroundColor: Colors.white,
              textStyle: TextStyle(fontSize: 22, fontFamily: "Irs"),
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    ),
  );
}
