import 'package:assignment/constants/color_const.dart';
import 'package:assignment/firebase_options.dart';
import 'package:assignment/screens/loading_screen.dart';
import 'package:assignment/screens/login_screen.dart';
import 'package:assignment/viewmodel/appstate_viewmodel.dart';
import 'package:assignment/viewmodel/authentication_viewmodel.dart';
import 'package:assignment/viewmodel/bottombar_viewmodel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthenticationViewmodel()),
        ChangeNotifierProvider(create: (context) => AppState()),
        ChangeNotifierProvider(create: (context) => BottomNavbarState()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: primaryBlueCustomColor),
          useMaterial3: true,
        ),
        home: AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthenticationViewmodel>(context);
    if (authViewModel.user != null) {
      return LoadingScreen();
    } else {
      return const LoginScreen();
    }
  }
}
