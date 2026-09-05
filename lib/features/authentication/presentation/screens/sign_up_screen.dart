import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:slipreport/core/theme/auth_theme.dart';
import 'package:slipreport/core/utils/validators.dart';
import '../widgets/auth_card.dart';
import '../widgets/auth_illustration.dart';
import '../widgets/auth_input_field.dart';
import '../widgets/auth_link_text.dart';
import '../widgets/auth_primary_button.dart';

/// Sign-Up screen — recreates the center card from the reference image.
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  late TapGestureRecognizer _termsRecognizer;
  late TapGestureRecognizer _privacyRecognizer;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _termsRecognizer = TapGestureRecognizer()
      ..onTap = () {
        // TODO: Open Terms
      };
    _privacyRecognizer = TapGestureRecognizer()
      ..onTap = () {
        // TODO: Open Privacy Policy
      };
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _termsRecognizer.dispose();
    _privacyRecognizer.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // Simulate a network call
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    setState(() => _isLoading = false);

    // TODO: Replace with actual sign-up logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Account created successfully!')),
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
                    const SignUpIllustration(height: 150),
                    const SizedBox(height: 16),

                    // ── Heading ──────────────────────────────
                    const Text('Sign Up', style: AuthTheme.heading),
                    const SizedBox(height: 8),
                    const Text(
                      'Use proper information to continue',
                      style: AuthTheme.subtitle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 28),

                    // ── Full Name ─────────────────────────────
                    AuthInputField(
                      hintText: 'Full name',
                      prefixIcon: Icons.person_outline_rounded,
                      controller: _nameCtrl,
                      validator: Validators.validateName,
                    ),
                    const SizedBox(height: AuthTheme.fieldSpacing),

                    // ── Email ─────────────────────────────────
                    AuthInputField(
                      hintText: 'Email address',
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailCtrl,
                      validator: Validators.validateEmail,
                    ),
                    const SizedBox(height: AuthTheme.fieldSpacing),

                    // ── Password ──────────────────────────────
                    AuthInputField(
                      hintText: 'Password',
                      prefixIcon: Icons.lock_outline_rounded,
                      isPassword: true,
                      controller: _passwordCtrl,
                      textInputAction: TextInputAction.done,
                      validator: Validators.validatePassword,
                    ),
                    const SizedBox(height: 16),

                    // ── Terms & Privacy ───────────────────────
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: AuthTheme.bodyText.copyWith(fontSize: 13),
                        children: [
                          const TextSpan(
                            text: 'By signing up, you agree to our ',
                          ),
                          TextSpan(
                            text: 'Terms & Conditions',
                            style: AuthTheme.linkText.copyWith(fontSize: 13),
                            recognizer: _termsRecognizer,
                          ),
                          const TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: AuthTheme.linkText.copyWith(fontSize: 13),
                            recognizer: _privacyRecognizer,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // ── Create Account Button ────────────────
                    AuthPrimaryButton(
                      label: 'Create Account',
                      isLoading: _isLoading,
                      onPressed: _handleSignUp,
                    ),
                    const SizedBox(height: 28),

                    // ── Sign In Link ─────────────────────────
                    AuthLinkText(
                      prefix: 'Already have an account? ',
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
