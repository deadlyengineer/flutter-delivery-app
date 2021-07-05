import 'package:flutter/material.dart';

import 'package:return_me/methods/firebase.dart';

import '../global.dart';

class SignupDoneScreen extends StatefulWidget {
  SignupDoneScreen({Key key}) : super(key: key);

  @override
  _SignupDoneScreenState createState() => _SignupDoneScreenState();
}

class _SignupDoneScreenState extends State<SignupDoneScreen> {
  bool _isLoading;

  @override
  void initState() {
    _isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        decoration: new BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/home_back.png'),
            fit: BoxFit.cover,
            colorFilter: new ColorFilter.mode(
              Color.fromRGBO(255, 255, 255, 0.2),
              BlendMode.dstATop,
            ),
          ),
          color: Color.fromRGBO(33, 64, 153, 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 107),
              child: Icon(
                Icons.check_circle_outline_outlined,
                size: 100,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Container(
                width: double.infinity,
                child: Text(
                  'You are ready to go!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(31, 20, 31, 40),
              child: Container(
                width: double.infinity,
                child: Text(
                  "Thanks for taking your time to create account with us. Now this is the fun part, let's explore the app.",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.zero,
              child: TextButton(
                onPressed: () {
                  _isLoading = true;
                  registerUserToFirebase(email, password);
                },
                child: (_isLoading == false)
                    ? Text(
                        'GET STARTED',
                        style: TextStyle(
                          color: Color.fromRGBO(33, 64, 154, 1),
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : CircularProgressIndicator(),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(horizontal: 30.0, vertical: 12.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
