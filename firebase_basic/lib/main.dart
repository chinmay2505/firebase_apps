import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  MyHomePage({Key key}) : super(key: key);

  Future<UserCredential> _signIn() async {
    GoogleSignInAccount _googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication _googleSignInAuthentication =
        await _googleSignInAccount.authentication;

    // Create a new credential
    final GoogleAuthCredential _credential = GoogleAuthProvider.credential(
      accessToken: _googleSignInAuthentication.accessToken,
      idToken: _googleSignInAuthentication.idToken,
    );

    UserCredential _user = await _auth.signInWithCredential(_credential);

    print(_user.user.displayName);
  }

  void _signOut() {
    _googleSignIn.signOut();
    print("User Signed Out");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Demo"),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            RaisedButton(
              onPressed: () => _signIn(),
              child: Text("Google Sign-in"),
              color: Colors.green,
            ),
            SizedBox(
              height: 25.0,
            ),
            RaisedButton(
              onPressed: () => _signOut(),
              child: Text("Sign-out"),
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
