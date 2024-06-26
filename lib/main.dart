import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/user_provider.dart';
import 'package:flutter_application_1/responsive/mobile_screen_layout.dart';
import 'package:flutter_application_1/responsive/responsive_layout_screen.dart';
import 'package:flutter_application_1/responsive/web_screen_layout.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_application_1/screens/signup_screen.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:provider/provider.dart';

// import 'rep';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // String os = Platform.operatingSystem;
  var platformName = '';
  if (kIsWeb) {
    platformName = "Web";
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyA0j65SGy_iSQxQWKcJWQYD06dB9U-Do1c",
            authDomain: "fire-setup-1baf7.firebaseapp.com",
            projectId: "fire-setup-1baf7",
            storageBucket: "fire-setup-1baf7.appspot.com",
            messagingSenderId: "790140779812",
            appId: "1:790140779812:web:d534773f526c2a5bd807b1"));
  } else {
     if (Platform.isWindows) {
      platformName = "Windows";
      await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyA0j65SGy_iSQxQWKcJWQYD06dB9U-Do1c",
              authDomain: "fire-setup-1baf7.firebaseapp.com",
              projectId: "fire-setup-1baf7",
              storageBucket: "fire-setup-1baf7.appspot.com",
              messagingSenderId: "790140779812",
              appId: "1:790140779812:web:d534773f526c2a5bd807b1"));
    }else{
      await Firebase.initializeApp();
    }
  }
  print("platformName :- "+platformName.toString());
  // await Firebase.initializeApp();
  // await Firebase.initializeApp(
  //     options: const FirebaseOptions(
  //         apiKey: "AIzaSyA0j65SGy_iSQxQWKcJWQYD06dB9U-Do1c",
  //         authDomain: "fire-setup-1baf7.firebaseapp.com",
  //         projectId: "fire-setup-1baf7",
  //         storageBucket: "fire-setup-1baf7.appspot.com",
  //         messagingSenderId: "790140779812",
  //         appId: "1:790140779812:web:d534773f526c2a5bd807b1"));
  // if (kIsWeb) {
  //   await Firebase.initializeApp(
  //       options: const FirebaseOptions(
  //           apiKey: "AIzaSyA0j65SGy_iSQxQWKcJWQYD06dB9U-Do1c",
  //           authDomain: "fire-setup-1baf7.firebaseapp.com",
  //           projectId: "fire-setup-1baf7",
  //           storageBucket: "fire-setup-1baf7.appspot.com",
  //           messagingSenderId: "790140779812",
  //           appId: "1:790140779812:web:d534773f526c2a5bd807b1"));
  // } else {
  //   await Firebase.initializeApp();
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram Clone',
        theme: ThemeData.dark()
            .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
        // home: const ResponsiveLayout(
        //   mobileScreenLayout: MobileScreenLayout(),
        //   webScreenLayout: WebScreenLayout(),
        // ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
