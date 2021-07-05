import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:return_me/global.dart';
import 'package:return_me/widgets/cancelConfirm.dart';

class DriverDetail extends StatefulWidget {
  DriverDetail({Key key}) : super(key: key);

  @override
  _DriverDetailState createState() => _DriverDetailState();
}

class _DriverDetailState extends State<DriverDetail> {
  bool _cancel;

  @override
  void initState() {
    super.initState();
    _cancel = false;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(34, 43, 69, 1.0),
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 50.0, 16.0, 20.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 60.0,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Driver on the way',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'x',
                                style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    child: Container(
                      height: height - 170,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(16.0, 0, 16.0, 30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20.0, right: 15.0),
                                  child: SizedBox(
                                    height: 100.0,
                                    width: 100.0,
                                    child: Stack(
                                      children: [
                                        Image(
                                          image: AssetImage(
                                              'assets/images/driver.png'),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Container(
                                            height: 16.0,
                                            width: 60.0,
                                            decoration: BoxDecoration(
                                              color: Colors.blue[900],
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: Text('Driver',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 11.0,
                                                ),
                                                textAlign: TextAlign.center),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      top: 20.0, left: 15.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Connor Chavez',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(Icons.star,
                                                size: 20.0,
                                                color: Colors.yellow[800]),
                                            Icon(Icons.star,
                                                size: 20.0,
                                                color: Colors.yellow[800]),
                                            Icon(Icons.star,
                                                size: 20.0,
                                                color: Colors.yellow[800]),
                                            Icon(Icons.star,
                                                size: 20.0,
                                                color: Colors.yellow[800]),
                                            Icon(Icons.star_outline,
                                                size: 20.0,
                                                color: Colors.yellow[800]),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'ST3751',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              TextSpan(
                                                text: '- Toyota Vios',
                                                style: TextStyle(
                                                  color: Colors.grey[500],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          DottedLine(),
                          Container(
                            padding: const EdgeInsets.only(top: 25.0),
                            width: double.infinity,
                            child: Text(
                              'FARE',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Colors.grey[500],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              "\$10.96",
                              style: TextStyle(
                                fontSize: 40,
                                color: Colors.blue[900],
                              ),
                            ),
                          ),
                          Container(
                            padding:
                                const EdgeInsets.only(top: 5.0, bottom: 10.0),
                            child: Text(
                              'incl. Tax',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 40.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Image(
                                      image: AssetImage(
                                          'assets/images/route.png')),
                                ),
                              ),
                              Container(
                                width: width - 70,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                        'PICK-UP',
                                        style: TextStyle(
                                          fontSize: 11.0,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        pickUpAddress,
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 15.0),
                                    Container(
                                      child: Text(
                                        'DROP-OFF',
                                        style: TextStyle(
                                          fontSize: 11.0,
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        dropOffAddress,
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Container(
                                width: double.infinity,
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _cancel = true;
                                    });
                                  },
                                  child: Text(
                                    'CANCEL BOOKING',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all<
                                            EdgeInsetsGeometry>(
                                        const EdgeInsets.symmetric(
                                            vertical: 16.0)),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Colors.grey[700],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              (_cancel == true)
                  ? cancelConfirm(
                      width: width,
                      height: height,
                      keepBooking: () {
                        setState(() {
                          _cancel = false;
                        });
                      },
                      cancelBooking: () {
                        Navigator.pushNamed(context, '/pickup');
                      })
                  : SizedBox(height: 0),
            ],
          ),
        ),
      ),
    );
  }
}
