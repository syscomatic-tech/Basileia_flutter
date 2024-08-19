import 'package:basileia/Screen/SignInScreen.dart';
import 'package:basileia/Style/audioPlayerWiget.dart';
import 'package:basileia/Style/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
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
  runApp(const MyApp());
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
      home: AudioPlayerWithWaveform(audioUrl: 'https://nyc3.digitaloceanspaces.com/shardmind.ai/users/657ca801a0fce699ae0279c7/They%20Lied%20to%20You%20About%20Pain%20Andrew%20Tate%20%5BTubeRipper.com%5D.m4a?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=DO00LXP3EKNLZWTA9XCG%2F20240819%2Fnyc3%2Fs3%2Faws4_request&X-Amz-Date=20240819T142334Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=074eb3249f15b0db3de49f0c3ea2c9c3c841c38237b332645b88f35e7652f247'),
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
