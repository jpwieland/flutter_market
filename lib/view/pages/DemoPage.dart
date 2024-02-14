import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DemoPage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You are logged in!'),
            ElevatedButton(
              onPressed: () => _signOut(context),
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
