import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _passwordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    super.dispose();
  }

  Future<void> _handleResetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    if (_passwordCtrl.text != _confirmPasswordCtrl.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1200));

    if (!mounted) return;
    setState(() => _isLoading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Password reset successfully! Please sign in with your new password. ✓'),
        backgroundColor: AppTheme.green600,
      ),
    );

    Navigator.pushNamedAndRemoveUntil(context, '/sign-in', (route) => false);
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
          'New Credentials',
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
                    child: Icon(Icons.key_rounded, size: 28, color: AppTheme.violet600),
                  ),
                ),
                const SizedBox(height: 14),
                RichText(
                  text: TextSpan(
                    style: AppTheme.poppins(fontSize: 22, fontWeight: FontWeight.w700, color: AppTheme.ink900),
                    children: const [
                      TextSpan(text: 'Create '),
                      TextSpan(text: 'New Password', style: TextStyle(color: AppTheme.violet600)),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Set Secure Password',
                  style: AppTheme.inter(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.violet700),
                ),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Your new password must be at least 6 characters and different from previous passwords.',
                    style: AppTheme.inter(fontSize: 12, color: AppTheme.ink600, height: 1.4),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 28),

                // New Password Field
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'New Password',
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
                    controller: _passwordCtrl,
                    obscureText: _obscurePassword,
                    style: AppTheme.inter(fontSize: 13.5, color: AppTheme.ink900),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Please enter a password';
                      if (v.length < 6) return 'Password must be at least 6 characters';
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outline_rounded, size: 18, color: AppTheme.ink400),
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined, size: 18, color: AppTheme.ink400),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                      hintText: 'Enter new password',
                      hintStyle: AppTheme.inter(fontSize: 13, color: AppTheme.ink400),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Confirm Password Field
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Confirm Password',
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
                    controller: _confirmPasswordCtrl,
                    obscureText: _obscureConfirmPassword,
                    style: AppTheme.inter(fontSize: 13.5, color: AppTheme.ink900),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Please confirm your password';
                      if (v != _passwordCtrl.text) return 'Passwords do not match';
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outline_rounded, size: 18, color: AppTheme.ink400),
                      suffixIcon: IconButton(
                        icon: Icon(_obscureConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined, size: 18, color: AppTheme.ink400),
                        onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                      ),
                      hintText: 'Re-enter new password',
                      hintStyle: AppTheme.inter(fontSize: 13, color: AppTheme.ink400),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                GestureDetector(
                  onTap: _isLoading ? null : _handleResetPassword,
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
                              'Save Password & Sign In',
                              style: AppTheme.inter(fontSize: 14.5, fontWeight: FontWeight.w700, color: Colors.white),
                            ),
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
