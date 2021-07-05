import 'package:flutter/material.dart';
import 'package:return_me/global.dart';

Widget BookingDetail({double width, Function() showNext}) {
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
      height: 300.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width,
            padding: const EdgeInsets.only(top: 8.0, left: 16.0),
            child: Text(
              'Confirm details',
              style: TextStyle(fontSize: 10.0, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 247, 247, 1.0),
                border: Border.all(
                  color: Colors.blue[900],
                  style: BorderStyle.solid,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, left: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 15.0),
                          width: 15.0,
                          child: Image(
                            image: AssetImage('assets/images/route.png'),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10.0),
                          width: width - 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Text(
                                      'PICK-UP',
                                      style: TextStyle(
                                        fontSize: 10.0,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: width - 100,
                                    child: Text(
                                      '$pickUpCity $pickUpState, $pickUpZipcode',
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 18.0),
                                    child: Text(
                                      'DESTINATION',
                                      style: TextStyle(
                                        fontSize: 10.0,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: width - 100,
                                    child: Text(
                                      '$dropOffCity $dropOffState, $dropOffZipcode',
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, left: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(0),
                              child: Text(
                                'Standard',
                                style: TextStyle(fontSize: 15.0),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 3.0),
                              child: Text(
                                'Package until 30 pounds',
                                style: TextStyle(
                                  fontSize: 10.0,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 10.0),
                              width: width - 200,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '\$$realPrice',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.blue[900],
                                    ),
                                  ),
                                  // Row(
                                  //   children: [
                                  //     Icon(
                                  //       Icons.timer,
                                  //       size: 12.0,
                                  //     ),
                                  //     Text(
                                  //       "$dropOffEta dropoff",
                                  //       style: TextStyle(fontSize: 12.0),
                                  //     ),
                                  //   ],
                                  // )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              padding: const EdgeInsets.only(top: 10.0),
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  showNext();
                },
                child: Text(
                  'BOOK NOW - TOTAL \$$realPrice',
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
        ],
      ),
    ),
  );
}
