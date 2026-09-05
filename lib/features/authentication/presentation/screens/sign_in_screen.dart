import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/models/user_role.dart';
import '../../../shared/state/app_state_manager.dart';
import '../../../advisor/presentation/screens/advisor_dashboard_screen.dart';
import '../../../hod/presentation/screens/hod_dashboard_screen.dart';
import '../../../attendance/presentation/screens/student_attendance_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController(text: 'velusamy.advisor@vsb.ac.in');
  final TextEditingController _passwordController = TextEditingController(text: '••••••••');
  bool _obscurePassword = true;

  void _handleLogin() {
    final email = _emailController.text.trim().toLowerCase();

    UserProfile selectedProfile;
    if (email.contains('kavitha')) {
      selectedProfile = UserProfile.hodKavithaProfile;
    } else if (email.contains('karthikeyan') || (email.contains('hod') && email.contains('viewer'))) {
      selectedProfile = UserProfile.hodViewerProfile;
    } else if (email.contains('manivannan') || email.contains('hod')) {
      selectedProfile = UserProfile.hodAdminProfile;
    } else if (email.contains('vishnupriya') || email.contains('sec_a') || email.contains('3a')) {
      selectedProfile = UserProfile.advisor3AProfile;
    } else if (email.contains('murugesan') || email.contains('sec_b') || email.contains('3b')) {
      selectedProfile = UserProfile.advisor3BProfile;
    } else if (email.contains('bharathi') || email.contains('sec_c') || email.contains('3c')) {
      selectedProfile = UserProfile.advisor3CProfile;
    } else if (email.contains('velusamy') || email.contains('sec_d') || email.contains('3d')) {
      selectedProfile = UserProfile.advisor3DProfile;
    } else if (email.contains('jenitta') || email.contains('rep')) {
      selectedProfile = UserProfile.classRepProfile;
    } else if (email.contains('student') || email.contains('lithesh')) {
      selectedProfile = UserProfile.studentProfile;
    } else {
      selectedProfile = UserProfile.advisor3DProfile;
    }

    AppStateManager.instance.loginWithProfile(selectedProfile);

    if (selectedProfile.role == UserRole.hod) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HodDashboardScreen()));
    } else if (selectedProfile.role == UserRole.student) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const StudentAttendanceScreen()));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AdvisorDashboardScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lavenderBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppTheme.violet100,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Center(
                  child: Icon(Icons.shield_outlined, size: 28, color: AppTheme.violet600),
                ),
              ),
              const SizedBox(height: 12),
              RichText(
                text: TextSpan(
                  style: AppTheme.poppins(fontSize: 22, fontWeight: FontWeight.w700, color: AppTheme.ink900),
                  children: const [
                    TextSpan(text: 'PinkSlip'),
                    TextSpan(text: 'Report', style: TextStyle(color: AppTheme.violet600)),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Text('Single Secure Login System', style: AppTheme.inter(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.violet700)),
              const SizedBox(height: 4),
              Text('Enter your credentials to access your scoped dashboard', style: AppTheme.inter(fontSize: 12, color: AppTheme.ink600), textAlign: TextAlign.center),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Email / Username', style: AppTheme.inter(fontSize: 12.5, fontWeight: FontWeight.w600, color: AppTheme.ink900)),
              ),
              const SizedBox(height: 6),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppTheme.line),
                ),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.mail_outline_rounded, size: 18, color: AppTheme.ink400),
                    hintText: 'Enter your institutional email',
                    hintStyle: AppTheme.inter(fontSize: 13, color: AppTheme.ink400),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Password', style: AppTheme.inter(fontSize: 12.5, fontWeight: FontWeight.w600, color: AppTheme.ink900)),
              ),
              const SizedBox(height: 6),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppTheme.line),
                ),
                child: TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_outline_rounded, size: 18, color: AppTheme.ink400),
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined, size: 18, color: AppTheme.ink400),
                      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                    ),
                    hintText: 'Enter your password',
                    hintStyle: AppTheme.inter(fontSize: 13, color: AppTheme.ink400),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/forgot-password'),
                  child: Text(
                    'Forgot password?',
                    style: AppTheme.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.violet600),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _handleLogin,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.violet600.withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Log In',
                      style: AppTheme.inter(fontSize: 14.5, fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.line),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppTheme.violet50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Icon(Icons.verified_user_rounded, size: 22, color: AppTheme.violet600),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Institutional Single Login Portal',
                            style: AppTheme.inter(fontSize: 12, fontWeight: FontWeight.w700, color: AppTheme.ink900),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Each user is granted isolated access strictly to their assigned class and authority scope. Profile switching is blocked.',
                            style: AppTheme.inter(fontSize: 11, color: AppTheme.ink600, height: 1.3),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

