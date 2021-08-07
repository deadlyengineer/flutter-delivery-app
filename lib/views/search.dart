import 'dart:async';
import 'dart:math';

import 'package:google_api_headers/google_api_headers.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:return_me/widgets/flutter_google_places.dart';
import 'package:flutter_google_places/flutter_google_places.dart'
    as default_google_places;
import 'package:return_me/global.dart';
import 'package:return_me/methods/map.dart';
import 'package:return_me/labelConfig.dart';

const kGoogleApiKey = APIKey;

GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AddLocationView();
  }
}

class AddLocationView extends PlacesAutocompleteWidget {
  AddLocationView()
      : super(
          apiKey: kGoogleApiKey,
          sessionToken: Uuid().generateV4(),
          language: "en",
          strictbounds: false,
          types: [],
          components: [Component(Component.country, "us")],
        );

  @override
  _AutoCompleteState createState() => _AutoCompleteState();
}

class _AutoCompleteState extends PlacesAutocompleteState {
  final searchScaffoldKey = GlobalKey<ScaffoldState>();
  List latLng;
  List<String> addresses;
  List<String> names;
  bool _isLoading;
  bool _isSearching;
  String searchingItem;

  @override
  void initState() {
    super.initState();
    PlacesAutocompleteState.focus = false;
    PlacesAutocompleteWidget.isRegister = false;
    searchingItem = '';
    _isLoading = true;
    _isSearching = false;
    addresses = [];
    names = [];
    latLng = [];
    _searchNearByPlaces();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      key: searchScaffoldKey,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0),
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey[400],
                    offset: Offset(0.0, 3.0),
                    spreadRadius: -1.0,
                  )
                ],
                color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/pickup');
                          },
                          icon: Icon(Icons.arrow_back)),
                      IconButton(
                        icon: Icon(Icons.map_outlined),
                        onPressed: () {
                          if (dropOffLat != null && dropOffLng != null) {
                            dropOffLat = pickUpLat;
                            dropOffLng = pickUpLng;
                            markDestination(
                                "$pickUpName $pickUpStreet $pickUpCity $pickUpZipcode");
                          }
                          Navigator.pushNamed(context, '/dropOff');
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 40.0,
                        height: 80.0,
                        child: Image(
                          image: AssetImage('assets/images/route.png'),
                        ),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: width - 80,
                              decoration: BoxDecoration(
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    offset: Offset(0.0, 1.0),
                                    color: Colors.grey,
                                    spreadRadius: -1.0,
                                  ),
                                ],
                                color: Colors.white,
                              ),
                              child: (searchingItem == "pickUp")
                                  ? AppBarPlacesAutoCompleteTextField(
                                      onChange: (value) {
                                        if (value == "")
                                          setState(() {
                                            _isSearching = false;
                                          });
                                        else
                                          setState(() {
                                            _isSearching = true;
                                          });
                                      },
                                      hintText: 'Enter Pickup',
                                      avoidUnderline: true,
                                    )
                                  : Container(
                                      padding: EdgeInsets.only(
                                        top: 13.0,
                                        bottom: 13.0,
                                        left: 10.0,
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          item = 'pickUp';
                                          setState(() {
                                            searchingItem = 'pickUp';
                                            PlacesAutocompleteState.focus =
                                                true;
                                          });
                                        },
                                        child: Text(
                                          '$pickUpAddress',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              width: width - 80,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: width - 120,
                                    child: (searchingItem == "dropOff")
                                        ? AppBarPlacesAutoCompleteTextField(
                                            onChange: (value) {
                                              if (value == "")
                                                setState(() {
                                                  _isSearching = false;
                                                });
                                              else
                                                setState(() {
                                                  _isSearching = true;
                                                });
                                            },
                                            hintText: 'Enter Destination',
                                            avoidUnderline: true,
                                          )
                                        : Container(
                                            padding: EdgeInsets.only(
                                                left: 10.0,
                                                top: 10.0,
                                                bottom: 13.0),
                                            child: InkWell(
                                              onTap: () {
                                                item = 'dropOff';
                                                setState(() {
                                                  searchingItem = 'dropOff';
                                                  PlacesAutocompleteState
                                                      .focus = true;
                                                });
                                              },
                                              child: Text((dropOffAddress == "")
                                                  ? 'Enter Destination'
                                                  : dropOffAddress),
                                            ),
                                          ),
                                  ),
                                  // Container(
                                  //   decoration: BoxDecoration(
                                  //     color: Colors.white,
                                  //     boxShadow: <BoxShadow>[
                                  //       BoxShadow(
                                  //         color: Colors.grey,
                                  //         offset: Offset(-1.0, 0.0),
                                  //         spreadRadius: -1.0,
                                  //       )
                                  //     ],
                                  //   ),
                                  //   width: 40.0,
                                  //   child: IconButton(
                                  //     icon: Icon(
                                  //       Icons.add,
                                  //       size: 25.0,
                                  //     ),
                                  //     onPressed: () {
                                  //       Navigator.pushNamed(
                                  //           context, '/booking');
                                  //     },
                                  //   ),
                                  // )
                                  // PlacesAutocompleteField(apiKey: kGoogleApiKey)
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            (_isSearching == false)
                ? Expanded(
                    child: (_isLoading == true)
                        ? Container(
                            width: double.infinity,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: (addresses.length > 0) ? ListView.builder(
                              itemCount: addresses.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(top: 5.0),
                                  decoration: BoxDecoration(
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        offset: Offset(0.0, 1.0),
                                        color: Colors.grey[500],
                                        spreadRadius: -1.0,
                                      ),
                                    ],
                                    color: Colors.white,
                                  ),
                                  child: InkWell(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.location_on_outlined,
                                          color: Colors.blue[900],
                                          size: 35.0,
                                        ),
                                        Container(
                                          height: 60.0,
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          width: width - 100,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${names[index]}',
                                                style: TextStyle(
                                                  fontSize: 17.0,
                                                ),
                                              ),
                                              SizedBox(height: 5.0),
                                              Text(
                                                '${addresses[index]}',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 13.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    onTap: () async {
                                      await getAddressFromCoordinate(
                                              latLng[index])
                                          .then((String address) {
                                        item = 'dropOff';
                                        dropOffAddress = address;
                                        dropOffLat = latLng[index].latitude;
                                        dropOffLng = latLng[index].longitude;
                                        markDestination(address);
                                        Navigator.pushNamed(
                                            context, '/dropOff');
                                      });
                                    },
                                  ),
                                );
                              },
                            ) : Container(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('No nearby places found.')
                                ],
                              )
                            ),
                          ),
                  )
                : Expanded(
                    flex: 3,
                    child: PlacesAutocompleteResult(
                      onTap: (p) {
                        displayPrediction(p, searchScaffoldKey.currentState);
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  @override
  void onResponseError(PlacesAutocompleteResponse response) {
    super.onResponseError(response);
  }

  @override
  void onResponse(PlacesAutocompleteResponse response) {
    super.onResponse(response);
  }

  Future<void> _searchNearByPlaces() async {
    GoogleMapsPlaces _places = GoogleMapsPlaces(
      apiKey: kGoogleApiKey,
    );
    Location pickUpLocation = Location(lat: pickUpLat, lng: pickUpLng);
    print(pickUpLocation);
    var responses = [];
    final PlacesSearchResponse fedExResults = await _places
        .searchNearbyWithRankBy(pickUpLocation, 'distance', keyword: "FedEx")
        .timeout(Duration(seconds: 15), onTimeout: () {
      print("FedEx timeout");
      return null;
    });
    print(fedExResults.results);
    if(fedExResults != null)
      responses = responses + fedExResults.results;
    final PlacesSearchResponse upsResults = await _places
        .searchNearbyWithRankBy(pickUpLocation, 'distance', keyword: 'UPS')
        .timeout(Duration(seconds: 15), onTimeout: () {
      print("UPS timeout");
      return null;
    });
    if(upsResults != null)
      responses = responses + upsResults.results;
    final PlacesSearchResponse uspsResults = await _places
        .searchNearbyWithRankBy(pickUpLocation, 'distance', keyword: 'USPS')
        .timeout(Duration(seconds: 15), onTimeout: () {
      print("USPS timeout");
      return null;
    });
    if(uspsResults != null)
      responses = responses + uspsResults.results;
    for (var i = 0; i < responses.length; i++) {
      double lat = responses[i].geometry.location.lat;
      double lng = responses[i].geometry.location.lng;
      await getAddressFromCoordinate(LatLng(lat, lng))
          .then((String value) {
            latLng.add(LatLng(lat, lng));
            addresses.add(value);
            names.add(responses[i].name);
      });
    }
    setState(() {
      latLng = latLng;
      addresses = addresses;
      names = names;
      _isLoading = false;
    });
  }

  Future<Null> displayPrediction(Prediction p, ScaffoldState scaffold) async {
    if (p != null) {
      GoogleMapsPlaces _places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await GoogleApiHeaders().getHeaders(),
      );
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId);
      final lat = detail.result.geometry.location.lat;
      final lng = detail.result.geometry.location.lng;
      if (searchingItem == "dropOff") {
        dropOffAddress = p.description;
        dropOffLat = lat;
        dropOffLng = lng;
        markDestination(p.reference);
        Navigator.pushNamed(context, '/dropOff');
      }
      if (searchingItem == 'pickUp') {
        pickUpAddress = p.description;
        pickUpLat = lat;
        pickUpLng = lng;
        markPickUp(p.reference);
        Navigator.pushNamed(context, '/dropOff');
      }
    }
  }
}

class Uuid {
  final Random _random = Random();

  String generateV4() {
    final int special = 8 + _random.nextInt(4);

    return '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}-'
        '${_bitsDigits(16, 4)}-'
        '4${_bitsDigits(12, 3)}-'
        '${_printDigits(special, 1)}${_bitsDigits(12, 3)}-'
        '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}';
  }

  String _bitsDigits(int bitCount, int digitCount) =>
      _printDigits(_generateBits(bitCount), digitCount);

  int _generateBits(int bitCount) => _random.nextInt(1 << bitCount);

  String _printDigits(int value, int count) =>
      value.toRadixString(16).padLeft(count, '0');
}
