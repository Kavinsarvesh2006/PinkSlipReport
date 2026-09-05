import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/shared/state/app_state_manager.dart';
import 'features/authentication/domain/models/user_role.dart';
import 'features/authentication/presentation/screens/sign_in_screen.dart';
import 'features/advisor/presentation/screens/advisor_dashboard_screen.dart';
import 'features/hod/presentation/screens/hod_dashboard_screen.dart';
import 'features/attendance/presentation/screens/student_attendance_screen.dart';

import 'features/authentication/presentation/screens/forgot_password_screen.dart';
import 'features/authentication/presentation/screens/otp_verification_screen.dart';
import 'features/authentication/presentation/screens/reset_password_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SmartProApp());
}

class SmartProApp extends StatelessWidget {
  const SmartProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppStateManager.instance,
      builder: (context, _) {
        return MaterialApp(
          title: 'SmartPro',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          home: const MainRouterScreen(),
          routes: {
            '/sign-in': (_) => const SignInScreen(),
            '/forgot-password': (_) => const ForgotPasswordScreen(),
            '/otp-verification': (_) => const OtpVerificationScreen(),
            '/reset-password': (_) => const ResetPasswordScreen(),
            '/advisor-dashboard': (_) => const AdvisorDashboardScreen(),
            '/hod-dashboard': (_) => const HodDashboardScreen(),
            '/student-dashboard': (_) => const StudentAttendanceScreen(),
          },
        );
      },
    );
  }
}

class MainRouterScreen extends StatelessWidget {
  const MainRouterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppStateManager.instance,
      builder: (context, _) {
        final state = AppStateManager.instance;
        if (!state.isAuthenticated) {
          return const SignInScreen();
        }

        final role = state.currentRole;
        switch (role) {
          case UserRole.advisor:
          case UserRole.classRep:
            return const AdvisorDashboardScreen();
          case UserRole.hod:
            return const HodDashboardScreen();
          case UserRole.student:
            return const StudentAttendanceScreen();
        }
      },
    );
  }
}
