import 'package:flutter/material.dart';
import 'package:slipreport/core/theme/auth_theme.dart';

/// Reusable authentication input field.
///
/// Supports a leading [prefixIcon], optional password visibility toggle
/// when [isPassword] is true, and a [validator] callback.
class AuthInputField extends StatefulWidget {
  const AuthInputField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.textInputAction = TextInputAction.next,
  });

  final String hintText;
  final IconData prefixIcon;
  final TextEditingController? controller;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;

  @override
  State<AuthInputField> createState() => _AuthInputFieldState();
}

class _AuthInputFieldState extends State<AuthInputField> {
  bool _obscured = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassword && _obscured,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: AuthTheme.textPrimary,
      ),
      decoration: AuthTheme.inputDecoration(
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscured
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AuthTheme.textSecondary,
                  size: 22,
                ),
                onPressed: () => setState(() => _obscured = !_obscured),
                splashRadius: 20,
              )
            : null,
      ),
      validator: widget.validator,
    );
  }
}
