import 'package:flutter/material.dart';

Widget bottomTextField({
  TextEditingController controller,
  String label,
  double width,
  Widget suffixIcon,
  Function(String) locationCallback,
  Function() showFullSearchPanel,
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
      height: 180.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 16.0),
            child: Text(
              'Where do you need to return a purchase?',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 16.0, bottom: 27.0),
            child: Text(
              'Book a return on demand or pre-scheduled',
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: InkWell(
              onTap: showFullSearchPanel,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 10.0,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey[400],
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 0,
                    ),
                    Icon(Icons.search_outlined),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
