import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'package:return_me/methods/squarePayment.dart';

import 'package:return_me/global.dart';

class PickUpTimeWidget extends StatefulWidget {
  final double width;
  final Function showNext;
  const PickUpTimeWidget({Key key, this.width, this.showNext})
      : super(key: key);

  @override
  _PickUpTimeWidgetState createState() => _PickUpTimeWidgetState();
}

class _PickUpTimeWidgetState extends State<PickUpTimeWidget> {
  bool _immeSelected;
  String _startTime;
  String _endTime;

  @override
  void initState() {
    super.initState();
    _immeSelected = true;
    var date = DateTime.now();
    pickUpDatetime = date;
    _calculateDate(date);
  }

  _calculateDate(DateTime date) {
    initializeDateFormatting('en_US', null).then((_) {
      var endDate = DateTime(
          date.year, date.month, date.day, date.hour, date.minute + 15);
      setState(() {
        _startTime = DateFormat.jm().format(date);
        _endTime = DateFormat.jm().format(endDate);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var immColor = (_immeSelected == true) ? Colors.blue[900] : Colors.grey;
    var schColor = (_immeSelected == false) ? Colors.blue[900] : Colors.grey;
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
        height: 650,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 16.0),
              child: Text(
                'Pick-up Time',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: immColor,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(3.0),
                  color:
                      (_immeSelected == true) ? Colors.white : Colors.grey[100],
                ),
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(
                            'IMMEDIATE PICK-UP',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: immColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(
                            'Get a ride in a minutes',
                            style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w300,
                              color: immColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Checkbox(
                      value: (_immeSelected == true) ? true : false,
                      onChanged: (value) {
                        if (value == true) {
                          pickUpDatetime = DateTime.now();
                          scheduleRide = false;
                          _calculateDate(pickUpDatetime);
                        }
                        setState(() {
                          _immeSelected = value;
                        });
                      },
                      fillColor: MaterialStateProperty.all<Color>(immColor),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 5.0, 16.0, 0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: schColor,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(3.0),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(
                            'SCHEDULE RIDE',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: schColor,
                            ),
                          ),
                        ),
                        Container(
                          width: width - 100,
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(
                            'Schedule your ride from 60 minutes in advance',
                            style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w300,
                              color: schColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Checkbox(
                      value: (_immeSelected == false) ? true : false,
                      onChanged: (value) {
                        if (value == true) {
                          scheduleRide = true;
                          setState(() {
                            _immeSelected = false;
                          });
                        }
                      },
                      fillColor: MaterialStateProperty.all<Color>(schColor),
                      checkColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16.0, 5.0, 16.0, 0),
              child: SizedBox(
                height: 300,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.dateAndTime,
                  onDateTimeChanged: (dateTime) {
                    pickUpDatetime = dateTime;
                    _calculateDate(pickUpDatetime);
                  },
                ),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
              child: Text(
                'Driver may arrive between $_startTime - $_endTime',
                style: TextStyle(fontSize: 15.0),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.only(top: 20.0),
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    print("@ @ @ @ @ @ @ @ @ Success @ @ @ @ @ @ @");
                    Navigator.pushNamed(context, '/paymentMethod');
                  },
                  child: Text(
                    'SET PICK-UP TIME',
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
                      Color.fromRGBO(251, 74, 70, 1.0),
                    ),
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
