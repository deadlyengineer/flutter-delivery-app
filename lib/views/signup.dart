import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:http/http.dart' as http;
import 'package:return_me/methods/alertDialog.dart';

import '../global.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String countryCode;
  String phoneNumber;
  String initialCountry = "US";
  String addressLine1;
  String addressLine2;
  String districtLevel1;
  String postalCode;
  String locality;
  PhoneNumber number = PhoneNumber(isoCode: 'US');
  bool _isLoading;

  @override
  void initState() {
    super.initState();
    phoneNumber = '';
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    const defaultText = TextStyle(
      fontSize: 13.0,
      fontWeight: FontWeight.w400,
      color: Color.fromRGBO(34, 43, 67, 1),
    );
    const linkText = TextStyle(
      fontSize: 13.0,
      fontWeight: FontWeight.w400,
      color: Color.fromRGBO(34, 43, 67, 1),
      decoration: TextDecoration.underline,
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(left: 16.0, top: 10.0, right: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          // Navigator.pop(context);
                          Navigator.pushNamed(context, '/');
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                          size: 21.0,
                          semanticLabel: 'back',
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Text(
                          'Log in',
                          style: TextStyle(
                            color: Color.fromRGBO(33, 64, 154, 1),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(34, 43, 69, 1),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 31.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 8,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              textCapitalization: TextCapitalization.words,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey[50],
                                  ),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 5.0,
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
                                labelText: 'FIRST NAME',
                                labelStyle: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(137, 146, 164, 1),
                                ),
                              ),
                              style: TextStyle(
                                height: 1.7,
                              ),
                              onChanged: (value) {
                                firstName = value;
                              },
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: SizedBox(
                          height: 0,
                        ),
                      ),
                      Flexible(
                        flex: 8,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              textCapitalization: TextCapitalization.words,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey[50],
                                  ),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 5.0,
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
                                labelText: 'LAST NAME',
                                labelStyle: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(137, 146, 164, 1),
                                ),
                              ),
                              style: TextStyle(
                                height: 1.7,
                              ),
                              onChanged: (value) {
                                lastName = value;
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[50],
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 5.0,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          labelText: 'EMAIL',
                          labelStyle: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(137, 146, 164, 1),
                          ),
                        ),
                        style: TextStyle(
                          height: 1.7,
                        ),
                        onChanged: (value) {
                          email = value;
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: InternationalPhoneNumberInput(
                    onInputChanged: (PhoneNumber number) {
                      phoneNumber = number.phoneNumber;
                    },
                    onInputValidated: (bool value) {},
                    selectorConfig: SelectorConfig(
                      selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                    ),
                    ignoreBlank: false,
                    autoValidateMode: AutovalidateMode.disabled,
                    initialValue: number,
                    formatInput: false,
                    keyboardType: TextInputType.numberWithOptions(
                      signed: true,
                      decimal: true,
                    ),
                    keyboardAction: TextInputAction.next,
                    inputDecoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 5.0,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[50]),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      labelText: 'PHONE NUMBER',
                      labelStyle: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(137, 146, 164, 1),
                      ),
                    ),
                    spaceBetweenSelectorAndTextField: 8,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[50],
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 5.0,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          labelText: 'ADDRESS 1',
                          labelStyle: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(137, 146, 164, 1),
                          ),
                        ),
                        style: TextStyle(
                          height: 1.7,
                        ),
                        onChanged: (value) {
                          addressLine1 = value;
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[50],
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 5.0,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          labelText: 'ADDRESS 2',
                          labelStyle: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(137, 146, 164, 1),
                          ),
                        ),
                        style: TextStyle(
                          height: 1.7,
                        ),
                        onChanged: (value) {
                          addressLine2 = value;
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[50],
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 5.0,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          labelText: 'CITY',
                          labelStyle: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(137, 146, 164, 1),
                          ),
                        ),
                        style: TextStyle(
                          height: 1.7,
                        ),
                        onChanged: (value) {
                          locality = value;
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[50],
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 5.0,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          labelText: 'STATE',
                          labelStyle: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(137, 146, 164, 1),
                          ),
                        ),
                        style: TextStyle(
                          height: 1.7,
                        ),
                        onChanged: (value) {
                          districtLevel1 = value;
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[50],
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 5.0,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          labelText: 'ZIP CODE',
                          labelStyle: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(137, 146, 164, 1),
                          ),
                        ),
                        style: TextStyle(
                          height: 1.7,
                        ),
                        onChanged: (value) {
                          postalCode = value;
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[50],
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 5.0,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          labelText: 'PASSWORD',
                          labelStyle: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(137, 146, 164, 1),
                          ),
                        ),
                        style: TextStyle(
                          height: 1.7,
                        ),
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.0),
                  child: Container(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'By clicking "Sign Up" you agree to ',
                            style: defaultText,
                          ),
                          TextSpan(
                            text: 'our terms and conditions ',
                            style: linkText,
                            // recognizer: TapGestureRecognizer()..onTap = () {},
                          ),
                          TextSpan(
                            text: 'as well as our ',
                            style: defaultText,
                          ),
                          TextSpan(
                            text: 'privacy policy',
                            style: linkText,
                            // recognizer: TapGestureRecognizer()..onTap = () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Container(
                    width: double.infinity,
                    child: (_isLoading == false)
                        ? TextButton(
                            onPressed: () {
                              setState(() {
                                _isLoading = true;
                              });
                              _signup();
                            },
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromRGBO(251, 74, 70, 1)),
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                EdgeInsets.symmetric(vertical: 16.0),
                              ),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                            ],
                          ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Sign up to return.me
  Future<void> _signup() async {
    print(firstName + lastName + email + phoneNumber + password);
    await http
        .post(url,
            body: jsonEncode({
              'id': 'signup',
              "model": {
                "first_name": firstName,
                'last_name': lastName,
                'email': email,
                'phone': phoneNumber,
                'addressLine1': addressLine1,
                'addressLine2': addressLine2,
                'locality': locality,
                'districtLevel1': districtLevel1,
                'postalCode': postalCode,
                'password': password
              }
            }))
        .then((res) {
      if (res.statusCode == 200) {
        print(res.body);
        var response = jsonDecode(res.body);
        if (response['success'] == true) {
          setState(() {
            _isLoading = false;
          });
          Navigator.pushNamed((context), '/signupDone');
        } else {
          alertDialog(
            context: context,
            title: 'Alert',
            content: response['msg'],
          );
          setState(() {
            _isLoading = false;
          });
        }
      }
    }).catchError((err) {
      print(err);
    });
  }
}
