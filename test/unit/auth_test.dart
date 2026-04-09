import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:shuttlers/utils/auth.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockUser extends Mock implements User {}
class MockUserCredential extends Mock implements UserCredential {}

class MockFirebaseAppPlatform extends Mock with MockPlatformInterfaceMixin implements FirebaseAppPlatform {
  @override
  String get name => defaultFirebaseAppName;

  @override
  FirebaseOptions get options => const FirebaseOptions(
        apiKey: '123',
        appId: '123',
        messagingSenderId: '123',
        projectId: '123',
      );
}

class MockFirebasePlatform extends Mock with MockPlatformInterfaceMixin implements FirebasePlatform {
  @override
  FirebaseAppPlatform app([String name = defaultFirebaseAppName]) {
    return MockFirebaseAppPlatform();
  }
}

void main() {
  late Auth authInstance;
  late MockFirebaseAuth mockFirebaseAuth;
  late MockUser mockUser;
  late MockUserCredential mockUserCredential;

  setUpAll(() {
    FirebasePlatform.instance = MockFirebasePlatform();
  });

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockUser = MockUser();
    mockUserCredential = MockUserCredential();

    authInstance = Auth();
    // Injecting the mock auth instance
    authInstance.auth = mockFirebaseAuth;
  });

  group('Auth tests', () {
    test('currentUser should return auth.currentUser', () {
      when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);

      final result = authInstance.currentUser;

      expect(result, equals(mockUser));
      verify(() => mockFirebaseAuth.currentUser).called(1);
    });

    test('signIn should call auth.signInWithEmailAndPassword', () async {
      when(() => mockFirebaseAuth.signInWithEmailAndPassword(
        email: 'test@test.com',
        password: 'password123',
      )).thenAnswer((_) async => mockUserCredential);

      await authInstance.signIn(email: 'test@test.com', password: 'password123');

      verify(() => mockFirebaseAuth.signInWithEmailAndPassword(
        email: 'test@test.com',
        password: 'password123',
      )).called(1);
    });

    test('changePassowrd should execute expected auth flow', () async {
      when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);
      when(() => mockUser.email).thenReturn('test@test.com');

      when(() => mockFirebaseAuth.signOut()).thenAnswer((_) async {});
      when(() => mockFirebaseAuth.signInWithEmailAndPassword(
        email: 'test@test.com',
        password: 'oldPassword123',
      )).thenAnswer((_) async => mockUserCredential);
      when(() => mockUser.updatePassword('newPassword123')).thenAnswer((_) async {});

      await authInstance.changePassowrd(
        password: 'oldPassword123',
        newPassword: 'newPassword123',
      );

      // Verify sequence
      verify(() => mockFirebaseAuth.currentUser).called(greaterThanOrEqualTo(1));
      verify(() => mockUser.email).called(1);
      verify(() => mockFirebaseAuth.signOut()).called(1);
      verify(() => mockFirebaseAuth.signInWithEmailAndPassword(
        email: 'test@test.com',
        password: 'oldPassword123',
      )).called(1);
      verify(() => mockUser.updatePassword('newPassword123')).called(1);
    });
  });
}
