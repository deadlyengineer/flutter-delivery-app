import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:return_me/global.dart';

Future<void> getUserInfo(email) async {
  var body = jsonEncode({
    'id': 'login',
    'model': {'email': email}
  });
  await http.post(url, body: body).then((res) {
    if (res.statusCode == 200) {
      print(res.body);
      var userInfo = jsonDecode(res.body);
      firstName = userInfo['items'][0]['first_name'];
      lastName = userInfo['items'][0]['last_name'];
      userId = userInfo['items'][0]['id'];
    }
  });
}
