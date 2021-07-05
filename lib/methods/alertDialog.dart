import 'package:flutter/material.dart';

void alertDialog({
  BuildContext context,
  String title,
  String content,
}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            "$title",
            textAlign: TextAlign.center,
          ),
          content: new Text("$content"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}

void snackBarwithAction(BuildContext context, String value, Function() listenForPermissionStatus) {
  ScaffoldMessenger
      .of(context)
      .showSnackBar(
      new SnackBar(content: new Text(value,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
            fontSize: 15.0,
          )
      ),
        action: SnackBarAction(
          label: 'Retry',

          onPressed: () {
            listenForPermissionStatus();
          },
        ),
        duration: Duration(hours: 1),))
      .closed
      .then((reason) {
    if (reason == SnackBarClosedReason.swipe)
      snackBarwithAction(context, value, listenForPermissionStatus);
  });
}