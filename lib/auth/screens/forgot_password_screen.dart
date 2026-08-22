import 'package:flutter/material.dart';
import '../theme/auth_theme.dart';
import '../widgets/auth_card.dart';
import '../widgets/auth_illustration.dart';
import '../widgets/auth_input_field.dart';
import '../widgets/auth_link_text.dart';
import '../widgets/auth_primary_button.dart';

/// Forgot Password screen — recreates the right-side card from the reference image.
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  Future<void> _handleSendOtp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // Simulate a network call
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    setState(() => _isLoading = false);

    // TODO: Replace with actual OTP logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('OTP sent to your email!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuthTheme.pageBackground,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: AuthCard(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ── Illustration ──────────────────────────
                    const ForgotPasswordIllustration(height: 150),
                    const SizedBox(height: 16),

                    // ── Heading ──────────────────────────────
                    const Text('Forget Password', style: AuthTheme.heading),
                    const SizedBox(height: 8),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        "Don't worry it happens. Please enter the address associate with your account",
                        style: AuthTheme.subtitle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 28),

                    // ── Email ─────────────────────────────────
                    AuthInputField(
                      hintText: 'Email address',
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailCtrl,
                      textInputAction: TextInputAction.done,
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return 'Please enter your email';
                        if (!v.contains('@')) return 'Enter a valid email address';
                        return null;
                      },
                    ),
                    const SizedBox(height: 28),

                    // ── Send OTP Button ──────────────────────
                    AuthPrimaryButton(
                      label: 'Send OTP',
                      isLoading: _isLoading,
                      onPressed: _handleSendOtp,
                    ),
                    const SizedBox(height: 28),

                    // ── Sign In Link ─────────────────────────
                    AuthLinkText(
                      prefix: 'You remember your password? ',
                      linkLabel: 'Sign in',
                      onTap: () =>
                          Navigator.pushReplacementNamed(context, '/sign-in'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
