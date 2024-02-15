import 'package:flutter/material.dart';
import 'package:flutter_market/store/login/LoginStore.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class LoginPage extends StatelessWidget {
  final LoginStore store = LoginStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF061741), // Oxford Blue
      body: Observer(
        builder: (_) => store.isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image.asset('lib/view/assets/logo.png'),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        onChanged: (value) => store.email = value,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Color(0xFF094a87)), // Polynesian blue
                        ),
                        style: TextStyle(color: Color(0xFF094a87)), // Polynesian blue
                      ),
                      SizedBox(height: 10),
                      TextField(
                        onChanged: (value) => store.password = value,
                        obscureText: store.isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Color(0xFF094a87)), // Polynesian blue
                          suffixIcon: IconButton(
                            icon: Icon(
                              store.isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                                store.isPasswordVisible = !store.isPasswordVisible ;
                            },
                          ),
                        ),
                        style: TextStyle(color: Color(0xFF094a87)), // Polynesian blue
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: store.isFormValid ? store.signInWithEmailAndPassword : null,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color(0xFF78ed1a)), // Lawn green
                        ),
                        child: Text('Login'),
                      ),
                      if (store.errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            store.errorMessage!,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
