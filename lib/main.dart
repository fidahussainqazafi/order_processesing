import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:order_processesing/utils/constant.dart';
import 'package:order_processesing/view/home_screen.dart';
import 'package:order_processesing/view/login_screen.dart';
import 'package:order_processesing/view/signup_screen.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user;

  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    super.initState();


  }

  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstant.appName,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,

      //  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),

      ),
      home: user != null ? LoginScreen() : LoginScreen(),
      builder: EasyLoading.init(),
    );
  }
}
