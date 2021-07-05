import 'package:flutter/material.dart';

//import global variables
import 'package:return_me/global.dart';
import 'package:return_me/widgets/bookingDetail.dart';

//import widgets
import 'package:return_me/widgets/customDrawer.dart';
import 'package:return_me/widgets/mapDraw.dart';
import 'package:return_me/widgets/noteToDriverWidget.dart';
import 'package:return_me/widgets/pickUpTimeWidget.dart';
import 'package:return_me/widgets/bookingWidget.dart';
import 'package:return_me/widgets/cancelConfirm.dart';

class Driver extends StatefulWidget {
  @override
  _DriverState createState() => _DriverState();
}

class _DriverState extends State<Driver> {
  int _status;

  @override
  initState() {
    super.initState();
    _status = 4;
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
              DriverWidget(
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

Widget DriverWidget({
  int status,
  Function(int status) setStatus,
  double width,
}) {
  switch (status) {
    case 4:
      return BookingLoadWidget(
        width: width,
        setStatus: () {
          setStatus(4);
        },
      );
      break;

    case 5:
      return bookingShowWidget(
        width: width,
        setStatus: () {
          setStatus(5);
        },
      );
      break;

    case 6:
      return cancelConfirm(setStatus: () {
        setStatus(6);
      });
      break;

    default:
      break;
  }
}
