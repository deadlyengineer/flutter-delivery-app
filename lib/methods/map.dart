import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:connectivity/connectivity.dart';
import 'package:return_me/methods/alertDialog.dart';

import '../global.dart' as global;
import '../labelconfig.dart';
import '../states.dart' as states;

void markDestination(String description) {
  global.dropOffMarker = Marker(
    markerId: MarkerId(description),
    position: LatLng(global.dropOffLat, global.dropOffLng),
    infoWindow: InfoWindow(
      title: 'Drop Off',
      snippet: description,
    ),
    icon: BitmapDescriptor.defaultMarker,
  );
  Set<Marker> tempMarker = {};
  tempMarker.add(global.pickUpMarker);
  tempMarker.add(global.dropOffMarker);
  global.markers = tempMarker;
  print(global.markers);
}

void markPickUp(String description) {
  global.pickUpMarker = Marker(
    markerId: MarkerId(description),
    position: LatLng(global.pickUpLat, global.pickUpLng),
    infoWindow: InfoWindow(
      title: "Pick Up",
      snippet: description,
    ),
    icon: BitmapDescriptor.defaultMarker,
  );
  Set<Marker> tempMarker = {};
  tempMarker.add(global.pickUpMarker);
  global.markers = tempMarker;
}

Future<String> getAddressFromCoordinate(LatLng latLng) async {
  print("---------------- get address");
  try {
    List<Placemark> p =
        await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    Placemark place = p[0];
    global.dropOffName = place.name;
    global.dropOffStreet = place.street;
    global.dropOffCity = place.locality;
    global.dropOffState = states.states[place.administrativeArea.toUpperCase()];
    global.dropOffZipcode = place.postalCode;

    return "${global.dropOffStreet}, ${global.dropOffCity}, ${global.dropOffState} ${global.dropOffZipcode}";
  } catch (e) {
    print(e);
  }
}

Future<void> drawRoute() async {
  PolylinePoints polylinePoints;
  List<LatLng> polylineCoordinates = [];

  print("Drow route");
  polylinePoints = PolylinePoints();
  PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      APIKey,
      PointLatLng(
          global.currentPosition.latitude, global.currentPosition.longitude),
      PointLatLng(global.dropOffLat, global.dropOffLng));
  print(result.points);
  if (result.points.isNotEmpty) {
    print(result.points);
    result.points.forEach((PointLatLng point) {
      polylineCoordinates.add(LatLng(point.latitude, point.longitude));
    });
  }

  PolylineId id = PolylineId('poly');

  Polyline polyline = Polyline(
    polylineId: id,
    color: Colors.red,
    points: polylineCoordinates,
    width: 3,
  );

  global.polylines[id] = polyline;
}

Future<bool> checkInternet(
    BuildContext context, Function verify, bool toastShow) async {
  closeMessage(context);
  bool internetConnect = await checkConnectivity();
  if (internetConnect != null && internetConnect) {
    verify();
  } else {
    if (toastShow == null) {
    } else if (toastShow) {
      alertDialog(
          context: context,
          content: "You are currently offline",
          title: 'Network Error');
    } else {
      print('eeeeeee');
    }
  }
  return Future.value(internetConnect);
}

closeMessage(BuildContext context) {
  if (global.closekeyboard) {
    Scaffold.of(context).hideCurrentSnackBar();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  } else {
    global.closekeyboard = true;
  }
}

Future<bool> checkConnectivity() async {
  try {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      return true;
    }
  } on PlatformException catch (e) {
    print(e.toString());
  }
  return false;
}

Future<String> setCurrentPosition() async {
  print('++++++++ set current position');
  try {
    Position position = await Geolocator.getCurrentPosition();
    global.pickUpLat = position.latitude;
    global.pickUpLng = position.longitude;
    await _getAddress(position).then((_) {
      global.currentPosition = position;
      markPickUp("${global.pickUpName}, ${global.pickUpCity}");
    });
    return "";
  } catch (e) {
    return e;
  }
}

Future<void> _getAddress(Position position) async {
  print("---------------- get address");
  try {
    List<Placemark> p =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = p[0];
    print("PLACE");
    print(jsonEncode(place));
    global.pickUpName = place.name;
    global.pickUpStreet = place.street;
    global.pickUpCity = place.locality;
    global.pickUpState = states.states[place.administrativeArea.toUpperCase()];
    global.pickUpZipcode = place.postalCode;
    global.pickUpAddress =
        "${place.street}, ${global.pickUpState} ${global.pickUpZipcode}";
  } catch (e) {
    print(e);
  }
}
