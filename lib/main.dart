import 'package:flutter/material.dart';
import 'package:return_me/views/home.dart';
import 'package:return_me/views/login.dart';
import 'package:return_me/views/onBoarding.dart';
import 'package:return_me/views/signup.dart';
import 'package:return_me/views/signupDone.dart';
import 'package:return_me/views/pickup.dart';
import 'package:return_me/views/search.dart';
import 'package:return_me/views/passwordReset.dart';
import 'package:return_me/views/phoneNumberInput.dart';
import 'package:return_me/views/checkCode.dart';
import 'package:return_me/views/booking.dart';
import 'package:return_me/views/driverDetail.dart';
import 'package:return_me/views/rides.dart';
import 'package:return_me/views/dropOff.dart';
import 'package:return_me/views/paymentMethod.dart';
import 'package:return_me/views/driver.dart';

void main() {
  runApp(
    MaterialApp(
      color: Colors.white,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/onBoarding': (context) => OnBoardingScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/signupDone': (context) => SignupDoneScreen(),
        '/pickup': (context) => PickupScreen(),
        '/search': (context) => SearchScreen(),
        '/passwordReset': (context) => PasswordReset(),
        '/phoneNumberInput': (context) => PhoneNumberInput(),
        '/checkCode': (context) => CheckCode(),
        '/booking': (context) => Booking(),
        '/driverDetail': (context) => DriverDetail(),
        '/rides': (context) => Rides(),
        '/dropOff': (context) => DropOff(),
        '/paymentMethod': (context) => PaymentMethodScreen(),
        '/driver': (context) => Driver(),
      },
    ),
  );
}
