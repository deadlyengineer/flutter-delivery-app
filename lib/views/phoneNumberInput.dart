import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';

class PhoneNumberInput extends StatefulWidget {
  PhoneNumberInput({Key key}) : super(key: key);

  @override
  _PhoneNumberInputState createState() => _PhoneNumberInputState();
}

class _PhoneNumberInputState extends State<PhoneNumberInput> {
  var _pinTextController =  TextEditingController();
  String phoneNumber;
  String initialCountry = "US";
  PhoneNumber number = PhoneNumber(isoCode: 'US');
  FirebaseAuth auth = FirebaseAuth.instance;
  bool _codeSent;
  String _verificationId;
  String _code;
  int _resendToken;

  @override
  void initState() {
    super.initState();
    phoneNumber = '';
    _verificationId = '';
    _codeSent = false;
    _code = '';
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                          size: 21.0,
                          semanticLabel: 'back',
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: Text(
                    (_codeSent == false)
                        ? 'What is your phone number'
                        : 'Verify phone',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(34, 43, 69, 1),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                    width: width,
                    child: (_codeSent == false)
                        ? Text(
                            'Tap "Get Started" to get an SMS confirmation to help you use RUBER. We would like your phone number.',
                            style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        : RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      'Check your SMS messages. We`ve sent you the PIN at ',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 17.0),
                                ),
                                TextSpan(
                                  text: ' $phoneNumber',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: (_codeSent == false)
                      ? InternationalPhoneNumberInput(
                          onInputChanged: (PhoneNumber number) {
                            setState(() {
                              phoneNumber = number.phoneNumber;
                            });
                            print(phoneNumber);
                          },
                          onInputValidated: (bool value) {
                            print(value);
                          },
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
                          keyboardAction: TextInputAction.done,
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
                        )
                      : PinCodeFields(
                          controller: _pinTextController,
                          length: 6,
                          fieldBorderStyle: FieldBorderStyle.Square,
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          borderRadius: BorderRadius.circular(5.0),
                          autoHideKeyboard: false,
                          onComplete: (value) {
                            setState(() {
                              _code = value;
                            });
                          },
                        ),
                ),
                (_codeSent == true)
                    ? Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Don`t receive SMS?',
                              style: TextStyle(fontSize: 17.0),
                            ),
                            TextButton(
                              child: Text(
                                "Resend Code",
                                style: TextStyle(
                                    fontSize: 17.0, color: Colors.blue[900]),
                              ),
                              onPressed: () {
                                _pinTextController.clear();
                                _verifyPhoneNumber();
                              },
                            ),
                          ],
                        ))
                    : SizedBox(
                        height: 0,
                      ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Container(
                    width: double.infinity,
                    child: (_codeSent == false)
                        ? TextButton(
                            onPressed: () {
                              _verifyPhoneNumber();
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.red),
                                padding: MaterialStateProperty.all<
                                    EdgeInsetsGeometry>(
                                  EdgeInsets.symmetric(vertical: 16.0),
                                )),
                            child: Text(
                              'Continue',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : TextButton(
                            onPressed: () async {
                              PhoneAuthCredential credential =
                                  PhoneAuthProvider.credential(
                                      verificationId: _verificationId,
                                      smsCode: _code);
                              print(credential);
                              await auth.signInWithCredential(credential);
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.red),
                                padding: MaterialStateProperty.all<
                                    EdgeInsetsGeometry>(
                                  EdgeInsets.symmetric(vertical: 16.0),
                                )),
                            child: Text(
                              'Verify',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _verifyPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(

      phoneNumber: phoneNumber,
      timeout: Duration(seconds: 60),
      forceResendingToken: (_resendToken != '') ? _resendToken : null,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
        print('completed');
      },
      verificationFailed: (FirebaseAuthException e) {
        print('failed');
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid');
        }
      },
      codeSent: (String verificationId, int resendToken) async {
        setState(() {
          _verificationId = verificationId;
          _codeSent = true;
          _resendToken = resendToken;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
