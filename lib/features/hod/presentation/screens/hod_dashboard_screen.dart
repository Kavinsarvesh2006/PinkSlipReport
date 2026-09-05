import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../shared/state/app_state_manager.dart';
import '../../../authentication/domain/models/user_role.dart';
import '../../../shared/widgets/app_header.dart';
import '../../../shared/widgets/metric_card.dart';
import '../../../shared/widgets/pipeline_stepper.dart';
import '../../../shared/widgets/status_badge.dart';
import '../../../shared/widgets/authority_banner.dart';
import '../../../pink_slips/presentation/screens/pink_slip_detail_screen.dart';
import '../../../pink_slips/domain/models/pink_slip.dart';
import 'biometric_log_screen.dart';
import 'hod_photo_audit_screen.dart';
import '../../../advisor/presentation/screens/class_register_screen.dart';
import '../../../attendance/presentation/screens/raptor_camera_scanner_screen.dart';
import '../../../jarvis/presentation/jarvis_fab.dart';
import '../../../jarvis/presentation/jarvis_chat_screen.dart';

class HodDashboardScreen extends StatefulWidget {
  const HodDashboardScreen({super.key});

  @override
  State<HodDashboardScreen> createState() => _HodDashboardScreenState();
}

class _HodDashboardScreenState extends State<HodDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppStateManager.instance,
      builder: (context, _) {
        final state = AppStateManager.instance;
        if (!state.isAuthenticated || state.currentRole != UserRole.hod) {
          return Scaffold(
            backgroundColor: AppTheme.lavenderBg,
            appBar: AppBar(
              backgroundColor: AppTheme.lavenderBg,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: AppTheme.ink900),
                onPressed: () => Navigator.pushReplacementNamed(context, '/sign-in'),
              ),
              title: Text('Access Restricted', style: AppTheme.poppins(fontSize: 16, fontWeight: FontWeight.w700)),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.lock_person_rounded, size: 54, color: AppTheme.pink500),
                    const SizedBox(height: 16),
                    Text('HOD Authorization Required', style: AppTheme.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.ink900)),
                    const SizedBox(height: 8),
                    Text('This dashboard is restricted strictly to authenticated Head of Department accounts.', textAlign: TextAlign.center, style: AppTheme.inter(fontSize: 12.5, color: AppTheme.ink600)),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => Navigator.pushReplacementNamed(context, '/sign-in'),
                      style: ElevatedButton.styleFrom(backgroundColor: AppTheme.violet600, foregroundColor: Colors.white),
                      child: const Text('Return to Sign In'),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        final profile = state.currentProfile;
        final approvalQueue = state.hodApprovalQueue;

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
                      const AppHeader(),
                      AuthorityBanner(
                        isHod: profile.isHodAdmin,
                        text: profile.isHodAdmin
                            ? 'HOD Admin Access · Full authority to view, edit, approve and delete records across all years'
                            : 'HOD Viewer Access · Read-only visibility across all years & sections (Modifications restricted to Primary HOD)',
                      ),
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
                                        profile.department,
                                        style: AppTheme.inter(fontSize: 11.5, fontWeight: FontWeight.w600, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 14),
                                Text(
                                  'Welcome back,',
                                  style: AppTheme.inter(fontSize: 12.5, color: Colors.white.withValues(alpha: 0.85)),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  profile.name,
                                  style: AppTheme.poppins(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  profile.college,
                                  style: AppTheme.inter(fontSize: 12, color: Colors.white.withValues(alpha: 0.85)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                        child: Text(
                          'Department Overview',
                          style: AppTheme.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.ink900),
                        ),
                      ),
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
                              label: 'Dept. Attendance',
                              value: '${state.deptAttendanceRate}%',
                              subtext: '418/455 Present',
                              icon: Icons.pie_chart_outline_rounded,
                              iconColor: AppTheme.violet700,
                              iconBgColor: AppTheme.violet100,
                            ),
                            MetricCard(
                              label: 'Total Students',
                              value: '${state.totalDeptStudents}',
                              subtext: '4 Sections',
                              icon: Icons.groups_2_outlined,
                              iconColor: AppTheme.violet700,
                              iconBgColor: AppTheme.violet100,
                            ),
                            MetricCard(
                              label: 'Awaiting HOD',
                              value: '${state.awaitingHodCount}',
                              subtext: 'Final Approval',
                              icon: Icons.hourglass_top_rounded,
                              iconColor: AppTheme.amber500,
                              iconBgColor: AppTheme.amber100,
                            ),
                            MetricCard(
                              label: 'Escalated',
                              value: '${state.escalatedCount}',
                              subtext: 'Overdue >48h',
                              icon: Icons.flag_outlined,
                              iconColor: AppTheme.pink500,
                              iconBgColor: AppTheme.pink100,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Section-Wise Breakdown',
                              style: AppTheme.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.ink900),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => const ClassRegisterScreen()),
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
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: state.sections.length,
                        itemBuilder: (context, index) {
                          final sec = state.sections[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(color: AppTheme.line),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          sec.sectionName,
                                          style: AppTheme.inter(fontSize: 14, fontWeight: FontWeight.w700, color: AppTheme.ink900),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          'Adviser: ${sec.advisorName}',
                                          style: AppTheme.inter(fontSize: 11.5, color: AppTheme.ink600),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '${sec.attendancePct}%',
                                      style: AppTheme.poppins(fontSize: 15, fontWeight: FontWeight.w700, color: AppTheme.violet700),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: AppTheme.violet100,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: FractionallySizedBox(
                                    alignment: Alignment.centerLeft,
                                    widthFactor: (sec.attendancePct / 100).clamp(0.0, 1.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: AppTheme.brandIconGradient,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${sec.totalStudents} students',
                                      style: AppTheme.inter(fontSize: 11.5, color: AppTheme.ink600),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        style: AppTheme.inter(fontSize: 11.5, color: AppTheme.ink600),
                                        children: [
                                          TextSpan(
                                            text: '${sec.pendingHodCount} ',
                                            style: const TextStyle(fontWeight: FontWeight.w700, color: AppTheme.pink500),
                                          ),
                                          const TextSpan(text: 'pending HOD'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Needs Your Approval',
                              style: AppTheme.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.ink900),
                            ),
                            Text(
                              '${approvalQueue.length} pending',
                              style: AppTheme.inter(fontSize: 12.5, fontWeight: FontWeight.w600, color: AppTheme.amber500),
                            ),
                          ],
                        ),
                      ),
                      if (approvalQueue.isEmpty)
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(color: AppTheme.line),
                          ),
                          child: Center(
                            child: Text(
                              'All pink slips have been cleared! ✓',
                              style: AppTheme.inter(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.green600),
                            ),
                          ),
                        )
                      else
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: approvalQueue.length,
                          itemBuilder: (context, index) {
                            final slip = approvalQueue[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 14),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(color: AppTheme.line),
                              ),
                              child: Column(
                                children: [
                                  ListTile(
                                    contentPadding: const EdgeInsets.all(14),
                                    leading: Container(
                                      width: 38,
                                      height: 38,
                                      decoration: BoxDecoration(
                                        color: AppTheme.amber100,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Center(
                                        child: Icon(Icons.hourglass_top_rounded, size: 18, color: AppTheme.amber500),
                                      ),
                                    ),
                                    title: Text(
                                      slip.studentName,
                                      style: AppTheme.inter(fontSize: 14, fontWeight: FontWeight.w700, color: AppTheme.ink900),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 2),
                                        Text(
                                          '${slip.rollNumber} · ${slip.section} · ${slip.reason}',
                                          style: AppTheme.inter(fontSize: 11.5, color: AppTheme.ink600),
                                        ),
                                        const SizedBox(height: 6),
                                        PipelineStepper(steps: slip.pipelineState),
                                      ],
                                    ),
                                    trailing: const StatusBadge(status: SlipStatus.hodReview),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => PinkSlipDetailScreen(slip: slip),
                                        ),
                                      );
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
                                    child: profile.isHodAdmin
                                        ? Row(
                                            children: [
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    state.rejectPinkSlip(slip.id);
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(
                                                        content: Text('Rejected slip for ${slip.studentName}'),
                                                        behavior: SnackBarBehavior.floating,
                                                      ),
                                                    );
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                                    decoration: BoxDecoration(
                                                      color: AppTheme.pink100,
                                                      borderRadius: BorderRadius.circular(12),
                                                      border: Border.all(color: const Color(0xFFFBCFDA)),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        '✕ Reject',
                                                        style: AppTheme.inter(fontSize: 12.5, fontWeight: FontWeight.w700, color: AppTheme.pink500),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    state.approvePinkSlip(slip.id);
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(
                                                        content: Text('Approved slip for ${slip.studentName} ✓'),
                                                        behavior: SnackBarBehavior.floating,
                                                      ),
                                                    );
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                                    decoration: BoxDecoration(
                                                      color: AppTheme.green100,
                                                      borderRadius: BorderRadius.circular(12),
                                                      border: Border.all(color: const Color(0xFFA7F3D0)),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        '✓ Approve',
                                                        style: AppTheme.inter(fontSize: 12.5, fontWeight: FontWeight.w700, color: AppTheme.green600),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Container(
                                            padding: const EdgeInsets.symmetric(vertical: 8),
                                            decoration: BoxDecoration(
                                              color: AppTheme.lavenderBg,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              child: Text(
                                                '🔒 Read-Only: Approval actions reserved for Primary HOD Dr. R. Balamurugan',
                                                style: AppTheme.inter(fontSize: 11, color: AppTheme.ink600),
                                              ),
                                            ),
                                          ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      // Smart Board Class Photos Feed Card (HOD)
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E1B2E),
                          borderRadius: BorderRadius.circular(22),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF7C3AED).withValues(alpha: 0.2),
                              blurRadius: 12,
                              offset: const Offset(0, 5),
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
                                      const Icon(Icons.videocam_rounded, color: Color(0xFF67E8F9), size: 14),
                                      const SizedBox(width: 6),
                                      Text(
                                        'Raptor Smart Board AI Feeds',
                                        style: AppTheme.inter(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF67E8F9)),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF10B981).withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    '${state.classSessionPhotos.length} Feeds Received',
                                    style: AppTheme.inter(fontSize: 10.5, fontWeight: FontWeight.w700, color: const Color(0xFF10B981)),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Classroom Photo Evidence & AI Audit',
                              style: AppTheme.poppins(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Audit AI face detections, view captured classroom frames from advisers across all 4 years and sections, and sign off.',
                              style: AppTheme.inter(fontSize: 11.5, color: Colors.white70, height: 1.4),
                            ),
                            const SizedBox(height: 14),

                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (_) => const HodPhotoAuditScreen()),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                      decoration: BoxDecoration(
                                        gradient: AppTheme.primaryGradient,
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Inspect Photo Feeds',
                                          style: AppTheme.inter(fontSize: 12.5, fontWeight: FontWeight.w700, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => const RaptorCameraScannerScreen()),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF2B2844),
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(color: const Color(0xFF67E8F9).withValues(alpha: 0.5)),
                                    ),
                                    child: const Icon(Icons.camera_alt_rounded, color: Color(0xFF67E8F9), size: 18),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Quick Actions Section (HOD)
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
                              child: _HodActionCard(
                                icon: Icons.camera_enhance_rounded,
                                label: 'Camera Feeds',
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => const HodPhotoAuditScreen()),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _HodActionCard(
                                icon: Icons.done_all_rounded,
                                label: 'Approve All',
                                onTap: () {
                                  state.approveAllHod();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('All pending HOD slips approved!'),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _HodActionCard(
                                icon: Icons.fingerprint_rounded,
                                label: 'Biometric',
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => const BiometricLogScreen()),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _HodActionCard(
                                icon: Icons.assessment_outlined,
                                label: 'Reports',
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => const ClassRegisterScreen()),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18, bottom: 20),
                        child: Center(
                          child: Text(
                            '— pipeline: adviser ✓ · hod review · resolved —',
                            style: AppTheme.inter(fontSize: 11, fontWeight: FontWeight.w500, color: AppTheme.ink400),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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

class _HodActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _HodActionCard({
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
