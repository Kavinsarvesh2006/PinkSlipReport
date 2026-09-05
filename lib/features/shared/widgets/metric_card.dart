import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final String subtext;
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final VoidCallback? onTap;

  const MetricCard({
    super.key,
    required this.label,
    required this.value,
    required this.subtext,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.line),
          boxShadow: [
            BoxShadow(
              color: AppTheme.ink900.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: AppTheme.inter(fontSize: 12, fontWeight: FontWeight.w500, color: AppTheme.ink600),
                ),
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Icon(icon, size: 15, color: iconColor),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: AppTheme.poppins(fontSize: 22, fontWeight: FontWeight.w700, color: AppTheme.ink900),
            ),
            const SizedBox(height: 2),
            Text(
              subtext,
              style: AppTheme.inter(fontSize: 11, fontWeight: FontWeight.w400, color: AppTheme.ink400),
            ),
          ],
        ),
      ),
    );
  }
}
