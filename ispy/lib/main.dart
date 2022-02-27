///
///Ah the main function.
///basically, it just calls the splash screen that does the actual magic.
///
/// Well I can use this place to explain what all imports I have used
/// 1. ScreenUtil
///   This is a library that helps me to make the screen responsive.
///   I use it to make the screen responsive.
///   Only if I had a wireframe I would have used it making this app looking better.
///
/// 2. lottie
///   This is a library that helps me to make the animation.
///   I use it to make the animation and make UX more attractive.
///
/// 3. SharedPreferences
///   This is a library that helps me to save the data.
///  I use it to save the username in the shared preferences.
/// The ID is generated based on backend.
///
/// 4. Socket IO Client
///  This is a library that helps me to connect to the backend.
///  I use it to connect to the backend, using socket to send and receive high live data.
///
/// 5. Camera
///   Well to access camera 😂

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ispy/add_user.dart';
import 'package:ispy/home.dart';
import 'package:ispy/splash.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(750, 1334),
      builder: () => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const MyHomePage(title: "iSpy"),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
