import 'dart:io';

import 'package:flutter/material.dart';
import 'package:return_me/methods/delivery.dart';
import 'package:return_me/models/order.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Rides extends StatefulWidget {
  const Rides({Key key}) : super(key: key);

  @override
  _RidesState createState() => _RidesState();
}

class _RidesState extends State<Rides> {
  String _tab;
  List<Order> orders;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    _tab = 'upComing';
    orders = [];
    _getUpComingRides();
  }

  void _getUpComingRides() async {
    print("GET RIDES");
    await getUpComingDelivery().then((deliveries) {
      setState(() {
        orders = [...orders, ...deliveries];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var activeTextStyle = new TextStyle(
      color: Colors.blue[900],
      fontSize: 15.0,
      fontWeight: FontWeight.bold,
    );
    var inactiveTextStyle = new TextStyle(
      color: Colors.grey[400],
      fontSize: 15.0,
      fontWeight: FontWeight.bold,
    );
    var boxDecoration = new BoxDecoration(
      color: Colors.white,
      boxShadow: <BoxShadow>[
        BoxShadow(
          offset: Offset(0, 3.0),
          color: Colors.blue[800],
          spreadRadius: -1.0,
        )
      ],
    );

    return Container(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                              size: 21.0,
                              semanticLabel: 'back',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Text(
                        'My orders',
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(34, 43, 69, 1),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: (_tab == 'upComing')
                                ? boxDecoration
                                : BoxDecoration(),
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  _tab = 'upComing';
                                });
                              },
                              child: Text(
                                'UPCOMING',
                                style: (_tab == 'upComing')
                                    ? activeTextStyle
                                    : inactiveTextStyle,
                              ),
                            ),
                          ),
                          Container(
                            decoration: (_tab == 'completed')
                                ? boxDecoration
                                : BoxDecoration(),
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  _tab = 'completed';
                                });
                              },
                              child: Text(
                                'COMPLETED',
                                style: (_tab == 'completed')
                                    ? activeTextStyle
                                    : inactiveTextStyle,
                              ),
                            ),
                          ),
                          Container(
                            decoration: (_tab == 'canceled')
                                ? boxDecoration
                                : BoxDecoration(),
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  _tab = 'canceled';
                                });
                              },
                              child: Text(
                                'CANCELED',
                                style: (_tab == 'canceled')
                                    ? activeTextStyle
                                    : inactiveTextStyle,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                decoration:
                    BoxDecoration(color: Colors.white, boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey[300],
                    offset: Offset.fromDirection(1.0),
                  )
                ]),
              ),
              SizedBox(height: 10.0),
              (orders.length == 0)
                  ? Container(
                      padding: const EdgeInsets.all(16.0),
                      width: double.infinity,
                      color: Colors.blue[800],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'You have no upcoming',
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.white),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/pickup');
                            },
                            child: Text(
                              'GET STARTED',
                              style: TextStyle(
                                color: Colors.blue[800],
                                fontSize: 15.0,
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                            ),
                          )
                        ],
                      ))
                  : Expanded(
                      flex: 1,
                      child: ListView.builder(
                          itemCount: orders.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    spreadRadius: 2.0,
                                    blurRadius: 2.0,
                                    color: Colors.grey[200],
                                  )
                                ],
                              ),
                              margin: EdgeInsets.all(16.0),
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(orders[index].dropOffEta),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 200.0,
                                    child: WebView(
                                      initialUrl: 'https://flutter.dev',
                                      javascriptMode:
                                          JavascriptMode.unrestricted,
                                      onProgress: (int progress) {
                                        print(
                                            "WebView is loading (Progress: $progress%)");
                                      },
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'STANDARD',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Price',
                                        style: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 15.0,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.location_on_outlined,
                                            size: 15.0,
                                          ),
                                          Text(orders[index].status)
                                        ],
                                      ),
                                      Text(
                                        "${orders[index].fee} ${orders[index].currency}",
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          }),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
