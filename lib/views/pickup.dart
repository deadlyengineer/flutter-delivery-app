import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:return_me/global.dart';
import 'package:return_me/methods/map.dart';
import 'package:return_me/widgets/textField.dart';
import 'package:return_me/widgets/mapWidgets.dart';
import 'package:return_me/widgets/customDrawer.dart';
import 'package:return_me/widgets/mapDraw.dart';

class PickupScreen extends StatefulWidget {
  @override
  _PickupScreenState createState() => _PickupScreenState();
}

class _PickupScreenState extends State<PickupScreen> {
  final addressController = TextEditingController();
  BitmapDescriptor pickUpLocationIcon;
  List<String> _addresses;
  bool _update;

  @override
  initState() {
    super.initState();
    _addresses = [];
    _update = false;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      height: height,
      width: width,
      child: SafeArea(
        child: Scaffold(
          drawer: CustomDrawer(),
          body: Stack(
            children: <Widget>[
              MapDraw(),
              myLocation(setCurrentPostion: () async {
                setCurrentPosition().then((String value) {
                  if (value == '') {
                    setState(() {
                      _update = true;
                    });
                  } else {
                    print(value);
                  }
                });
              }),
              bottomTextField(
                controller: addressController,
                label: 'Enter destination',
                width: width,
                suffixIcon: Icon(Icons.search),
                locationCallback: _getPositions,
                showFullSearchPanel: () {
                  Navigator.pushNamed(context, '/search');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  //get address from latitude and longitude
  Future<String> _getAddress(Position position) async {
    print("---------------- get address");
    try {
      List<Placemark> p =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = p[0];
      pickUpStreet = place.street;
      pickUpCity = place.locality;
      pickUpState = place.administrativeArea;
      pickUpZipcode = place.postalCode;

      return "$pickUpStreet $pickUpCity $pickUpState $pickUpZipcode";
    } catch (e) {
      print(e);
    }
  }

  // get position from address
  _getPositions(value) async {
    print("+++++++++ get position");
    if (value == '')
      setState(() {
        _addresses = [];
      });
    else {
      try {
        List<String> addresses = [];
        List<Location> locations = await locationFromAddress(value);
        print(locations);
        if (locations.length != null) {
          locations.forEach((location) async {
            print("${location.latitude}, ${location.longitude}");
            try {
              List<Placemark> p = await placemarkFromCoordinates(
                  location.latitude, location.longitude);
              Placemark place = p[0];
              addresses.add(
                  "${place.locality}, ${place.postalCode}, ${place.country}");
            } catch (e) {
              print(e);
            }
          });
        }

        setState(() {
          _addresses = addresses;
          mapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(locations[0].latitude, locations[0].longitude),
                zoom: 18.0,
              ),
            ),
          );
        });
      } catch (e) {
        print(e);
      }
    }
  }
}
