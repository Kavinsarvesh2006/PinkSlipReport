import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../shared/state/app_state_manager.dart';

class ApplyOdModal extends StatefulWidget {
  const ApplyOdModal({super.key});

  @override
  State<ApplyOdModal> createState() => _ApplyOdModalState();
}

class _ApplyOdModalState extends State<ApplyOdModal> {
  String _selectedRoll = '922524243068';
  String _selectedCategory = 'Hackathon / Coding Contest';
  final TextEditingController _eventNameController = TextEditingController(text: 'National Level Smart India Hackathon 2026');
  final TextEditingController _venueController = TextEditingController(text: 'Anna University Main Campus, Guindy, Chennai');
  final TextEditingController _datesController = TextEditingController(text: '24 Aug 2026 - 26 Aug 2026 (3 Days)');
  
  String? _attachedDocName = 'Anna_Univ_Hackathon_Selection_Letter.pdf';
  String? _attachedDocSize = '1.8 MB';
  bool _isUploading = false;

  final List<String> _categories = [
    'Hackathon / Coding Contest',
    'Technical Symposium & Paper',
    'Sports & Athletic Meet',
    'NSS / NCC / Social Drive',
    'Internship / Placement Drive',
    'External Project / Industrial Visit',
  ];

  void _pickProofFile() {
    setState(() => _isUploading = true);
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() {
          _isUploading = false;
          _attachedDocName = 'Signed_Event_Invitation_Letter_2026.pdf';
          _attachedDocSize = '2.3 MB';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Attached Signed_Event_Invitation_Letter_2026.pdf successfully! ✓')),
        );
      }
    });
  }

  void _submitOdRequest() {
    if (_attachedDocName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Please attach proof of letter before submitting OD request!'),
        ),
      );
      return;
    }

    AppStateManager.instance.applyOdRequest(
      studentRoll: _selectedRoll,
      reason: _eventNameController.text.trim(),
      venue: _venueController.text.trim(),
      eventDate: _datesController.text.trim(),
      proofName: _attachedDocName!,
      proofSize: _attachedDocSize!,
    );

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF047857),
        content: Row(
          children: const [
            Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'On-Duty request & attached proof submitted to HOD queue! ✓',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = AppStateManager.instance;
    final roster = state.scopedRoster.isNotEmpty ? state.scopedRoster : state.roster;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppTheme.line,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.description_rounded, color: Color(0xFF2563EB), size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Apply On-Duty (OD) Permission',
                        style: AppTheme.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.ink900),
                      ),
                      Text(
                        'Attach proof of letter & route for HOD digital signature',
                        style: AppTheme.inter(fontSize: 11.5, color: AppTheme.ink600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),

            // Select Student Dropdown
            Text('Select Student', style: AppTheme.inter(fontSize: 12, fontWeight: FontWeight.w700, color: AppTheme.ink900)),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: AppTheme.lavenderBg,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppTheme.line),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedRoll,
                  isExpanded: true,
                  items: roster.map((s) {
                    return DropdownMenuItem(
                      value: s.rollNumber,
                      child: Text(
                        '${s.name} (${s.rollNumber})',
                        style: AppTheme.inter(fontSize: 12.5, fontWeight: FontWeight.w600, color: AppTheme.ink900),
                      ),
                    );
                  }).toList(),
                  onChanged: (v) => setState(() => _selectedRoll = v!),
                ),
              ),
            ),
            const SizedBox(height: 14),

            // OD Category
            Text('OD Category', style: AppTheme.inter(fontSize: 12, fontWeight: FontWeight.w700, color: AppTheme.ink900)),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: AppTheme.lavenderBg,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppTheme.line),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedCategory,
                  isExpanded: true,
                  items: _categories.map((c) {
                    return DropdownMenuItem(
                      value: c,
                      child: Text(
                        c,
                        style: AppTheme.inter(fontSize: 12.5, fontWeight: FontWeight.w600, color: AppTheme.ink900),
                      ),
                    );
                  }).toList(),
                  onChanged: (v) => setState(() => _selectedCategory = v!),
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Event Title
            Text('Event / Competition Name', style: AppTheme.inter(fontSize: 12, fontWeight: FontWeight.w700, color: AppTheme.ink900)),
            const SizedBox(height: 6),
            TextField(
              controller: _eventNameController,
              style: AppTheme.inter(fontSize: 12.5, color: AppTheme.ink900),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppTheme.lavenderBg,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppTheme.line)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppTheme.line)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              ),
            ),
            const SizedBox(height: 14),

            // Venue
            Text('Venue & Organizing Institution', style: AppTheme.inter(fontSize: 12, fontWeight: FontWeight.w700, color: AppTheme.ink900)),
            const SizedBox(height: 6),
            TextField(
              controller: _venueController,
              style: AppTheme.inter(fontSize: 12.5, color: AppTheme.ink900),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppTheme.lavenderBg,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppTheme.line)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppTheme.line)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              ),
            ),
            const SizedBox(height: 14),

            // Attach Proof of Letter File (Required)
            Text('Attach Proof of Letter / Invitation (Mandatory)', style: AppTheme.inter(fontSize: 12, fontWeight: FontWeight.w700, color: AppTheme.ink900)),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFCBD5E1), style: BorderStyle.solid),
              ),
              child: _attachedDocName != null
                  ? Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFF6FF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.picture_as_pdf_rounded, color: Color(0xFFDC2626), size: 24),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _attachedDocName!,
                                style: AppTheme.inter(fontSize: 12, fontWeight: FontWeight.w700, color: AppTheme.ink900),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                '$_attachedDocSize · Verified Genuine Proof',
                                style: AppTheme.inter(fontSize: 10.5, color: const Color(0xFF059669)),
                              ),
                            ],
                          ),
                        ),
                        _isUploading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(strokeWidth: 2.5),
                              )
                            : IconButton(
                                icon: const Icon(Icons.change_circle_rounded, color: AppTheme.violet600),
                                onPressed: _pickProofFile,
                                tooltip: 'Change File',
                              ),
                      ],
                    )
                  : InkWell(
                      onTap: _pickProofFile,
                      child: Center(
                        child: _isUploading
                            ? const Padding(
                                padding: EdgeInsets.all(12),
                                child: CircularProgressIndicator(strokeWidth: 2.5),
                              )
                            : Column(
                          children: [
                            const Icon(Icons.cloud_upload_rounded, color: AppTheme.violet600, size: 32),
                            const SizedBox(height: 6),
                            Text('Upload Proof Letter (PDF / JPG)', style: AppTheme.inter(fontSize: 12, fontWeight: FontWeight.w700, color: AppTheme.violet600)),
                            Text('Invitation letter, brochure or registration proof', style: AppTheme.inter(fontSize: 10.5, color: AppTheme.ink400)),
                          ],
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 20),

            // Submit Button
            ElevatedButton(
              onPressed: _submitOdRequest,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.violet600,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                textStyle: AppTheme.inter(fontSize: 14, fontWeight: FontWeight.w700),
              ),
              child: const Text('Submit OD Request to HOD Sign Queue'),
            ),
          ],
        ),
      ),
    );
  }
}
