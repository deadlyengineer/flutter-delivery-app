import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:return_me/global.dart';

class phoneNumberWidget extends StatelessWidget {
  final String label;
  final double width;
  final Function() showNext;

  const phoneNumberWidget({Key key, this.label, this.width, this.showNext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            boxShadow: [
              BoxShadow(color: Colors.grey, offset: Offset(0.0, -1.0)),
            ]),
        width: width,
        height: 350.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 16.0),
              child: Text(
                'Phone Number',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
              child: Text(
                'Pickup',
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.grey[700],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: InternationalPhoneNumberInput(
                onInputChanged: (PhoneNumber number) {
                  pickUpPhoneNumber = number.phoneNumber;
                },
                onInputValidated: (bool value) {
                  print(value);
                },
                selectorConfig: SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                ),
                ignoreBlank: false,
                autoValidateMode: AutovalidateMode.disabled,
                initialValue: PhoneNumber(isoCode: 'US'),
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
                  labelText: 'PICKUP PHONE NUMBER',
                  labelStyle: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(137, 146, 164, 1),
                  ),
                ),
                spaceBetweenSelectorAndTextField: 8,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
              child: Text(
                'DropOff',
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.grey[700],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: InternationalPhoneNumberInput(
                onInputChanged: (PhoneNumber number) {
                  dropOffPhoneNumber = number.phoneNumber;
                },
                onInputValidated: (bool value) {
                  print(value);
                },
                selectorConfig: SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                ),
                ignoreBlank: false,
                autoValidateMode: AutovalidateMode.disabled,
                initialValue: PhoneNumber(isoCode: 'US'),
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
                  labelText: 'DROPOFF PHONE NUMBER',
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
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.only(top: 40.0),
                width: double.infinity,
                child: TextButton(
                  onPressed: showNext,
                  child: Text(
                    'CONFIRM',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromRGBO(251, 74, 70, 1.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
