import 'package:bloc/bloc.dart';
import 'package:chat_app/core/helpers/shared_prefrences.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app.dart';
import 'core/error/firebase_error_logger.dart';
import 'core/observers/bloc_observer.dart';
import 'firebase_options.dart';
import 'injection_container.dart';

Future<void> _syncAuthSession() async {
  final auth = FirebaseAuth.instance;
  await auth.authStateChanges().first;
  final user = auth.currentUser;
  final cache = getIt<CacheHelper>();
  if (user != null) {
    try {
      await user.getIdToken(true);
    } catch (e) {
      printFirebaseError(e);
      await auth.signOut();
      await cache.saveData(key: 'isLoggedIn', val: false);
    }
    return;
  }
  if (cache.getData(key: 'isLoggedIn') == true) {
    await cache.saveData(key: 'isLoggedIn', val: false);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await ScreenUtil.ensureScreenSize();
  Bloc.observer = MyBlocObserver();
  EasyLocalization.ensureInitialized();
  await getItInit();
  await _syncAuthSession();

  runApp(EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/languages',
      fallbackLocale: const Locale('en'),
      child: const MyApp()));
}