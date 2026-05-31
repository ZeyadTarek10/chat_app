import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  bool _initialized = false;

  static const String _iosClientId =
      '72690865509-fp129bihah1sh4raiu1uq3e3nae7hmm5.apps.googleusercontent.com';
  static const String _serverClientId =
      '72690865509-j798ohl0icd3upj89c6fgtjbf0mnqumr.apps.googleusercontent.com';

  Future<void> initialize() async {
    if (_initialized) return;
    String? clientId;
    if (!kIsWeb && Platform.isIOS) {
      clientId = _iosClientId;
    }
    await GoogleSignIn.instance.initialize(
      clientId: clientId,
      serverClientId: _serverClientId,
    );
    _initialized = true;
  }

  Future<GoogleSignInAccount?> signIn() async {
    await initialize();
    try {
      if (!GoogleSignIn.instance.supportsAuthenticate()) {
        throw Exception(
            'Google sign-in is not supported on this platform. Use the platform-specific button widget.');
      }
      return await GoogleSignIn.instance.authenticate(
        scopeHint: const ['openid', 'email', 'profile'],
      );
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        return null;
      }
      print('GoogleSignInException [${e.code}]: ${e.description}');
      rethrow;
    } catch (e) {
      print('Google sign-in error: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    await initialize();
    try {
      await GoogleSignIn.instance.signOut();
      await GoogleSignIn.instance.disconnect();
    } catch (_) {}
  }
}
