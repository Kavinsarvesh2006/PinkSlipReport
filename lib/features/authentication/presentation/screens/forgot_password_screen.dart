import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController(text: 'muthulakshmi.advisor@vsb.ac.in');
  bool _isLoading = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  Future<void> _handleSendOtp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1200));

    if (!mounted) return;
    setState(() => _isLoading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('OTP sent to ${_emailCtrl.text.trim()} ✓'),
        backgroundColor: AppTheme.violet700,
      ),
    );

    Navigator.pushNamed(context, '/otp-verification');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lavenderBg,
      appBar: AppBar(
        backgroundColor: AppTheme.lavenderBg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: AppTheme.ink900),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Password Recovery',
          style: AppTheme.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.ink900),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 12),
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppTheme.violet100,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Center(
                    child: Icon(Icons.lock_reset_rounded, size: 28, color: AppTheme.violet600),
                  ),
                ),
                const SizedBox(height: 14),
                RichText(
                  text: TextSpan(
                    style: AppTheme.poppins(fontSize: 22, fontWeight: FontWeight.w700, color: AppTheme.ink900),
                    children: const [
                      TextSpan(text: 'Forgot '),
                      TextSpan(text: 'Password?', style: TextStyle(color: AppTheme.violet600)),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Institutional Account Recovery',
                  style: AppTheme.inter(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.violet700),
                ),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Don't worry, it happens! Enter your registered institutional email to receive a secure one-time passcode (OTP).",
                    style: AppTheme.inter(fontSize: 12, color: AppTheme.ink600, height: 1.4),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 28),

                // Email Input Field
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Institutional Email',
                    style: AppTheme.inter(fontSize: 12.5, fontWeight: FontWeight.w600, color: AppTheme.ink900),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppTheme.line),
                  ),
                  child: TextFormField(
                    controller: _emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    style: AppTheme.inter(fontSize: 13.5, color: AppTheme.ink900),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'Please enter your email';
                      if (!v.contains('@')) return 'Please enter a valid email address';
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.mail_outline_rounded, size: 18, color: AppTheme.ink400),
                      hintText: 'e.g. name.advisor@vsb.ac.in',
                      hintStyle: AppTheme.inter(fontSize: 13, color: AppTheme.ink400),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Send OTP Button
                GestureDetector(
                  onTap: _isLoading ? null : _handleSendOtp,
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
                      child: _isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Send OTP Code',
                                  style: AppTheme.inter(fontSize: 14.5, fontWeight: FontWeight.w700, color: Colors.white),
                                ),
                                const SizedBox(width: 8),
                                const Icon(Icons.arrow_forward_rounded, size: 18, color: Colors.white),
                              ],
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Back to Sign In Link
                GestureDetector(
                  onTap: () => Navigator.pushReplacementNamed(context, '/sign-in'),
                  child: RichText(
                    text: TextSpan(
                      style: AppTheme.inter(fontSize: 12.5, color: AppTheme.ink600),
                      children: [
                        const TextSpan(text: 'Remember your password? '),
                        TextSpan(
                          text: 'Sign In',
                          style: AppTheme.inter(fontSize: 12.5, fontWeight: FontWeight.w700, color: AppTheme.violet600),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Helpdesk note card
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
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: AppTheme.violet50,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Icon(Icons.support_agent_rounded, size: 20, color: AppTheme.violet600),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Need help with credentials?',
                              style: AppTheme.inter(fontSize: 12, fontWeight: FontWeight.w700, color: AppTheme.ink900),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Contact Department IT Support at it.helpdesk@vsb.ac.in',
                              style: AppTheme.inter(fontSize: 11, color: AppTheme.ink600),
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
      ),
    );
  }
}
