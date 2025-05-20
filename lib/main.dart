import 'package:chatapp/Pages/LoginPage.dart';
import 'package:chatapp/services/auth/authgate.dart';
import 'package:chatapp/themes/Light_Mode.dart';
import 'package:chatapp/themes/Theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
        create: (context)=>ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Authgate(),
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themedata,

    );
  }
}


