import 'package:flutter/material.dart';

//import global variables
import 'package:return_me/global.dart';
import 'package:return_me/widgets/bookingDetail.dart';

//import widgets
import 'package:return_me/widgets/customDrawer.dart';
import 'package:return_me/widgets/mapDraw.dart';
import 'package:return_me/widgets/noteToDriverWidget.dart';
import 'package:return_me/widgets/pickUpTimeWidget.dart';
import 'package:return_me/widgets/phoneNumberWidget.dart';

class Booking extends StatefulWidget {
  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  int _status;

  @override
  initState() {
    super.initState();
    _status = 0;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      child: Scaffold(
        drawer: CustomDrawer(),
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              MapDraw(),
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              bookingWidget(
                width: width,
                status: _status,
                setStatus: nextPage,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void nextPage(int status) {
    print("status +======== $status");
    print('$noteToDriver, $pickUpDatetime');
    setState(() {
      _status = status + 1;
    });
  }
}

Widget bookingWidget({
  int status,
  Function(int status) setStatus,
  double width,
}) {
  switch (status) {
    case 0:
      return BookingDetail(
          width: width,
          showNext: () {
            setStatus(0);
          });
      break;

    case 1:
      return phoneNumberWidget(
        showNext: () {
          setStatus(1);
        },
        label: "Phone Number",
        width: width,
      );
      break;

    case 2:
      return noteToDriverWidget(
        showNext: () {
          setStatus(2);
        },
        label: "Note to driver",
        width: width,
      );
      break;

    case 3:
      return PickUpTimeWidget(showNext: () {
        setStatus(3);
      });
      break;

    default:
      break;
  }
}
