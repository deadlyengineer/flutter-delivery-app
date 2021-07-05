import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:return_me/methods/user.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;
  bool _isError;
  bool _isLoading;

  @override
  void initState() {
    super.initState();
    _isError = false;
    _isLoading = false;
    email = '';
    password = '';
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const darkMode = false;
    var width = MediaQuery.of(context).size.width;
    // const AuthButtonType buttonType = AuthButtonType.secondary;
    // const AuthIconType authIconType = AuthIconType.secondary;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.only(left: 16.0, top: 10.0, right: 16.0),
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
                          Navigator.pushNamed(context, '/onBoarding');
                        },
                        child: Text(
                          'Sign Up',
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
                    'Log in',
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
                          setState(() {
                            email = value;
                          });
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
                          setState(() {
                            password = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                (_isError == true)
                    ? Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(color: Colors.red),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Image(
                                  image: AssetImage('assets/images/alert.png'),
                                ),
                              ),
                              Container(
                                color: Color.fromRGBO(255, 246, 246, 1),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                width: width - 100,
                                child: Text(
                                  'Your email or password are incorrect. Please try again!',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : SizedBox(
                        height: 0,
                      ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/passwordReset');
                    },
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(33, 64, 157, 1),
                      ),
                    ),
                  ),
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
                              _login();
                            },
                            child: Text(
                              'Log in',
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
                Padding(
                  padding: EdgeInsets.only(top: 25.0),
                  child: Container(
                    child: Text(
                      'Or connect using social account',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(34, 43, 67, 1),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 15.0),
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/phoneNumberInput');
                    },
                    icon: Icon(
                      Icons.phone,
                      color: Colors.red,
                      size: 27.0,
                    ),
                    label: Text(
                      'Sign in with Phone number',
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.symmetric(vertical: 15.0),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      shadowColor:
                          MaterialStateProperty.all<Color>(Colors.grey),
                    ),
                  ),
                ),
                // Container(
                //   padding: EdgeInsets.only(bottom: 15.0),
                //   width: double.infinity,
                //   child: AppleAuthButton(
                //     onPressed: () {},
                //     darkMode: darkMode,
                //   ),
                // ),
                Container(
                  padding: EdgeInsets.only(bottom: 15.0),
                  width: double.infinity,
                  child: GoogleAuthButton(
                    onPressed: () {
                      signInWithGoogle();
                    },
                    darkMode: darkMode,
                  ),
                ),
                // Container(
                //   padding: EdgeInsets.only(bottom: 25.0),
                //   width: double.infinity,
                //   child: FacebookAuthButton(
                //     onPressed: () {},
                //     darkMode: darkMode,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Sign in with email and password
  Future<void> _login() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      getUserInfo(userCredential.user.email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          _isLoading = false;
          _isError = true;
        });
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        setState(() {
          _isLoading = false;
          _isError = true;
        });
        print('Wrong password provided for that user.');
      }
    }
  }

  // Sign in with google account
  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    getUserInfo(userCredential.user.email);
  }
}
