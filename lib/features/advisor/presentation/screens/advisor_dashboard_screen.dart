import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../shared/state/app_state_manager.dart';
import '../../../shared/widgets/app_header.dart';
import '../../../shared/widgets/metric_card.dart';
import '../../../shared/widgets/pipeline_stepper.dart';
import '../../../shared/widgets/status_badge.dart';
import '../../../shared/widgets/authority_banner.dart';
import '../../../pink_slips/domain/models/pink_slip.dart';
import '../../../pink_slips/presentation/screens/pink_slip_detail_screen.dart';
import '../../../pink_slips/presentation/screens/issue_pink_slip_modal.dart';
import '../../presentation/screens/class_register_screen.dart';
import '../../../attendance/presentation/screens/raptor_camera_scanner_screen.dart';
import '../../../attendance/presentation/screens/attendance_history_gallery_screen.dart';
import '../../../attendance/presentation/screens/timetable_screen.dart';
import '../../../jarvis/presentation/jarvis_fab.dart';
import '../../../jarvis/presentation/jarvis_chat_screen.dart';

class AdvisorDashboardScreen extends StatelessWidget {
  const AdvisorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppStateManager.instance,
      builder: (context, _) {
        final state = AppStateManager.instance;
        final profile = state.currentProfile;
        final slips = state.scopedPinkSlips;

        return Scaffold(
          backgroundColor: AppTheme.lavenderBg,
          body: SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 90),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top App Bar
                      const AppHeader(),

                      // Confidentiality Banner
                      AuthorityBanner(
                        isHod: false,
                        text: 'Confidential Session · Scoped exclusively to ${profile.year} ${profile.section} (Other sections restricted)',
                      ),

                      // Welcome Banner
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                        padding: const EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          gradient: AppTheme.primaryGradient,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.violet600.withValues(alpha: 0.3),
                              blurRadius: 16,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Stack(
                          clipBehavior: Clip.antiAlias,
                          children: [
                            // Concentric Decorative Ring
                            Positioned(
                              right: -45,
                              top: -45,
                              child: Container(
                                width: 140,
                                height: 140,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.12),
                                    width: 18,
                                  ),
                                ),
                              ),
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Top Pills
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(alpha: 0.2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        profile.roleTitle,
                                        style: AppTheme.inter(fontSize: 11.5, fontWeight: FontWeight.w600, color: Colors.white),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(alpha: 0.16),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        profile.section,
                                        style: AppTheme.inter(fontSize: 11.5, fontWeight: FontWeight.w600, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 14),

                                Text(
                                  'Welcome back,',
                                  style: AppTheme.inter(fontSize: 12.5, fontWeight: FontWeight.w400, color: Colors.white.withValues(alpha: 0.85)),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  profile.name,
                                  style: AppTheme.poppins(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  profile.college,
                                  style: AppTheme.inter(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white.withValues(alpha: 0.85)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Today's Attendance Overview Title
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                        child: Text(
                          "Today's Attendance Overview",
                          style: AppTheme.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.ink900),
                        ),
                      ),

                      // Stat Grid (2x2)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1.35,
                          children: [
                            MetricCard(
                              label: 'Attendance',
                              value: '${state.classAttendanceRate.toStringAsFixed(2)}%',
                              subtext: '${state.presentCount}/${state.totalClassStrength} Present',
                              icon: Icons.pie_chart_outline_rounded,
                              iconColor: AppTheme.violet700,
                              iconBgColor: AppTheme.violet100,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => const ClassRegisterScreen()),
                                );
                              },
                            ),
                            MetricCard(
                              label: 'Absentees',
                              value: '${state.absentCount}',
                              subtext: 'Students',
                              icon: Icons.person_off_outlined,
                              iconColor: AppTheme.pink500,
                              iconBgColor: AppTheme.pink100,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => const ClassRegisterScreen(initialFilter: 'Absent today')),
                                );
                              },
                            ),
                            MetricCard(
                              label: 'Pending Slips',
                              value: '${state.pendingSlipsCount}',
                              subtext: 'Needs HOD',
                              icon: Icons.hourglass_top_rounded,
                              iconColor: AppTheme.amber500,
                              iconBgColor: AppTheme.amber100,
                            ),
                            MetricCard(
                              label: 'On-Duty (OD)',
                              value: '${state.onDutyCount}',
                              subtext: 'Proofs Attached',
                              icon: Icons.badge_outlined,
                              iconColor: const Color(0xFF2563EB),
                              iconBgColor: const Color(0xFFEFF6FF),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => const ClassRegisterScreen(initialFilter: 'On Duty (OD)')),
                                );
                              },
                            ),
                          ],
                        ),
                      ),

                      // Today's Live Timetable Card (III Year Section B)
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const TimetableScreen()),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(color: const Color(0xFFE5E7EB)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.04),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF10B981).withValues(alpha: 0.12),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 6,
                                          height: 6,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFF10B981),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          'P2 Live · MB III A-202',
                                          style: AppTheme.inter(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF10B981)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    'Full Timetable →',
                                    style: AppTheme.inter(fontSize: 11.5, fontWeight: FontWeight.w700, color: AppTheme.violet600),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Container(
                                    width: 38,
                                    height: 38,
                                    decoration: BoxDecoration(
                                      gradient: AppTheme.primaryGradient,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'AP',
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Aptitude Training [AP]',
                                          style: AppTheme.poppins(fontSize: 13.5, fontWeight: FontWeight.w700, color: AppTheme.ink900),
                                        ),
                                        Text(
                                          'Faculty: Mr. C. Kavin Prakash [CK]',
                                          style: AppTheme.inter(fontSize: 11, color: AppTheme.ink600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Raptor Smart Board AI Camera Highlight Card
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E1B2E),
                          borderRadius: BorderRadius.circular(22),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF7C3AED).withValues(alpha: 0.25),
                              blurRadius: 14,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF67E8F9).withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: const Color(0xFF67E8F9)),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 6,
                                        height: 6,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF67E8F9),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        'Raptor Smart Board AI Camera',
                                        style: AppTheme.inter(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF67E8F9)),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => const AttendanceHistoryGalleryScreen()),
                                    );
                                  },
                                  child: Text(
                                    'History Gallery →',
                                    style: AppTheme.inter(fontSize: 11.5, fontWeight: FontWeight.w600, color: const Color(0xFFA5B4FC)),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Instant In-Class Face Detection Attendance',
                              style: AppTheme.poppins(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Take photo via Raptor smart board or camera to scan all 60 students of III Year B and send the report to HOD.',
                              style: AppTheme.inter(fontSize: 11.5, color: Colors.white70, height: 1.4),
                            ),
                            const SizedBox(height: 14),

                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const RaptorCameraScannerScreen(
                                      initialYear: '3rd Year',
                                      initialSection: 'B',
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  gradient: AppTheme.primaryGradient,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.camera_alt_rounded, color: Colors.white, size: 18),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Scan Attendance for P2 (Aptitude)',
                                      style: AppTheme.inter(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Quick Actions Section
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                        child: Text(
                          'Quick Actions',
                          style: AppTheme.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.ink900),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: _QuickActionCard(
                                icon: Icons.calendar_month_rounded,
                                label: 'Timetable',
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => const TimetableScreen()),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _QuickActionCard(
                                icon: Icons.camera_enhance_rounded,
                                label: 'Camera Scan',
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => const RaptorCameraScannerScreen(initialYear: '3rd Year', initialSection: 'B')),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _QuickActionCard(
                                icon: Icons.checklist_rounded,
                                label: 'Register',
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => const ClassRegisterScreen()),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _QuickActionCard(
                                icon: Icons.post_add_rounded,
                                label: 'Pink Slip',
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (_) => const IssuePinkSlipModal(),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Recent Pink Slips Header
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Recent Pink Slips',
                              style: AppTheme.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.ink900),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => const ClassRegisterScreen(initialFilter: 'Letter pending')),
                                );
                              },
                              child: Text(
                                'View All',
                                style: AppTheme.inter(fontSize: 12.5, fontWeight: FontWeight.w700, color: AppTheme.violet600),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Pink Slips List
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: slips.length,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemBuilder: (context, index) {
                          final slip = slips[index];
                          final isApproved = slip.status == SlipStatus.approved;

                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(color: AppTheme.line),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.ink900.withValues(alpha: 0.02),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(18),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(18),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => PinkSlipDetailScreen(slip: slip),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(14),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      // Status Icon Box
                                      Container(
                                        width: 38,
                                        height: 38,
                                        decoration: BoxDecoration(
                                          color: isApproved ? AppTheme.green100 : AppTheme.pink100,
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            isApproved ? Icons.check_rounded : Icons.hourglass_top_rounded,
                                            size: 18,
                                            color: isApproved ? AppTheme.green600 : AppTheme.pink500,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),

                                      // Student Info & Pipeline
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              slip.studentName,
                                              style: AppTheme.inter(fontSize: 14, fontWeight: FontWeight.w700, color: AppTheme.ink900),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              '${slip.rollNumber} · ${slip.reason}',
                                              style: AppTheme.inter(fontSize: 11.5, fontWeight: FontWeight.w400, color: AppTheme.ink600),
                                            ),
                                            const SizedBox(height: 8),
                                            PipelineStepper(steps: slip.pipelineState),
                                          ],
                                        ),
                                      ),

                                      // Status Pill
                                      StatusBadge(status: slip.status),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      // Footer Subtitle Note
                      Padding(
                        padding: const EdgeInsets.only(top: 14, bottom: 20),
                        child: Center(
                          child: Text(
                            '— pipeline: submitted · adviser · hod —',
                            style: AppTheme.inter(fontSize: 11, fontWeight: FontWeight.w500, color: AppTheme.ink400),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Floating Jarvis FAB
                Positioned(
                  right: 20,
                  bottom: 20,
                  child: JarvisFab(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const JarvisChatScreen()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppTheme.line),
        ),
        child: Column(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: AppTheme.violet100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Icon(icon, size: 18, color: AppTheme.violet600),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: AppTheme.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.ink900),
            ),
          ],
        ),
      ),
    );
  }
}
