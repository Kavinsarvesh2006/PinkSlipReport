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
  final TextEditingController _emailController = TextEditingController(text: 'muthulakshmi.advisor@vsb.ac.in');
  final TextEditingController _passwordController = TextEditingController(text: '••••••••');
  bool _obscurePassword = true;

  void _handleLogin() {
    final email = _emailController.text.trim().toLowerCase();

    UserProfile selectedProfile;
    if (email.contains('karthikeyan') || (email.contains('hod') && email.contains('viewer'))) {
      selectedProfile = UserProfile.hodViewerProfile;
    } else if (email.contains('balamurugan') || email.contains('hod')) {
      selectedProfile = UserProfile.hodAdminProfile;
    } else if (email.contains('vishnupriya') || email.contains('sec_a') || email.contains('3a')) {
      selectedProfile = UserProfile.advisor3AProfile;
    } else if (email.contains('jenitta') || email.contains('rep')) {
      selectedProfile = UserProfile.classRepProfile;
    } else if (email.contains('student') || email.contains('lithesh')) {
      selectedProfile = UserProfile.studentProfile;
    } else {
      selectedProfile = UserProfile.advisorProfile;
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
              const SizedBox(height: 24),
              Row(
                children: [
                  const Expanded(child: Divider(color: AppTheme.line)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text('INSTITUTIONAL LOGIN PERSONAS', style: AppTheme.inter(fontSize: 10.5, fontWeight: FontWeight.w700, color: AppTheme.ink400, letterSpacing: 0.5)),
                  ),
                  const Expanded(child: Divider(color: AppTheme.line)),
                ],
              ),
              const SizedBox(height: 14),
              // Persona Quick Logins
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _QuickPersonaBtn(
                    roleBadge: 'HOD [ADMIN]',
                    title: 'Dr. R. Balamurugan',
                    subtitle: 'All Years · Full Authority (Edit & Delete)',
                    badgeColor: const Color(0xFFDC2626),
                    onTap: () {
                      _emailController.text = 'balamurugan.hod@vsb.ac.in';
                      _handleLogin();
                    },
                  ),
                  _QuickPersonaBtn(
                    roleBadge: 'HOD [VIEWER]',
                    title: 'Dr. S. Karthikeyan',
                    subtitle: 'All Years · Read-Only (Cannot Edit/Delete)',
                    badgeColor: const Color(0xFF2563EB),
                    onTap: () {
                      _emailController.text = 'karthikeyan.hod@vsb.ac.in';
                      _handleLogin();
                    },
                  ),
                  _QuickPersonaBtn(
                    roleBadge: 'ADVISER III-B',
                    title: 'Dr. R. Murugesan [RM]',
                    subtitle: 'III Year Sec B · Scoped Confidential Data',
                    badgeColor: AppTheme.violet600,
                    onTap: () {
                      _emailController.text = 'murugesan.advisor@vsb.ac.in';
                      _handleLogin();
                    },
                  ),
                  _QuickPersonaBtn(
                    roleBadge: 'ADVISER III-A',
                    title: 'Ms. C. Vishnupriya [CV]',
                    subtitle: 'III Year Sec A · Scoped Confidential Data',
                    badgeColor: AppTheme.violet600,
                    onTap: () {
                      _emailController.text = 'vishnupriya.advisor@vsb.ac.in';
                      _handleLogin();
                    },
                  ),
                  _QuickPersonaBtn(
                    roleBadge: 'CLASS REP III-B',
                    title: 'Jenitta Blessy S',
                    subtitle: 'III Year Sec B · Attendance Assistant',
                    badgeColor: const Color(0xFF059669),
                    onTap: () {
                      _emailController.text = 'jenitta.rep@vsb.ac.in';
                      _handleLogin();
                    },
                  ),
                  _QuickPersonaBtn(
                    roleBadge: 'STUDENT',
                    title: 'Lithesh Hari R',
                    subtitle: 'Individual Student Attendance View',
                    badgeColor: const Color(0xFFD97706),
                    onTap: () {
                      _emailController.text = 'lithesh.student@vsb.ac.in';
                      _handleLogin();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickPersonaBtn extends StatelessWidget {
  final String roleBadge;
  final String title;
  final String subtitle;
  final Color badgeColor;
  final VoidCallback onTap;

  const _QuickPersonaBtn({
    required this.roleBadge,
    required this.title,
    required this.subtitle,
    required this.badgeColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppTheme.line),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: badgeColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                roleBadge,
                style: AppTheme.inter(fontSize: 10, fontWeight: FontWeight.w800, color: badgeColor),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTheme.inter(fontSize: 12.5, fontWeight: FontWeight.w700, color: AppTheme.ink900)),
                  Text(subtitle, style: AppTheme.inter(fontSize: 10.5, color: AppTheme.ink600)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 13, color: AppTheme.ink400),
          ],
        ),
      ),
    );
  }
}

