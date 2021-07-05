import 'dart:ui';

import 'package:flutter/material.dart';

Widget cancelConfirm({
  double width,
  double height,
  Function() keepBooking,
  Function() cancelBooking,
  Function() setStatus,
}) {
  return Stack(
    children: [
      Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Color.fromRGBO(20, 20, 20, 0.7),
        ),
      ),
      Align(
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
          height: 430.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 50.0),
                child: Image(
                  image: AssetImage('assets/images/cancelAlert.png'),
                  width: 60.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Text(
                  'CANCEL THIS RIDE.',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Text(
                  'Passengers that cancel less get faster bookings.',
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  padding: const EdgeInsets.only(top: 50.0),
                  width: double.infinity,
                  child: TextButton(
                    onPressed: keepBooking,
                    child: Text(
                      'KEEP THE BOOKING',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.symmetric(vertical: 16.0)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromRGBO(251, 74, 70, 1.0)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  padding: const EdgeInsets.only(top: 10.0),
                  width: double.infinity,
                  child: TextButton(
                    onPressed: cancelBooking,
                    child: Text(
                      'CANCEL RIDE',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(251, 74, 70, 1.0)),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide(
                            color: Color.fromRGBO(251, 74, 70, 1.0),
                          ),
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
