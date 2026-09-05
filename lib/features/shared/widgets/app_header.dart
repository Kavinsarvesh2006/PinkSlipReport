import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../authentication/domain/models/user_role.dart';
import '../state/app_state_manager.dart';

class AppHeader extends StatelessWidget {
  final VoidCallback? onNotificationTap;
  final VoidCallback? onLogoutTap;

  const AppHeader({
    super.key,
    this.onNotificationTap,
    this.onLogoutTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppStateManager.instance,
      builder: (context, _) {
        final profile = AppStateManager.instance.currentProfile;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Brand Logo & Text
              Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      gradient: AppTheme.brandIconGradient,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.violet600.withValues(alpha: 0.25),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(Icons.description_outlined, size: 16, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 8),
                  RichText(
                    text: TextSpan(
                      style: AppTheme.poppins(fontSize: 17, fontWeight: FontWeight.w700, color: AppTheme.ink900),
                      children: const [
                        TextSpan(text: 'PinkSlip'),
                        TextSpan(text: 'Report', style: TextStyle(color: AppTheme.violet600)),
                      ],
                    ),
                  ),
                ],
              ),

              // Action Icons & Authenticated User Identity (No Switcher)
              Row(
                children: [
                  // Fixed Authenticated Role & Scope Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: profile.isHodAdmin
                          ? const Color(0xFFFEE2E2)
                          : profile.role == UserRole.hod
                              ? const Color(0xFFEFF6FF)
                              : profile.role == UserRole.classRep
                                  ? const Color(0xFFECFDF5)
                                  : AppTheme.violet50,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: profile.isHodAdmin
                            ? const Color(0xFFFECACA)
                            : profile.role == UserRole.hod
                                ? const Color(0xFFBFDBFE)
                                : profile.role == UserRole.classRep
                                    ? const Color(0xFFA7F3D0)
                                    : AppTheme.violet100,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          profile.role == UserRole.hod
                              ? Icons.admin_panel_settings_rounded
                              : profile.role == UserRole.classRep
                                  ? Icons.groups_rounded
                                  : profile.role == UserRole.advisor
                                      ? Icons.school_rounded
                                      : Icons.person_rounded,
                          size: 13,
                          color: profile.isHodAdmin
                              ? const Color(0xFFDC2626)
                              : profile.role == UserRole.hod
                                  ? const Color(0xFF2563EB)
                                  : profile.role == UserRole.classRep
                                      ? const Color(0xFF059669)
                                      : AppTheme.violet700,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          profile.role == UserRole.hod
                              ? (profile.isHodAdmin ? 'HOD [Admin]' : 'HOD [Viewer]')
                              : profile.role == UserRole.classRep
                                  ? 'Class Rep (${profile.section.replaceAll('Section ', '')})'
                                  : profile.role == UserRole.advisor
                                      ? 'Adviser (${profile.section.replaceAll('Section ', '')})'
                                      : 'Student',
                          style: AppTheme.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: profile.isHodAdmin
                                ? const Color(0xFFDC2626)
                                : profile.role == UserRole.hod
                                    ? const Color(0xFF2563EB)
                                    : profile.role == UserRole.classRep
                                        ? const Color(0xFF059669)
                                        : AppTheme.violet700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Notification Bell
                  GestureDetector(
                    onTap: onNotificationTap,
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppTheme.line),
                      ),
                      child: const Center(
                        child: Icon(Icons.notifications_none_rounded, size: 18, color: AppTheme.ink600),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Logout / Return to Single Login Route
                  GestureDetector(
                    onTap: () {
                      AppStateManager.instance.logout();
                      Navigator.pushNamedAndRemoveUntil(context, '/sign-in', (route) => false);
                    },
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppTheme.line),
                      ),
                      child: const Center(
                        child: Icon(Icons.logout_rounded, size: 17, color: AppTheme.pink500),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
