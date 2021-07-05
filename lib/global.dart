import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//initial values
CameraPosition initialLocation =
    CameraPosition(target: LatLng(0.0, 0.0), zoom: 15.0);

// CONSTANTS
const API_URL = "4return.me";
final url = Uri.https(API_URL, "/api/form.php");
final square_url = Uri.https(API_URL, "/square/process-card.php");
final delivery_url = Uri.https(API_URL, "/api/createDelivery.php");

// userInfo
String firstName;
String lastName;
String email;
String password;
String userId;
String phoneNumber;

// states
String pickUpName;
String pickUpStreet;
String pickUpCity;
String pickUpState;
String pickUpZipcode;
String pickUpAddress;
Marker pickUpMarker;
double pickUpLat;
double pickUpLng;
String pickUpPhoneNumber;

String dropOffName;
String dropOffAddress = "";
String dropOffStreet;
String dropOffCity;
String dropOffState;
String dropOffZipcode;
Marker dropOffMarker;
double dropOffLng;
double dropOffLat;
String dropOffPhoneNumber;

String noteToDriver;
DateTime pickUpDatetime;
Position currentPosition;
Position dropOffPosition;
Position pickUpPosition;
BitmapDescriptor pickUpIcon;
bool scheduleRide = false;

Set<Marker> markers = {};
GoogleMapController mapController;
Map<PolylineId, Polyline> polylines = {};

// delivery quote
String realPrice = '10.0';
String totalPrice;
String deliveryPrice;
String feeTax;
String feeService;
String quoteId;
String dropOffEta;
bool closekeyboard = true;

String item = "";
int productId = 0;
// String CUSTOMER_ID = 'cus_N2tUD1EBiKG_V-';
// String POSTMATES_API_KEY = "ea816055-7fd0-4022-8589-2fa9eb76abb7"; //test
// String POSTMATES_API_KEY = "48ff471b-7f6f-478a-806a-8af872ee9eae"; //production
