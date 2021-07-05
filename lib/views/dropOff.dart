import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:return_me/global.dart';
import 'package:return_me/methods/delivery.dart';
import 'package:return_me/methods/map.dart';
import 'package:return_me/methods/alertDialog.dart';
import 'package:return_me/widgets/customDrawer.dart';

class DropOff extends StatefulWidget {
  DropOff({Key key}) : super(key: key);

  @override
  _DropOffState createState() => _DropOffState();
}

class _DropOffState extends State<DropOff> {
  bool _update;
  bool _isLoading;
  LatLng _initialPosition;

  @override
  void initState() {
    super.initState();
    _update = false;
    _isLoading = false;
    if (item == 'dropOff') _initialPosition = LatLng(dropOffLat, dropOffLng);
    if (item == 'pickUp') _initialPosition = LatLng(pickUpLat, pickUpLng);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height,
      child: Scaffold(
        drawer: CustomDrawer(),
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _initialPosition,
                  zoom: 17.0,
                ),
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                mapType: MapType.normal,
                zoomGesturesEnabled: true,
                zoomControlsEnabled: false,
                markers: (markers != null) ? (Set<Marker>.from(markers)) : null,
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                },
                onLongPress: (latLng) {
                  if (item == 'dropOff') {
                    dropOffLat = latLng.latitude;
                    dropOffLng = latLng.longitude;
                    getAddressFromCoordinate(latLng).then((String address) {
                      markDestination(address);
                      dropOffAddress = address;
                      setState(() {
                        _update = !_update;
                      });
                    });
                  }

                  if (item == 'pickUp') {
                    pickUpLat = latLng.latitude;
                    pickUpLng = latLng.longitude;
                    getAddressFromCoordinate(latLng).then((String address) {
                      markPickUp(address);
                      pickUpAddress = address;
                      setState(() {
                        _update = !_update;
                      });
                    });
                  }
                },
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 40.0,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back_ios_outlined),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Container(
                        width: width - 50,
                        child: Text(
                          "$dropOffAddress",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              (item == 'dropOff')
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, -1.0)),
                            ]),
                        width: width,
                        height: 180.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20.0, left: 16.0),
                              child: Text(
                                'Choose a Destination',
                                style: TextStyle(
                                    fontSize: 28.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, left: 16.0, bottom: 10.0),
                              child: Text(
                                'Please select a valid destination location on the map.',
                                style: TextStyle(
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Container(
                                padding: const EdgeInsets.only(top: 10.0),
                                width: double.infinity,
                                child: (_isLoading == false)
                                    ? TextButton(
                                        onPressed: () async {
                                          setState(() {
                                            _isLoading = true;
                                          });
                                          await drawRoute();
                                          await getDeliveryQuote()
                                              .then((bool quoteStatus) {
                                            setState(() {
                                              _isLoading = false;
                                            });
                                            if (quoteStatus == true)
                                              Navigator.pushNamed(
                                                  context, '/booking');
                                            else {
                                              String title = "Unknown Error!";
                                              String content =
                                                  "Please try again after a few minutes.";
                                              alertDialog(
                                                  context: context,
                                                  title: title,
                                                  content: content);
                                            }
                                          });
                                        },
                                        child: Text(
                                          'SET DESTINATION',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        style: ButtonStyle(
                                          padding: MaterialStateProperty.all<
                                                  EdgeInsetsGeometry>(
                                              const EdgeInsets.symmetric(
                                                  vertical: 16.0)),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Color.fromRGBO(
                                                      251, 74, 70, 1.0)),
                                        ),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircularProgressIndicator(),
                                        ],
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : SizedBox(
                      height: 0,
                    ),
              (item == "pickUp")
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, -1.0)),
                            ]),
                        width: width,
                        height: 180.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20.0, left: 16.0),
                              child: Text(
                                'Choose a Pickup',
                                style: TextStyle(
                                    fontSize: 28.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, left: 16.0, bottom: 10.0),
                              child: Text(
                                'Please select a valid pickup location on the map.',
                                style: TextStyle(
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Container(
                                padding: const EdgeInsets.only(top: 10.0),
                                width: double.infinity,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/search');
                                  },
                                  child: (_isLoading == false)
                                      ? Text(
                                          'SET PICKUP',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      : CircularProgressIndicator(),
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all<
                                            EdgeInsetsGeometry>(
                                        const EdgeInsets.symmetric(
                                            vertical: 16.0)),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color.fromRGBO(251, 74, 70, 1.0)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : SizedBox(
                      height: 0,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
