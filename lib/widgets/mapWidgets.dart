import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:return_me/global.dart';

Widget myLocation({
  Function() setCurrentPostion,
}) {
  return SafeArea(
    child: Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0, bottom: 200.0),
        child: InkWell(
          splashColor: Colors.orange, // inkwell color
          child: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    spreadRadius: 1.0,
                    color: Colors.grey[500],
                  )
                ]),
            child: Image(
              image: AssetImage('assets/images/myLocation.png'),
            ),
          ),
          onTap: () {
            setCurrentPostion();
            mapController.moveCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                    target: LatLng(pickUpLat, pickUpLng), zoom: 17.0),
              ),
            );
          },
        ),
      ),
    ),
  );
}

Widget zoomButton({GoogleMapController mapController}) {
  return SafeArea(
    child: Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ClipOval(
            child: Material(
              color: Colors.blue[100], // button color
              child: InkWell(
                splashColor: Colors.blue, // inkwell color
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Icon(Icons.add),
                ),
                onTap: () {
                  mapController.animateCamera(
                    CameraUpdate.zoomIn(),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 20),
          ClipOval(
            child: Material(
              color: Colors.blue[100], // button color
              child: InkWell(
                splashColor: Colors.blue, // inkwell color
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Icon(Icons.remove),
                ),
                onTap: () {
                  mapController.animateCamera(
                    CameraUpdate.zoomOut(),
                  );
                },
              ),
            ),
          )
        ],
      ),
    ),
  );
}
