import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:return_me/global.dart';
import 'package:return_me/methods/alertDialog.dart';
import 'package:square_in_app_payments/in_app_payments.dart';
import 'package:built_collection/built_collection.dart';
import 'package:return_me/labelconfig.dart' as label;
import 'package:square_in_app_payments/models.dart';
import 'package:http/http.dart' as http;
import 'package:return_me/widgets/cardWidget.dart';
import 'package:return_me/models/creditCard.dart';
import 'package:return_me/methods/delivery.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({Key key}) : super(key: key);

  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  bool _isLoading = true;
  List<CreditCard> cards;
  int _selectedCard;

  @override
  void initState() {
    super.initState();
    cards = [];
    _getCardList();
  }

  Future<void> _getCardList() async {
    var body = jsonEncode({
      'model': 'getCards',
      'email': email,
    });
    await http.post(square_url, body: body).then((response) {
      if (response.statusCode == 200) {
        print(response.body);
        var body = jsonDecode(response.body);
        print(body);
        for (var i = 0; i < body.length; i++) {
          CreditCard newCard = CreditCard.fromJson(body[i]);
          cards.add(newCard);
        }
        setState(() {
          cards = cards;
          _isLoading = false;
          _selectedCard = 0;
        });
      } else {
        print('error');
      }
    });
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> makePayment(String cardId) async {
    var body = jsonEncode({
      'model': 'card',
      'email': email,
      'card_id': cardId,
      'amount': realPrice,
    });
    print(cardId);
    await http.post(square_url, body: body).then((response) {
      print(response);
      if (response.statusCode == 200) {
        print(response.body);
        if (response.body == "") {
          print('succcess');
        } else
          print(response.body);
      }
    });
  }

  Future<void> _onStartCardEntryFlow() async {
    await InAppPayments.startCardEntryFlow(
        onCardNonceRequestSuccess: _onCardEntryCardNonceRequestSuccess,
        onCardEntryCancel: _onCancelCardEntryFlow);
  }

  void _onCancelCardEntryFlow() {
    print("cancel");
  }

  void _onCardEntryCardNonceRequestSuccess(CardDetails result) async {
    try {
      print(result);
      print(result.nonce);

      var body = jsonEncode({
        'model': 'nonce',
        'email': email,
        'nonce': result.nonce,
        'amount': totalPrice,
      });
      await http.post(square_url, body: body).then((response) {
        print(response.statusCode);
        if (response.statusCode == 200) {
          var body = jsonDecode(response.body);
          print(body);
          if (body['success'] == true) {
            CreditCard newCard = CreditCard.fromJson(body['data']);
            cards.add(newCard);
            setState(() {
              cards = cards;
            });
          } else {
            alertDialog(
                context: context, content: body['data'], title: 'Alert');
          }
        }
      }).timeout(Duration(seconds: 5), onTimeout: () {
        print('timeout');
      });

      InAppPayments.completeCardEntry(onCardEntryComplete: () {
        print("CardEntryComplete");
      });
    } on Exception catch (ex) {
      // payment failed to complete due to error
      // notify card entry to show processing error
      InAppPayments.showCardNonceProcessingError(ex.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: (_isLoading == true)
          ? Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Stack(
                children: [
                  Container(
                    padding:
                        EdgeInsets.only(left: 16.0, top: 10.0, right: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  // Navigator.pushNamed(context, '/home');
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.black,
                                  size: 21.0,
                                  semanticLabel: 'back',
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  CreditCard selectedCard =
                                      cards[_selectedCard];
                                  await makePayment(selectedCard.id);
                                  await productsAdd().then((res) {
                                    Navigator.pushNamed(context, '/driver');
                                  });
                                },
                                child: Text(
                                  'Done',
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
                            'Payment methods',
                            style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(34, 43, 69, 1),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            'CURRENT METHOD',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        (cards.length > 0)
                            ? InkWell(
                                onTap: () {
                                  setState(() {
                                    _selectedCard = 0;
                                  });
                                },
                                child: CardWidget(
                                  card: cards[0],
                                  isCheked: true,
                                  isSelected: false,
                                ),
                              )
                            : SizedBox(
                                height: 50.0,
                                child: Text(
                                  'No saved card.',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.grey[900],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 16.0),
                          child:
                              Text('''Choose desired vehicle type. We offer cars
                    suitable for most every day needs'''),
                        ),
                        (cards.length > 1)
                            ? Flexible(
                                child: ListView.builder(
                                    itemCount: cards.length - 1,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            _selectedCard = index + 1;
                                          });
                                        },
                                        child: CardWidget(
                                          isCheked: false,
                                          isSelected:
                                              ((index + 1) == _selectedCard)
                                                  ? true
                                                  : false,
                                          card: cards[index + 1],
                                        ),
                                      );
                                    }),
                              )
                            : SizedBox(
                                height: 0,
                              ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      margin: const EdgeInsets.only(bottom: 16.0),
                      width: MediaQuery.of(context).size.width - 20,
                      child: TextButton(
                        onPressed: () {
                          _onStartCardEntryFlow();
                        },
                        child: Text(
                          'ADD PAYMENT METHOD',
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
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
