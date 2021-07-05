import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:return_me/models/creditCard.dart';

class CardWidget extends StatelessWidget {
  final CreditCard card;
  final bool isCheked;
  final bool isSelected;

  const CardWidget({Key key, this.card, this.isCheked, this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    Image cardImage;
    switch (this.card.cardBrand) {
      case 'VISA':
        cardImage = Image(
          image: AssetImage('assets/images/visa.png'),
          width: 50.0,
        );
        break;
      case 'MASTERCARD':
        cardImage = Image(
          image: AssetImage('assets/images/masterCard.png'),
          width: 50.0,
        );
        break;
      case 'AMERICAN_EXPRESS':
        cardImage = Image(
          image: AssetImage('assets/images/americanExpress.png'),
          width: 50.0,
        );
        break;
      case 'DISCOVER':
        cardImage = Image(
          image: AssetImage('assets/images/discover.png'),
          width: 50.0,
        );
        break;
      default:
        cardImage = Image(
          image: AssetImage('assets/images/visa.png'),
          width: 50.0,
        );
        break;
    }
    return Container(
      width: width - 20,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 16.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            spreadRadius: 3.0,
            blurRadius: 2.0,
            color: Colors.grey[200],
          ),
          (this.isSelected == true)
              ? BoxShadow(
                  spreadRadius: 1.0,
                  color: Colors.red[900],
                )
              : BoxShadow(spreadRadius: 0.0),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          cardImage,
          SizedBox(
            width: 15.0,
          ),
          Container(
            width: width - 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '**** **** **** ${this.card.last4}',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  'Expires ${this.card.expMonth}/${this.card.expYear}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13.0,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 15.0,
          ),
          (this.isCheked == true)
              ? Checkbox(
                  value: true,
                  onChanged: (value) {},
                  fillColor: MaterialStateProperty.all(
                    Colors.red[500],
                  ),
                )
              : SizedBox(
                  width: 50.0,
                ),
        ],
      ),
    );
  }
}
