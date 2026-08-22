import 'package:flutter/material.dart';
import 'auth/screens/sign_in_screen.dart';
import 'auth/screens/sign_up_screen.dart';
import 'auth/screens/forgot_password_screen.dart';
import 'auth/theme/auth_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SlipReport',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AuthTheme.primaryBlue,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: AuthTheme.pageBackground,
      ),
      initialRoute: '/sign-in',
      routes: {
        '/sign-in': (_) => const SignInScreen(),
        '/sign-up': (_) => const SignUpScreen(),
        '/forgot-password': (_) => const ForgotPasswordScreen(),
      },
    );
  }
}
