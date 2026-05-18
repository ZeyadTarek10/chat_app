import 'package:firebase_auth/firebase_auth.dart';

void printFirebaseError(Object error, [StackTrace? stackTrace]) {
  if (error is FirebaseAuthException) {
    print('FirebaseAuthException [${error.code}]: ${error.message}');
    return;
  }
  if (error is FirebaseException) {
    print('FirebaseException [${error.code}]: ${error.message}');
    return;
  }
  print('Error: $error');
  if (stackTrace != null) {
    print(stackTrace);
  }
}
