import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:return_me/global.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                  child: Text('$firstName $lastName'),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Image(
              image: AssetImage(
                'assets/images/rides.png',
              ),
              width: 30.0,
            ),
            title: Text(
              'My rides',
              style: TextStyle(fontSize: 18.0),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/rides');
            },
          ),
          ListTile(
            leading: Image(
              image: AssetImage('assets/images/favorite.png'),
              width: 30.0,
            ),
            title: Text(
              'My favorites',
              style: TextStyle(fontSize: 18.0),
            ),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: Image(
              image: AssetImage('assets/images/payment.png'),
              width: 30.0,
            ),
            title: Text(
              'My payment',
              style: TextStyle(fontSize: 18.0),
            ),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: Image(
              image: AssetImage('assets/images/notification.png'),
              width: 30.0,
            ),
            title: Text(
              'Notification',
              style: TextStyle(fontSize: 18.0),
            ),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: Image(
              image: AssetImage('assets/images/support.png'),
              width: 30.0,
            ),
            title: Text(
              'Support',
              style: TextStyle(fontSize: 18.0),
            ),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: Text(
              'Log out',
              style: TextStyle(fontSize: 20.0),
            ),
            onTap: () async {
              try {
                await FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, '/');
              } catch (e) {
                print(e);
              }
            },
          ),
          ListTile(
            leading: Image(
              image: AssetImage('assets/images/drawer.png'),
              width: 200.0,
            ),
          )
        ],
      ),
    );
  }
}
