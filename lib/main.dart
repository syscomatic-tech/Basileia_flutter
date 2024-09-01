import 'package:basileia/RestAPI/model.dart';
import 'package:basileia/Screen/SignInScreen.dart';
import 'package:basileia/Style/aduioFeeds.dart';
import 'package:basileia/Style/audioPlayerWiget.dart';
import 'package:basileia/Style/colors.dart';
import 'package:basileia/Style/videoplayer2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

import 'RestAPI/RestClient.dart';
import 'Screen/homeFeedScreen.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  debugPrint = (String? message, {int? wrapWidth}) => null;
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Colors.white),
        colorScheme: ColorScheme.fromSeed(seedColor: primary),
        useMaterial3: true,
      ),
      home:SplashScreen()

    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthClient authClient = AuthClient();

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    var sessionData = await authClient.loadUserSession();

    if (sessionData) {
      // User is logged in, navigate to home screen
      Get.offAll(() => HomeFeedScreen());
    } else {
      // User is not logged in, navigate to login screen
      Get.offAll(() => SignInScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
