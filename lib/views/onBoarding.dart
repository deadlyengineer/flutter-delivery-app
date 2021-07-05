import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    const pageDecoration = const PageDecoration(
      bodyAlignment: Alignment.topCenter,
      contentMargin: const EdgeInsets.all(0),
      bodyFlex: 1,
    );

    const titleStyle = const TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );

    const bodyStyle = const TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    );

    return IntroductionScreen(
      globalBackgroundColor: Colors.grey[900],
      pages: [
        PageViewModel(
          titleWidget: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(32, 113, 0, 0),
                child: Text('Request a Ride', style: titleStyle),
              ),
            ],
          ),
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flexible(
                  child: Container(
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(32, 29, 78, 0),
                          child: Container(
                              child: Text(
                            'Request a ride get picked up by a nearby community driver',
                            style: bodyStyle,
                          )))))
            ],
          ),
          footer: SizedBox(
            height: 15.0,
          ),
          decoration: pageDecoration.copyWith(
            boxDecoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/onboard1.png'),
                fit: BoxFit.cover,
                colorFilter: const ColorFilter.mode(
                  Color.fromRGBO(255, 255, 255, 0.2),
                  BlendMode.dstATop,
                ),
              ),
              color: Color.fromRGBO(33, 64, 153, 1),
            ),
          ),
        ),
        PageViewModel(
          titleWidget: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(32, 113, 0, 0),
                child: Text('Vehicle Selection', style: titleStyle),
              ),
            ],
          ),
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(32, 29, 78, 0),
                    child: Container(
                      child: Text(
                        'Users have the liberty to choose the type of vehicle as per their need.',
                        style: bodyStyle,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          footer: SizedBox(
            height: 15.0,
          ),
          decoration: pageDecoration.copyWith(
            boxDecoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/onboard2.png'),
                fit: BoxFit.cover,
                colorFilter: const ColorFilter.mode(
                  Color.fromRGBO(255, 255, 255, 0.2),
                  BlendMode.dstATop,
                ),
              ),
              color: Color.fromRGBO(33, 64, 153, 1),
            ),
          ),
        ),
        PageViewModel(
          titleWidget: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(32, 113, 0, 0),
                child: Text('Live Ride Tracking', style: titleStyle),
              ),
            ],
          ),
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(32, 29, 78, 0),
                    child: Container(
                      child: Text(
                        'Know your driver in advance and be able to view current location in real time on the map',
                        style: bodyStyle,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          footer: SizedBox(
            height: 15.0,
          ),
          decoration: pageDecoration.copyWith(
            boxDecoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/onboard3.png'),
                fit: BoxFit.cover,
                colorFilter: const ColorFilter.mode(
                  Color.fromRGBO(255, 255, 255, 0.2),
                  BlendMode.dstATop,
                ),
              ),
              color: Color.fromRGBO(33, 64, 153, 1),
            ),
          ),
        ),
        PageViewModel(
          titleWidget: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(32, 113, 0, 0),
                child: Text('Trip Sharing', style: titleStyle),
              ),
            ],
          ),
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(32, 29, 78, 0),
                    child: Container(
                      child: Text(
                        'Passengers can share their ride details with family and friends for safety reasons.',
                        style: bodyStyle,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          footer: SizedBox(
            height: 15.0,
          ),
          decoration: pageDecoration.copyWith(
            boxDecoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/onboard4.png'),
                fit: BoxFit.cover,
                colorFilter: const ColorFilter.mode(
                  Color.fromRGBO(255, 255, 255, 0.2),
                  BlendMode.dstATop,
                ),
              ),
              color: Color.fromRGBO(33, 64, 153, 1),
            ),
          ),
        ),
      ],
      onDone: () {
        Navigator.pushNamed(context, '/signup');
      },
      showNextButton: true,
      next: new Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(15.0),
          color: const Color.fromRGBO(255, 170, 0, 1),
        ),
        padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 8.0),
        child: Text(
          'Next',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      done: new Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(15.0),
          color: const Color.fromRGBO(255, 170, 0, 1),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
        child: Text(
          'Finish',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      showSkipButton: true,
      skip: Text(
        "Skip",
        style: new TextStyle(
          color: Colors.white,
          fontSize: 15.0,
          fontWeight: FontWeight.w300,
        ),
      ),
      curve: Curves.easeIn,
      dotsDecorator: DotsDecorator(
        size: const Size.fromRadius(5.0),
        activeSize: const Size.fromRadius(5.0),
        activeColor: Colors.white,
        spacing: const EdgeInsets.symmetric(horizontal: 5.0),
      ),
      controlsPadding: const EdgeInsets.all(20.0),
      dotsContainerDecorator: BoxDecoration(
        color: Color.fromRGBO(34, 43, 69, 1),
      ),
    );
  }
}
