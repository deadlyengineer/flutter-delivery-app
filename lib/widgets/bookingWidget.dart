import 'dart:async';

import 'package:flutter/material.dart';
import 'package:return_me/methods/delivery.dart';
import 'package:slider_button/slider_button.dart';
import 'package:return_me/methods/alertDialog.dart';

class BookingLoadWidget extends StatefulWidget {
  final double width;
  final Function setStatus;
  const BookingLoadWidget({Key key, this.width, this.setStatus})
      : super(key: key);

  @override
  _BookingLoadWidgetState createState() => _BookingLoadWidgetState();
}

class _BookingLoadWidgetState extends State<BookingLoadWidget> {
  var deliveryId;

  @override
  void initState() {
    super.initState();
    deliveryId = "";
    _book();
  }

  void _book() async {
    print("BOOKING");
    await createDelivery().then((delId) {
      print("Create delivery");
      print(delId);
      setState(() {
        deliveryId = delId;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            boxShadow: [
              BoxShadow(color: Colors.grey, offset: Offset(0.0, -1.0)),
            ]),
        width: widget.width,
        height: 250.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: CircularProgressIndicator()
                // Image(
                //   image: AssetImage('assets/images/loading.png'),
                // ),
                ),
            Container(
              padding: const EdgeInsets.only(top: 13.0),
              child: Text('WE ARE PROCESSING YOUR BOOKING...',
                  style:
                      TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
            ),
            Container(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                'Your order will start soon',
                style: TextStyle(fontSize: 17.0),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 34.0),
              child: SliderButton(
                action: () async {
                  print("action start");
                  print(deliveryId);
                  await cancelDelivery(deliveryId).then((String res) {
                    print(res);
                    if (res == 'success')
                      Navigator.pushNamed(context, '/pickup');
                    else
                      alertDialog(
                        context: context,
                        content: res,
                        title: 'Alert',
                      );
                  });
                },
                label: Text(
                  'SLIDE TO CANCEL',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                icon: Text(
                  '×',
                  style: TextStyle(
                    color: Colors.blueGrey[300],
                    fontSize: 40.0,
                  ),
                ),
                width: widget.width - 80,
                height: 50.0,
                backgroundColor: Colors.blueGrey[300],
                // radius: 20.0,
                shimmer: false,
                buttonSize: 46.0,
                dismissThresholds: 0.7,
                boxShadow: BoxShadow(offset: Offset(0.0, 0.0)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget bookingShowWidget({
  double width,
  Function() showDriverDetail,
  Function() setStatus,
}) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          boxShadow: [
            BoxShadow(color: Colors.grey, offset: Offset(0.0, -1.0)),
          ]),
      width: width,
      height: 350.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 25.0),
            child: Text(
              'WE FOUND YOU A DRIVER',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 14.0),
            child: Text(
              'Driver will pickup your package in 02:35',
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.blue[900],
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 33.0),
            width: 270,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.phone),
                  ),
                ),
                InkWell(
                  onTap: showDriverDetail,
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: Stack(
                      children: [
                        Image(
                          image: AssetImage('assets/images/driver.png'),
                          width: 100,
                          height: 100,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 15,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.blue[900],
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              'Driver',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Colors.grey[500],
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.message_rounded),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              'Conner Chavez',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: 100,
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.star, size: 20.0, color: Colors.yellow[800]),
                Icon(Icons.star, size: 20.0, color: Colors.yellow[800]),
                Icon(Icons.star, size: 20.0, color: Colors.yellow[800]),
                Icon(Icons.star, size: 20.0, color: Colors.yellow[800]),
                Icon(Icons.star_outline, size: 20.0, color: Colors.yellow[800]),
              ],
            ),
          ),
          Container(
              padding: const EdgeInsets.only(top: 10.0),
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: 'ST3751',
                  style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text: ' - Toyota Vios',
                  style: TextStyle(color: Colors.grey[500]),
                )
              ])))
        ],
      ),
    ),
  );
}
