import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:return_me/models/order.dart';
import 'package:return_me/global.dart';

Future<bool> getDeliveryQuote() async {
  print("getDeliveryQuote");
  bool result = false;
  var body = jsonEncode({
    "id": "getDeliveryQuote",
    "model": {
      "pickup_zipcode": pickUpZipcode,
      "pickup_address": pickUpStreet,
      "pickup_lat": pickUpLat,
      "pickup_lng": pickUpLng,
      "pickup_city": pickUpCity,
      "pickup_state": pickUpState,
      "dropoff_zipcode": dropOffZipcode,
      "dropoff_address": dropOffStreet,
      "dropoff_lat": dropOffLat,
      "dropoff_lng": dropOffLng,
      "dropoff_city": dropOffCity,
      "dropoff_state": dropOffState,
    }
  });
  var res = await http.post(url, body: body);
  if (res.statusCode == 200) {
    print(res.body);
    var response = jsonDecode(res.body);
    if (response['success'] == true) {
      quoteId = response['items']['id'];
      totalPrice = response['items']['total'];
      deliveryPrice = response['items']['feedelivery'];
      feeTax = response['items']['feetax'];
      feeService = response['items']['feeservice'];
      realPrice = (double.parse(totalPrice) * 1.2).toStringAsFixed(2);
      DateTime dateTime = DateTime.parse(response['items']['dropoff_eta']);
      initializeDateFormatting('en_US', null).then((_) {
        dropOffEta = DateFormat.jm().format(dateTime);
      });
      result = true;
    } else {
      result = false;
    }
  } else {
    result = false;
  }
  return result;
}

Future<String> productsAdd() async {
  String result = '';
  var body = jsonEncode({
    'id': 'productsadd',
    'model': {
      'idUser': userId,
      'name': "$firstName $lastName",
      'pickup_zipcode': pickUpZipcode,
      'pickup_address': pickUpAddress,
      'pickup_lat': pickUpLat,
      'pickup_lng': pickUpLng,
      'pickup_city': pickUpCity,
      'pickup_state': pickUpState,
      'dropoff_zipcode': dropOffZipcode,
      'dropoff_address': dropOffAddress,
      'dropoff_lat': dropOffLat,
      'dropoff_lng': dropOffLng,
      'dropoff_city': dropOffCity,
      'dropoff_state': dropOffState
    },
  });
  await http.post(url, body: body).then((res) {
    print(res.body);
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      if (body['success'] == true) {
        print('success, ${body["msg"]}');
        productId = body['msg'];
        result = "success";
      } else {
        print(body['msg']);
        result = body['mag'];
      }
    }
  });
  return result;
}

Future<String> createDelivery() async {
  String result = '';
  var body = jsonEncode({
    'id': 'create',
    'model': {
      'dropOffAddress': dropOffAddress,
      'dropOffPhoneNumber': dropOffPhoneNumber,
      'dropOffName': dropOffName,
      'pickUpAddress': pickUpAddress,
      'pickUpPhoneNumber': pickUpPhoneNumber,
      'pickUpName': pickUpName,
      'manifest': "Product return",
      'pickUpDateTime': (scheduleRide == true)
          ? pickUpDatetime.toUtc().toIso8601String()
          : "none",
      'noteToDriver': noteToDriver,
      'productId': productId
    }
  });

  await http.post(delivery_url, body: body).then((res) {
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      if (body['success'] == true) {
        print(body['delivery_id']);
        var deliveryId = body['delivery_id'];
        result = deliveryId;
      }
    } else {
      result = "${res.statusCode}";
      print("${res.statusCode}");
    }
  });
  return result;
}

Future<String> cancelDelivery(String deliveryId) async {
  String result = "";
  var body = jsonEncode({
    'id': 'cancel',
    'model': {
      'deliveryId': deliveryId,
    }
  });
  print(body);
  await http.post(delivery_url, body: body).then((res) {
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      print(body);
      if (body['success'] == true)
        result = 'success';
      else {
        String msg = body['msg'].toString();
        result = msg;
      }
    } else {
      result = "fail";
    }
  });
  return result;
}

Future<List<Order>> getUpComingDelivery() async {
  List<Order> result = [];
  var body = jsonEncode({
    'id': 'list',
    'model': {
      'userId': userId,
    }
  });
  print(body);
  await http.post(delivery_url, body: body).then((res) {
    if (res.statusCode == 200) {
      print(res.body);
      var body = jsonDecode(res.body);
      if (body['success'] == true) {
        var deliveryies = body['data'];
        for (var delivery in deliveryies) {
          result.add(Order.fromJson(delivery));
        }
      } else {
        result = [];
      }
    } else {
      result = [];
    }
  });
  return result;
}
