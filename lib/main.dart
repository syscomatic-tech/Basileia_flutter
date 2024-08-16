import 'package:basileia/Screen/SignInScreen.dart';
import 'package:basileia/Style/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:firebase_core/firebase_core.dart';

import 'RestAPI/RestClient.dart';
import 'Screen/homeFeedScreen.dart';

void main() async {
  debugPrint = (String? message, {int? wrapWidth}) => null;

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
      home: SplashScreen(),
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
    Map<String, String?> sessionData = await authClient.loadUserSession();

    if (sessionData['jwt_token'] != null) {
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
