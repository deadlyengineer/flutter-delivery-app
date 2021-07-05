import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:app_settings/app_settings.dart';
import 'package:square_in_app_payments/in_app_payments.dart';
import 'package:return_me/global.dart';
import 'package:return_me/methods/alertDialog.dart';
import 'package:return_me/methods/user.dart';
import 'package:return_me/methods/map.dart';

import '../labelconfig.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading;
  List<Permission> permission;
  BuildContext scaffoldcontext;

  @override
  void initState() {
    super.initState();
    initializeFlutterFire();
    _isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(body: Builder(
      builder: (BuildContext context) {
        scaffoldcontext = context;
        return (Container(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 118),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(54, 68, 54, 52),
                      child: Image(image: AssetImage('assets/images/logo.png')),
                    ),
                    Padding(
                      padding: EdgeInsets.zero,
                      child: (_isLoading == true)
                          ? CircularProgressIndicator(
                              semanticsLabel: 'loading',
                            )
                          : SizedBox(
                              height: 0,
                            ),
                    ),
                  ],
                ),
              ),
              (_isLoading == true)
                  ? SizedBox(
                      height: 0,
                    )
                  : Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 36, vertical: 41),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          TextButton(
                            style: new ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.grey[50]),
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                EdgeInsets.symmetric(
                                    vertical: 13, horizontal: 40),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/onBoarding');
                            },
                            child: Text(
                              'Sign up',
                              style: new TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(33, 64, 154, 1),
                              ),
                            ),
                          ),
                          TextButton(
                            style: new ButtonStyle(
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                EdgeInsets.symmetric(
                                    vertical: 13, horizontal: 40),
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  side: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/login');
                            },
                            child: Text(
                              'Log in',
                              style: new TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
            ],
          ),
        ));
      },
    ));
  }

  void initializeFlutterFire() async {
    await requestPermission();
    await InAppPayments.setSquareApplicationId(SQUARE_SANDBOX_APP_ID);
    await Firebase.initializeApp().then((_) {
      print('Firebase successfully initialized');
      FirebaseAuth.instance.authStateChanges().listen((User user) async {
        if (user == null) {
          print('User is currently signed out!');
        } else {
          print("user is currently signed in!");
          Navigator.pushNamed(context, '/pickup');
          print(user);
          var userEmail = user.email;
          email = userEmail;
          await getUserInfo(userEmail).then((_) {
            Navigator.pushNamed(context, '/pickup');
            print('User is signed in!');
          });
        }
        setState(() {
          _isLoading = false;
        });
      });
    });
  }

  Future<void> requestPermission() async {
    try {
      final PermissionStatus _permissionStatus =
          await Permission.location.request();

      print("permissionRequestResult: $_permissionStatus");
      if (_permissionStatus == PermissionStatus.granted) {
        checkInternet(scaffoldcontext, setCurrentPosition, false);
        print('granted');
      } else if (_permissionStatus == PermissionStatus.denied) {
        AppSettings.openLocationSettings();
        requestPermission();
      } else if (_permissionStatus == PermissionStatus.denied) {
        snackBarwithAction(scaffoldcontext, "Location permission is required",
            requestPermission);
      } else {
        print("permission not granted from splash");
      }
    } on Exception catch (e) {
      if (e.toString().contains("ERROR_ALREADY_REQUESTING_PERMISSIONS")) {
        checkInternet(scaffoldcontext, setCurrentPosition, false);
      }
      print("Exception in request Permssio $e");
    }
  }
}
