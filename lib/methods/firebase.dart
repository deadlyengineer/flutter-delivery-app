// Sign up user to firebase
import 'package:firebase_auth/firebase_auth.dart';

Future<void> registerUserToFirebase(String email, String password) async {
  print('firebase');
  try {
    print(email + '------' + password);
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    print(userCredential);
  } on FirebaseException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    } else if (e.code == 'operation-not-allowed') {
      print("operation-not-allowed");
    }
  } catch (e) {
    print(e);
  }
}
