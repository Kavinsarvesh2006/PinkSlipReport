import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _otpCtrl = TextEditingController(text: '7294');
  bool _isLoading = false;

  @override
  void dispose() {
    _otpCtrl.dispose();
    super.dispose();
  }

  Future<void> _handleVerifyOtp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1000));

    if (!mounted) return;
    setState(() => _isLoading = false);

    Navigator.pushNamed(context, '/reset-password');
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
          'Verification',
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
                    child: Icon(Icons.security_rounded, size: 28, color: AppTheme.violet600),
                  ),
                ),
                const SizedBox(height: 14),
                RichText(
                  text: TextSpan(
                    style: AppTheme.poppins(fontSize: 22, fontWeight: FontWeight.w700, color: AppTheme.ink900),
                    children: const [
                      TextSpan(text: 'Enter '),
                      TextSpan(text: 'OTP Code', style: TextStyle(color: AppTheme.violet600)),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Two-Step Verification',
                  style: AppTheme.inter(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.violet700),
                ),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'We sent a 4-digit authentication code to your institutional email. Please enter it below.',
                    style: AppTheme.inter(fontSize: 12, color: AppTheme.ink600, height: 1.4),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 28),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '4-Digit Code',
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
                    controller: _otpCtrl,
                    keyboardType: TextInputType.number,
                    style: AppTheme.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: AppTheme.ink900, letterSpacing: 6),
                    textAlign: TextAlign.center,
                    validator: (v) {
                      if (v == null || v.trim().length < 4) return 'Enter the 4-digit code';
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.pin_rounded, size: 18, color: AppTheme.ink400),
                      hintText: '• • • •',
                      hintStyle: AppTheme.inter(fontSize: 14, color: AppTheme.ink400, letterSpacing: 4),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                GestureDetector(
                  onTap: _isLoading ? null : _handleVerifyOtp,
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
                          : Text(
                              'Verify Code & Continue',
                              style: AppTheme.inter(fontSize: 14.5, fontWeight: FontWeight.w700, color: Colors.white),
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('A fresh OTP code has been resent to your email.')),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      style: AppTheme.inter(fontSize: 12.5, color: AppTheme.ink600),
                      children: [
                        const TextSpan(text: "Didn't receive the code? "),
                        TextSpan(
                          text: 'Resend Code',
                          style: AppTheme.inter(fontSize: 12.5, fontWeight: FontWeight.w700, color: AppTheme.violet600),
                        ),
                      ],
                    ),
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
