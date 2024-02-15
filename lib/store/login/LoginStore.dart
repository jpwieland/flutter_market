import 'package:mobx/mobx.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'LoginStore.g.dart'; // Arquivo gerado pelo MobX

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  final FirebaseAuth firebaseAuth;

  _LoginStore({FirebaseAuth? firebaseAuth})
      : this.firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @observable
  String email = '';

  @observable
  String password = '';

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @computed
  bool get isFormValid => email.isNotEmpty && password.isNotEmpty;

  @action
  Future<void> signInWithEmailAndPassword() async {
    if (isFormValid) {
      isLoading = true;
      errorMessage = null;

      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } on FirebaseAuthException catch (e) {
        errorMessage = e.message;
      }

      isLoading = false;
    }
  }
}
