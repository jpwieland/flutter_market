import 'package:flutter_market/store/login/LoginStore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Crie os mocks utilizando o mocktail
class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockUserCredential extends Mock implements UserCredential {}
class MockAuthCredential extends Mock implements AuthCredential {}

void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late LoginStore loginStore;

  setUpAll(() {
    registerFallbackValue(MockAuthCredential());
  });

  setUp(() {
    // Inicialize os mocks e o LoginStore
    mockFirebaseAuth = MockFirebaseAuth();
    loginStore = LoginStore(firebaseAuth: mockFirebaseAuth); // Ajuste aqui conforme a injeção de dependência da sua classe

    // Substitua a instância padrão de FirebaseAuth pelo mock
    when(() => mockFirebaseAuth.signInWithEmailAndPassword(
      email: any(named: 'email'),
      password: any(named: 'password'),
    )).thenAnswer((_) async => MockUserCredential());
  });

  test('Initial values are correct', () {
    expect(loginStore.email, '');
    expect(loginStore.password, '');
    expect(loginStore.isFormValid, false);
  });

  test('Can change email and password', () {
    loginStore.email = 'test@example.com';
    loginStore.password = 'password123';

    expect(loginStore.email, 'test@example.com');
    expect(loginStore.password, 'password123');
    expect(loginStore.isFormValid, true);
  });

  test('Sign in with email and password', () async {
    loginStore.email = 'test@example.com';
    loginStore.password = 'password123';

    // Execute the signInWithEmailAndPassword action
    await loginStore.signInWithEmailAndPassword();

    // Verifique que o método foi chamado no mock do FirebaseAuth
    verify(() => mockFirebaseAuth.signInWithEmailAndPassword(
      email: 'test@example.com',
      password: 'password123',
    )).called(1);
  });

  test('Sign in fails with incorrect email and password', () async {
    loginStore.email = 'test@example.com';
    loginStore.password = 'wrongpassword';

    when(() => mockFirebaseAuth.signInWithEmailAndPassword(
      email: any(named: 'email'),
      password: any(named: 'password'),
    )).thenThrow(FirebaseAuthException(
        code: 'user-not-found',
        message: 'No user found for that email.'
    ));

    await loginStore.signInWithEmailAndPassword();

    expect(loginStore.errorMessage, 'No user found for that email.');
  });

}
