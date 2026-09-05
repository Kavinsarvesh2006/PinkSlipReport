import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/models/pink_slip.dart';
import '../../../shared/state/app_state_manager.dart';
import '../../../shared/widgets/status_badge.dart';
import '../../../attendance/domain/models/attendance.dart';
import '../../../attendance/presentation/screens/od_document_viewer_screen.dart';

class PinkSlipDetailScreen extends StatelessWidget {
  final PinkSlip slip;

  const PinkSlipDetailScreen({super.key, required this.slip});

  @override
  Widget build(BuildContext context) {
    final hasProof = slip.attachedProofName != null || slip.isOd;
    

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
          slip.isOd ? 'On-Duty Sanction Detail' : 'Pink Slip Detail',
          style: AppTheme.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.ink900),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert_rounded, color: AppTheme.ink600),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.line),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          gradient: AppTheme.primaryGradient,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Center(
                          child: Text(
                            slip.initials,
                            style: AppTheme.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              slip.studentName,
                              style: AppTheme.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.ink900),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${slip.rollNumber} · ${slip.section}',
                              style: AppTheme.inter(fontSize: 12, color: AppTheme.ink600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: AppTheme.line, height: 1),
                  _buildDetailRow('Reason', slip.reason),
                  _buildDetailRow('Type', slip.isOd ? 'Official On-Duty (OD)' : 'Leave / Notice'),
                  _buildDetailRow('Raised by', slip.raisedBy),
                  _buildDetailRow('Raised on', '22 Aug 2026, 10:14 AM'),
                  _buildDetailRow('Days pending', '${slip.daysPending} days', valueColor: AppTheme.pink500),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Current stage', style: AppTheme.inter(fontSize: 12.5, color: AppTheme.ink600)),
                        StatusBadge(status: slip.status),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Attached Proof of Letter Section
            if (hasProof) ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 20, 0, 10),
                child: Text(
                  'Attached Proof Document',
                  style: AppTheme.poppins(fontSize: 14, fontWeight: FontWeight.w700, color: AppTheme.ink900),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFFBFDBFE)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFF6FF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.picture_as_pdf_rounded, color: Color(0xFFDC2626), size: 24),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                slip.attachedProofName ?? 'Anna_University_Hackathon_Invite_2026.pdf',
                                style: AppTheme.inter(fontSize: 12.5, fontWeight: FontWeight.w700, color: AppTheme.ink900),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                '${slip.attachedProofSize ?? "1.8 MB"} · Proof of Letter / Invitation',
                                style: AppTheme.inter(fontSize: 11, color: AppTheme.ink600),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Find matching student record from roster
                        final matchingStudent = AppStateManager.instance.roster.firstWhere(
                          (s) => s.rollNumber == slip.rollNumber,
                          orElse: () => StudentRecord(
                            id: slip.rollNumber,
                            name: slip.studentName,
                            rollNumber: slip.rollNumber,
                            section: slip.section,
                            isOnDuty: true,
                            isHodSigned: slip.status == SlipStatus.approved,
                            proofDocumentName: slip.attachedProofName,
                            hodSignedDocumentName: slip.hodSignedDocName,
                          ),
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => OdDocumentViewerScreen(student: matchingStudent),
                          ),
                        );
                      },
                      icon: const Icon(Icons.visibility_rounded, size: 16),
                      label: const Text('Open Letterhead & HOD Signed Copy'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2563EB),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 42),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        textStyle: AppTheme.inter(fontSize: 12, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            Padding(
              padding: const EdgeInsets.fromLTRB(4, 20, 0, 12),
              child: Text(
                'Approval Timeline',
                style: AppTheme.poppins(fontSize: 15, fontWeight: FontWeight.w700, color: AppTheme.ink900),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.line),
              ),
              child: Column(
                children: List.generate(slip.timeline.length, (index) {
                  final stage = slip.timeline[index];
                  final isLast = index == slip.timeline.length - 1;

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: stage.isDone
                                  ? AppTheme.green600
                                  : stage.isCurrent
                                      ? AppTheme.amber500
                                      : Colors.white,
                              border: stage.isDone || stage.isCurrent
                                  ? null
                                  : Border.all(color: AppTheme.line, width: 2),
                            ),
                            child: Center(
                              child: Icon(
                                stage.isDone
                                    ? Icons.check
                                    : stage.isCurrent
                                        ? Icons.hourglass_top_rounded
                                        : Icons.circle,
                                size: 14,
                                color: stage.isDone || stage.isCurrent ? Colors.white : AppTheme.ink400,
                              ),
                            ),
                          ),
                          if (!isLast)
                            Container(
                              width: 2,
                              height: stage.note != null ? 70 : 45,
                              color: stage.isDone ? AppTheme.green600 : AppTheme.line,
                            ),
                        ],
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                stage.title,
                                style: AppTheme.inter(fontSize: 13.5, fontWeight: FontWeight.w700, color: AppTheme.ink900),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                stage.when,
                                style: AppTheme.inter(fontSize: 11.5, color: AppTheme.ink400),
                              ),
                              if (stage.note != null) ...[
                                const SizedBox(height: 6),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: AppTheme.lavenderBg,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    stage.note!,
                                    style: AppTheme.inter(fontSize: 12, color: AppTheme.ink600),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
            const SizedBox(height: 24),

            if (AppStateManager.instance.canCurrentUserEdit) ...[
              GestureDetector(
                onTap: () {
                  AppStateManager.instance.approvePinkSlip(slip.id);
                  AppStateManager.instance.signOdPermission(slip.rollNumber);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Approved & permission signed successfully! ✓')),
                  );
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.violet600.withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      slip.isOd ? '✍️ Sign & Grant OD Permission' : 'Approve Pink Slip',
                      style: AppTheme.inter(fontSize: 14.5, fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () {
                  AppStateManager.instance.rejectPinkSlip(slip.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Rejected with note')),
                  );
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: AppTheme.pink100,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFFBCFDA)),
                  ),
                  child: Center(
                    child: Text(
                      '✕ Reject with Note',
                      style: AppTheme.inter(fontSize: 13.5, fontWeight: FontWeight.w700, color: AppTheme.pink500),
                    ),
                  ),
                ),
              ),
            ] else ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.lavenderBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.line),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.lock_outline_rounded, color: AppTheme.ink600, size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Read-Only View: Approvals & edits can only be performed by Primary HOD (Dr. S. Manivannan) or the designated Section Class Advisor.',
                        style: AppTheme.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.ink600),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTheme.inter(fontSize: 12.5, color: AppTheme.ink600)),
          Text(
            value,
            style: AppTheme.inter(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: valueColor ?? AppTheme.ink900,
            ),
          ),
        ],
      ),
    );
  }
}
