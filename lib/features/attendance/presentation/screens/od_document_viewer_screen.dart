import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/models/attendance.dart';
import '../../../shared/state/app_state_manager.dart';

class OdDocumentViewerScreen extends StatefulWidget {
  final StudentRecord student;

  const OdDocumentViewerScreen({
    super.key,
    required this.student,
  });

  @override
  State<OdDocumentViewerScreen> createState() => _OdDocumentViewerScreenState();
}

class _OdDocumentViewerScreenState extends State<OdDocumentViewerScreen> {
  late bool _isSigned;
  late String _signedDocName;
  late String _signedDate;
  late String _proofDocName;
  late String _proofDocSize;

  @override
  void initState() {
    super.initState();
    _isSigned = widget.student.isHodSigned;
    _signedDocName = widget.student.hodSignedDocumentName ?? 'HOD_Signed_OD_Permission_Order_${widget.student.rollNumber}.pdf';
    _signedDate = widget.student.hodSignedDate ?? '24 Aug 2026, 09:15 AM';
    _proofDocName = widget.student.proofDocumentName ?? 'Anna_Univ_Hackathon_Invite_Letter.pdf';
    _proofDocSize = widget.student.proofDocumentSize ?? '1.8 MB';
  }

  void _signDocument() {
    setState(() {
      _isSigned = true;
      _signedDocName = 'HOD_Signed_OD_Permission_Order_${widget.student.rollNumber}.pdf';
      _signedDate = '31 Aug 2026, 12:40 PM';
    });
    AppStateManager.instance.signOdPermission(widget.student.id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF047857),
        content: Row(
          children: const [
            Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'HOD Digital Signature stamped & permission PDF attached! ✓',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showProofPreviewModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _ProofDocumentPreviewSheet(
        student: widget.student,
        docName: _proofDocName,
        docSize: _proofDocSize,
      ),
    );
  }

  void _showSignedLetterPreviewModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _SignedHodPermissionSheet(
        student: widget.student,
        signedDocName: _signedDocName,
        signedDate: _signedDate,
      ),
    );
  }

  void _attachNewProof() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Attach Additional Proof Document', style: AppTheme.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.ink900)),
            const SizedBox(height: 8),
            Text('Upload event registration, attendance certificate or revised HOD endorsement.', style: AppTheme.inter(fontSize: 12, color: AppTheme.ink600)),
            const SizedBox(height: 20),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: AppTheme.violet100, borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.picture_as_pdf_rounded, color: AppTheme.violet600),
              ),
              title: Text('Select PDF Document', style: AppTheme.inter(fontSize: 13.5, fontWeight: FontWeight.w600)),
              subtitle: Text('Device storage or cloud drive', style: AppTheme.inter(fontSize: 11.5, color: AppTheme.ink600)),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () {
                Navigator.pop(ctx);
                setState(() {
                  _proofDocName = 'Participation_Certificate_AnnaUniv_2026.pdf';
                  _proofDocSize = '2.1 MB';
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Attached Participation_Certificate_AnnaUniv_2026.pdf successfully! ✓')),
                );
              },
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: const Color(0xFFECFDF5), borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.camera_alt_rounded, color: Color(0xFF059669)),
              ),
              title: Text('Scan Physical Letter / Form', style: AppTheme.inter(fontSize: 13.5, fontWeight: FontWeight.w600)),
              subtitle: Text('Capture via camera and OCR', style: AppTheme.inter(fontSize: 11.5, color: AppTheme.ink600)),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () {
                Navigator.pop(ctx);
                setState(() {
                  _proofDocName = 'Scanned_Physical_OD_Form_Signed.jpg';
                  _proofDocSize = '3.4 MB';
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Attached Scanned_Physical_OD_Form_Signed.jpg successfully! ✓')),
                );
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final student = widget.student;

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
          'On-Duty Sanction Document',
          style: AppTheme.poppins(fontSize: 15.5, fontWeight: FontWeight.w700, color: AppTheme.ink900),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: AppTheme.ink900, size: 20),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Shared OD Sanction Order for ${student.name} ✓')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 8, 18, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Official College Header Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1E1B4B), Color(0xFF312E81)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF1E1B4B).withValues(alpha: 0.25),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
                        ),
                        child: const Center(
                          child: Icon(Icons.school_rounded, color: Colors.white, size: 24),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'V.S.B. ENGINEERING COLLEGE',
                              style: AppTheme.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                            Text(
                              'KARUR - 639 111 · AUTONOMOUS',
                              style: AppTheme.inter(fontSize: 10, fontWeight: FontWeight.w600, color: const Color(0xFFC7D2FE)),
                            ),
                            Text(
                              'Dept. of Artificial Intelligence & Data Science',
                              style: AppTheme.inter(fontSize: 10.5, fontWeight: FontWeight.w500, color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'REF: VSB/AIDS/OD/2026/08-${student.rollNumber.substring(student.rollNumber.length - 3)}',
                          style: const TextStyle(fontFamily: 'monospace', fontSize: 10.5, fontWeight: FontWeight.w700, color: Color(0xFFFDE047)),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: _isSigned ? const Color(0xFF10B981) : const Color(0xFFF59E0B),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            _isSigned ? 'HOD APPROVED' : 'PENDING SIGN',
                            style: const TextStyle(fontSize: 9.5, fontWeight: FontWeight.w800, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Student Information Summary Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.line),
              ),
              child: Row(
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
                        student.initials,
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
                          student.name,
                          style: AppTheme.poppins(fontSize: 15, fontWeight: FontWeight.w700, color: AppTheme.ink900),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${student.rollNumber} · III AI&DS - Section B',
                          style: AppTheme.inter(fontSize: 12, color: AppTheme.ink600),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Class Adviser: Dr. R. Murugesan [RM]',
                          style: AppTheme.inter(fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.violet600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // On Duty Sanction Details
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.line),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.event_available_rounded, color: Color(0xFF2563EB), size: 18),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'On-Duty Sanction Details',
                        style: AppTheme.poppins(fontSize: 14, fontWeight: FontWeight.w700, color: AppTheme.ink900),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  _buildMetaRow('Event / Activity', student.odReason ?? 'National Level Smart India Hackathon 2026'),
                  _buildMetaRow('Venue & Institution', student.odVenue ?? 'Anna University Main Campus, Guindy, Chennai'),
                  _buildMetaRow('Sanction Period', student.odEventDate ?? '24 Aug 2026 - 26 Aug 2026 (3 Days)'),
                  _buildMetaRow('Attendance Credit', 'Official OD Credit (Marked Present)'),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // SECTION 1: Student Attached Proof of Letter
            Text(
              '1. Attached Proof of Letter / Invitation',
              style: AppTheme.poppins(fontSize: 14, fontWeight: FontWeight.w700, color: AppTheme.ink900),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFBFDBFE)),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF3B82F6).withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFDBEAFE)),
                        ),
                        child: const Center(
                          child: Icon(Icons.picture_as_pdf_rounded, color: Color(0xFFDC2626), size: 24),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _proofDocName,
                              style: AppTheme.inter(fontSize: 12.5, fontWeight: FontWeight.w700, color: AppTheme.ink900),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '$_proofDocSize · Uploaded by Student · Verified Genuine',
                              style: AppTheme.inter(fontSize: 11, color: AppTheme.ink600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _showProofPreviewModal,
                          icon: const Icon(Icons.visibility_rounded, size: 16),
                          label: const Text('View Proof Letter'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2563EB),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            textStyle: AppTheme.inter(fontSize: 12, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      OutlinedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Downloaded $_proofDocName to Downloads folder ✓')),
                          );
                        },
                        icon: const Icon(Icons.file_download_outlined, size: 16),
                        label: const Text('Download'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF2563EB),
                          side: const BorderSide(color: Color(0xFF93C5FD)),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          textStyle: AppTheme.inter(fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // SECTION 2: Class Advisor Recommendation
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.line),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppTheme.violet100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.verified_user_rounded, color: AppTheme.violet600, size: 18),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Class Adviser Verification',
                        style: AppTheme.poppins(fontSize: 13.5, fontWeight: FontWeight.w700, color: AppTheme.ink900),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFECFDF5),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'RECOMMENDED',
                          style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w800, color: Color(0xFF059669)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Dr. R. Murugesan [RM] (Class Adviser - III AI&DS B)',
                    style: AppTheme.inter(fontSize: 12.5, fontWeight: FontWeight.w700, color: AppTheme.ink900),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '"Verified invitation letter and event dates. Genuine competition entry. Recommended for full OD sanction."',
                    style: const TextStyle(fontSize: 11.5, fontStyle: FontStyle.italic, color: Color(0xFF4B5563)),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Forwarded to HOD: 23 Aug 2026, 05:30 PM',
                    style: AppTheme.inter(fontSize: 10.5, color: AppTheme.ink400),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // SECTION 3: HOD Permission & Signed Letter Document
            Text(
              '2. HOD Permission & Signed Letter Document',
              style: AppTheme.poppins(fontSize: 14, fontWeight: FontWeight.w700, color: AppTheme.ink900),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: _isSigned ? const Color(0xFFF0FDF4) : Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: _isSigned ? const Color(0xFF86EFAC) : const Color(0xFFFDE68A),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: (_isSigned ? const Color(0xFF10B981) : const Color(0xFFF59E0B)).withValues(alpha: 0.08),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: _isSigned ? const Color(0xFFDCFCE7) : const Color(0xFFFEF3C7),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _isSigned ? const Color(0xFF86EFAC) : const Color(0xFFFCD34D)),
                        ),
                        child: Center(
                          child: Icon(
                            _isSigned ? Icons.verified_rounded : Icons.pending_actions_rounded,
                            color: _isSigned ? const Color(0xFF059669) : const Color(0xFFD97706),
                            size: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _isSigned ? 'HOD Signed Sanction Document' : 'Awaiting HOD Digital Signature',
                              style: AppTheme.poppins(fontSize: 14, fontWeight: FontWeight.w700, color: AppTheme.ink900),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _isSigned
                                  ? 'Dr. S. Manivannan, M.E., Ph.D. (Overall HOD / AI&DS)'
                                  : 'Submitted to HOD Office for formal permission',
                              style: AppTheme.inter(fontSize: 11.5, color: AppTheme.ink600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  if (_isSigned) ...[
                    // Signed document chip
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFBBF7D0)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.picture_as_pdf_rounded, color: Color(0xFFDC2626), size: 20),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  _signedDocName,
                                  style: AppTheme.inter(fontSize: 12, fontWeight: FontWeight.w700, color: AppTheme.ink900),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFDCFCE7),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  '2.4 MB · PDF',
                                  style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w700, color: Color(0xFF047857)),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Signed on: $_signedDate · Digital Cert #VSB-OD-8924',
                            style: AppTheme.inter(fontSize: 10.5, color: AppTheme.ink400),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _showSignedLetterPreviewModal,
                            icon: const Icon(Icons.assignment_turned_in_rounded, size: 16),
                            label: const Text('View Signed Letter'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF059669),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              textStyle: AppTheme.inter(fontSize: 12, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        OutlinedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Downloaded $_signedDocName with official seal ✓')),
                            );
                          },
                          icon: const Icon(Icons.download_rounded, size: 16),
                          label: const Text('Download PDF'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF059669),
                            side: const BorderSide(color: Color(0xFF86EFAC)),
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            textStyle: AppTheme.inter(fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ] else ...[
                    Text(
                      'The proof of letter has been forwarded by Class Adviser. Tap below to digitally stamp and grant HOD permission.',
                      style: AppTheme.inter(fontSize: 11.5, color: AppTheme.ink600),
                    ),
                    const SizedBox(height: 14),
                    ElevatedButton.icon(
                      onPressed: _signDocument,
                      icon: const Icon(Icons.draw_rounded, size: 18),
                      label: const Text('Digitally Sign & Attach Permission Order'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD97706),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        minimumSize: const Size(double.infinity, 46),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        textStyle: AppTheme.inter(fontSize: 12.5, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Additional Attachments Action
            OutlinedButton.icon(
              onPressed: _attachNewProof,
              icon: const Icon(Icons.attach_file_rounded, size: 18),
              label: const Text('Attach Additional Document / Certificate'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.violet600,
                side: const BorderSide(color: Color(0xFFC4B5FD)),
                backgroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 46),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                textStyle: AppTheme.inter(fontSize: 12.5, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetaRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 125,
            child: Text(label, style: AppTheme.inter(fontSize: 11.5, color: AppTheme.ink600)),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTheme.inter(fontSize: 12, fontWeight: FontWeight.w700, color: AppTheme.ink900),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Student Proof Invitation Preview Sheet
// ---------------------------------------------------------------------------
class _ProofDocumentPreviewSheet extends StatelessWidget {
  final StudentRecord student;
  final String docName;
  final String docSize;

  const _ProofDocumentPreviewSheet({
    required this.student,
    required this.docName,
    required this.docSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        children: [
          // Drag handle
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppTheme.line,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Attached Proof Document', style: AppTheme.poppins(fontSize: 15, fontWeight: FontWeight.w700)),
                    Text(docName, style: AppTheme.inter(fontSize: 11, color: AppTheme.ink600)),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppTheme.line),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          const Icon(Icons.domain_verification_rounded, size: 36, color: Color(0xFF1E3A8A)),
                          const SizedBox(height: 6),
                          const Text(
                            'ANNA UNIVERSITY, CHENNAI',
                            style: TextStyle(fontFamily: 'serif', fontSize: 13.5, fontWeight: FontWeight.w800, color: Color(0xFF1E3A8A)),
                          ),
                          const Text(
                            'Centre for Student Affairs & Technical Symposia',
                            style: TextStyle(fontSize: 10, color: Colors.black54),
                          ),
                          const SizedBox(height: 12),
                          Container(height: 2, color: const Color(0xFF1E3A8A)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('OFFICIAL INVITATION & SELECTION LETTER', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87)),
                    const SizedBox(height: 10),
                    Text(
                      'To,\nThe Head of the Department,\nDept. of Artificial Intelligence and Data Science,\nV.S.B. Engineering College, Karur.',
                      style: AppTheme.inter(fontSize: 11.5, color: Colors.black87, height: 1.4),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Subject: Selection of ${student.name} (${student.rollNumber}) for Grand Finale Hackathon 2026 - Reg.\n\nDear Sir/Madam,\n\nWe are pleased to inform you that your student team led by ${student.name} has been shortlisted for the Grand Finale of the National Level Hackathon 2026 held at Anna University, Chennai during August 24-26, 2026.\n\nKindly grant necessary On-Duty (OD) permission and attendance relief to enable their participation.\n\nThanking you,',
                      style: AppTheme.inter(fontSize: 11.5, color: Colors.black87, height: 1.5),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Date: 22-08-2026\nChennai', style: TextStyle(fontSize: 10.5, color: Colors.black54)),
                        Text('Dr. M. Soundararajan\nConvenor, Hackathon 2026', textAlign: TextAlign.right, style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold, color: Colors.black87)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Downloaded $docName ✓')),
                      );
                    },
                    icon: const Icon(Icons.download_rounded, size: 16),
                    label: const Text('Download Full Attachment'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.violet600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Official HOD Signed Permission Document Sheet
// ---------------------------------------------------------------------------
class _SignedHodPermissionSheet extends StatelessWidget {
  final StudentRecord student;
  final String signedDocName;
  final String signedDate;

  const _SignedHodPermissionSheet({
    required this.student,
    required this.signedDocName,
    required this.signedDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.88,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppTheme.line,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('HOD Signed OD Permission Letter', style: AppTheme.poppins(fontSize: 15, fontWeight: FontWeight.w700)),
                    Text(signedDocName, style: AppTheme.inter(fontSize: 11, color: AppTheme.ink600)),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppTheme.line),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          const Icon(Icons.account_balance_rounded, size: 36, color: Color(0xFF312E81)),
                          const SizedBox(height: 6),
                          const Text(
                            'V.S.B. ENGINEERING COLLEGE, KARUR',
                            style: TextStyle(fontFamily: 'serif', fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF1E1B4B)),
                          ),
                          const Text(
                            'DEPARTMENT OF ARTIFICIAL INTELLIGENCE & DATA SCIENCE',
                            style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w700, color: Color(0xFF4338CA)),
                          ),
                          const SizedBox(height: 12),
                          Container(height: 2, color: const Color(0xFF4338CA)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEEF2FF),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: const Color(0xFFC7D2FE)),
                        ),
                        child: const Text(
                          'OFFICIAL OD SANCTION & PERMISSION ORDER',
                          style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w800, color: Color(0xFF3730A3)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'REF NO: VSB/AIDS/OD/2026/08-${student.rollNumber.substring(student.rollNumber.length - 3)}',
                      style: const TextStyle(fontFamily: 'monospace', fontSize: 11, fontWeight: FontWeight.w700, color: Colors.black87),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'STUDENT NAME : ${student.name}\nREGISTER NO  : ${student.rollNumber}\nBRANCH / SEC : III Year AI&DS - Section B\nCLASS ADVISER: Dr. R. Murugesan [RM]',
                      style: const TextStyle(fontFamily: 'monospace', fontSize: 11, color: Colors.black87, height: 1.4),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'PERMISSION SANCTION ORDER:\n\n1. In reference to the invitation submitted, the student is hereby granted Official On-Duty (OD) Leave from 24-08-2026 to 26-08-2026 for participating in the National Level Hackathon 2026 at Anna University.\n\n2. The Class Adviser is instructed to mark the student\'s attendance as "Present on Official Duty (OD)" for all scheduled periods.\n\n3. The student shall submit the participation certificate upon return.',
                      style: AppTheme.inter(fontSize: 11.5, color: Colors.black87, height: 1.5),
                    ),
                    const SizedBox(height: 20),

                    // Digital Seal & Stamp Box
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0FDF4),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFF86EFAC), width: 1.5),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFFDCFCE7),
                              border: Border.all(color: const Color(0xFF10B981)),
                            ),
                            child: const Icon(Icons.verified_rounded, color: Color(0xFF059669), size: 28),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'DIGITALLY SIGNED & SANCTIONED',
                                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF047857)),
                                ),
                                const SizedBox(height: 2),
                                const Text(
                                  'Dr. S. Manivannan, M.E., Ph.D.',
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF064E3B)),
                                ),
                                const Text(
                                  'Head of the Department (Overall) · Dept. of AI&DS',
                                  style: TextStyle(fontSize: 10, color: Color(0xFF065F46)),
                                ),
                                Text(
                                  'Timestamp: $signedDate',
                                  style: const TextStyle(fontSize: 9.5, color: Color(0xFF047857)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Downloaded $signedDocName with official seal ✓')),
                );
              },
              icon: const Icon(Icons.file_download_rounded, size: 18),
              label: const Text('Download Official Signed PDF Letter'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF059669),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                textStyle: AppTheme.inter(fontSize: 13, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
