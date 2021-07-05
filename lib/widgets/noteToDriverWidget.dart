import 'package:flutter/material.dart';
import 'package:return_me/global.dart';

class noteToDriverWidget extends StatelessWidget {
  final String label;
  final double width;
  final Function() showNext;

  const noteToDriverWidget({Key key, this.label,
    this.width,
    this.showNext}
  ) : super(key: key);

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
                'Note to driver',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 16.0, bottom: 27.0),
              child: Text(
                'Let driver know more about your requests.',
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _controller,
                onChanged: (value) {
                  noteToDriver = value;
                },
                decoration: new InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Eg: I'm in front of the bus stop",
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    color: Color.fromRGBO(143, 155, 179, 1.0),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400], width: 2),
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
                maxLines: 5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.only(top: 50.0),
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
