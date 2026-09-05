import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../shared/state/app_state_manager.dart';
import '../../../shared/widgets/authority_banner.dart';
import '../../../attendance/presentation/screens/photo_attendance_review_screen.dart';

class HodPhotoAuditScreen extends StatefulWidget {
  const HodPhotoAuditScreen({super.key});

  @override
  State<HodPhotoAuditScreen> createState() => _HodPhotoAuditScreenState();
}

class _HodPhotoAuditScreenState extends State<HodPhotoAuditScreen> {
  int _selectedYearIndex = 0; // All
  final List<String> _years = ['All Years', '1st Year', '2nd Year', '3rd Year', '4th Year'];

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppStateManager.instance,
      builder: (context, _) {
        final state = AppStateManager.instance;
        final filterYear = _years[_selectedYearIndex];
        final photos = state.classSessionPhotos.where((p) {
          if (filterYear != 'All Years' && p.year != filterYear) return false;
          return true;
        }).toList();

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
              'Smart Board Class Photo Feed',
              style: AppTheme.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.ink900),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              const AuthorityBanner(
                isHod: true,
                text: 'HOD Audit: Verify camera face recognition across all department sections',
              ),

              // Year Filter Chips
              SizedBox(
                height: 38,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _years.length,
                  itemBuilder: (context, index) {
                    final isSel = _selectedYearIndex == index;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedYearIndex = index),
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSel ? AppTheme.violet600 : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: isSel ? AppTheme.violet600 : AppTheme.line),
                        ),
                        child: Center(
                          child: Text(
                            _years[index],
                            style: AppTheme.inter(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                              color: isSel ? Colors.white : AppTheme.ink600,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),

              // Photos Feed
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: photos.length,
                  itemBuilder: (context, index) {
                    final photo = photos[index];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: AppTheme.line),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            contentPadding: const EdgeInsets.all(14),
                            leading: Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: AppTheme.violet100,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Center(
                                child: Icon(Icons.camera_enhance_rounded, color: AppTheme.violet600, size: 22),
                              ),
                            ),
                            title: Text(
                              '${photo.year} · Sec ${photo.section}',
                              style: AppTheme.inter(fontSize: 14, fontWeight: FontWeight.w700, color: AppTheme.ink900),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 2),
                                Text(photo.subject, style: AppTheme.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.ink900)),
                                Text('Adviser: ${photo.advisorName} · ${photo.capturedAt}', style: AppTheme.inter(fontSize: 11, color: AppTheme.ink600)),
                              ],
                            ),
                            trailing: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: photo.hodApproved ? AppTheme.green100 : AppTheme.amber100,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                photo.hodApproved ? 'Approved ✓' : 'Needs Review',
                                style: AppTheme.inter(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: photo.hodApproved ? AppTheme.green600 : AppTheme.amber500,
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PhotoAttendanceReviewScreen(session: photo),
                                ),
                              );
                            },
                          ),

                          // HOD Fast Action Buttons
                          Padding(
                            padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => PhotoAttendanceReviewScreen(session: photo),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      decoration: BoxDecoration(
                                        color: AppTheme.lavenderBg,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: AppTheme.line),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Inspect Photo Evidence',
                                          style: AppTheme.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.ink900),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                if (state.isHodAdmin)
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        state.approveClassPhotoReportByHod(photo.id);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('Approved attendance for ${photo.year} Sec ${photo.section} ✓')),
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        decoration: BoxDecoration(
                                          color: AppTheme.green100,
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(color: const Color(0xFFA7F3D0)),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '✓ Sign Off',
                                            style: AppTheme.inter(fontSize: 12, fontWeight: FontWeight.w700, color: AppTheme.green600),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                else
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      decoration: BoxDecoration(
                                        color: AppTheme.lavenderBg,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: AppTheme.line),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Read-Only Viewer',
                                          style: AppTheme.inter(fontSize: 11.5, fontWeight: FontWeight.w600, color: AppTheme.ink600),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
