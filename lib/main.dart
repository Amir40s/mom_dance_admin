import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mom_dance_admin/main_screen.dart';
import 'package:mom_dance_admin/provider/MenuAppController.dart';
import 'package:mom_dance_admin/provider/countdown_provider.dart';
import 'package:mom_dance_admin/provider/pick_provider.dart';
import 'package:mom_dance_admin/provider/text_color_provider.dart';
import 'package:mom_dance_admin/provider/value_provider.dart';
import 'package:mom_dance_admin/screen/countdown/count_down_screen.dart';
import 'package:mom_dance_admin/screen/login/login_screen.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ValueProvider()),
        ChangeNotifierProvider(create: (_) => TextColorProvider()),
        ChangeNotifierProvider(create: (_) => MenuAppController()),
        ChangeNotifierProvider(create: (_) => PickerProvider()),
        ChangeNotifierProvider(create: (_) => CountdownProvider()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mom Dance Admin',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MainScreen(),
      ),
    );
  }
}

