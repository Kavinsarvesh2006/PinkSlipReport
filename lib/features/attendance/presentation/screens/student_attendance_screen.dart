import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../shared/state/app_state_manager.dart';
import '../../../shared/widgets/app_header.dart';
import '../../../pink_slips/presentation/screens/pink_slip_detail_screen.dart';

class StudentAttendanceScreen extends StatelessWidget {
  const StudentAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppStateManager.instance,
      builder: (context, _) {
        final state = AppStateManager.instance;
        final profile = state.currentProfile;
        final subjects = state.studentSubjects;
        final studentSlips = state.pinkSlips.where((s) => s.studentName.contains('Lithesh')).toList();

        return Scaffold(
          backgroundColor: AppTheme.lavenderBg,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppHeader(),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      gradient: AppTheme.primaryGradient,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Student Dashboard', style: AppTheme.inter(fontSize: 12, color: Colors.white.withValues(alpha: 0.85))),
                        const SizedBox(height: 4),
                        Text(profile.name, style: AppTheme.poppins(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
                        Text('${profile.id} · ${profile.section}', style: AppTheme.inter(fontSize: 12, color: Colors.white.withValues(alpha: 0.85))),
                        const SizedBox(height: 14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Overall Attendance', style: AppTheme.inter(fontSize: 13, color: Colors.white)),
                            Text('92.4%', style: AppTheme.poppins(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                    child: Text(
                      'Subject-Wise Attendance',
                      style: AppTheme.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.ink900),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: subjects.length,
                    itemBuilder: (context, index) {
                      final sub = subjects[index];
                      final pct = sub.percentage;
                      final isLow = pct < 75.0;

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
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(sub.name, style: AppTheme.inter(fontSize: 13.5, fontWeight: FontWeight.w700, color: AppTheme.ink900)),
                                      Text(sub.code, style: AppTheme.inter(fontSize: 11.5, color: AppTheme.ink600)),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: isLow ? AppTheme.pink100 : AppTheme.green100,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    '${pct.toStringAsFixed(1)}%',
                                    style: AppTheme.poppins(
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w700,
                                      color: isLow ? AppTheme.pink500 : AppTheme.green600,
                                    ),
                                  ),
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
                                widthFactor: (pct / 100).clamp(0.0, 1.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: isLow ? AppTheme.pink500 : AppTheme.green600,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${sub.presentCount}/${sub.totalCount} classes attended',
                              style: AppTheme.inter(fontSize: 11, color: AppTheme.ink400),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                    child: Text(
                      'My Pink Slips & Notices',
                      style: AppTheme.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.ink900),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: studentSlips.length,
                    itemBuilder: (context, index) {
                      final slip = studentSlips[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => PinkSlipDetailScreen(slip: slip)),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppTheme.line),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: AppTheme.pink100,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: Icon(Icons.warning_amber_rounded, size: 18, color: AppTheme.pink500),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(slip.reason, style: AppTheme.inter(fontSize: 13, fontWeight: FontWeight.w700, color: AppTheme.ink900)),
                                    Text('Issued by ${slip.raisedBy}', style: AppTheme.inter(fontSize: 11, color: AppTheme.ink600)),
                                  ],
                                ),
                              ),
                              const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppTheme.ink400),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
