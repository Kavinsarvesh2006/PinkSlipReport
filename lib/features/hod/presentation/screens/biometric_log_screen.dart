import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../shared/state/app_state_manager.dart';
import '../../../shared/widgets/authority_banner.dart';
import '../../../authentication/domain/models/user_role.dart';

class BiometricLogScreen extends StatefulWidget {
  const BiometricLogScreen({super.key});

  @override
  State<BiometricLogScreen> createState() => _BiometricLogScreenState();
}

class _BiometricLogScreenState extends State<BiometricLogScreen> {
  String _selectedFilter = 'Today';

  final List<String> _filters = [
    'Today',
    'This week',
    'Manual overrides',
    'Device errors',
  ];

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppStateManager.instance,
      builder: (context, _) {
        final state = AppStateManager.instance;
        final isHod = state.currentRole == UserRole.hod;
        final punches = state.biometricPunches;

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
              'Biometric log · Sec B',
              style: AppTheme.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.ink900),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh_rounded, color: AppTheme.ink600),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Synced with Biometric Gate Device')),
                  );
                },
              ),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AuthorityBanner(
                isHod: isHod,
                text: state.isHodAdmin
                    ? 'Primary HOD Authority: Edit & Delete authorized across all records'
                    : isHod
                        ? 'Secondary HOD Authority: Read-Only inspection across all records'
                        : 'Adviser view: view and manual edit only for assigned section, delete hidden',
              ),
              SizedBox(
                height: 38,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _filters.length,
                  itemBuilder: (context, index) {
                    final f = _filters[index];
                    final isSel = _selectedFilter == f;

                    return GestureDetector(
                      onTap: () => setState(() => _selectedFilter = f),
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSel ? AppTheme.violet100 : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: isSel ? AppTheme.violet100 : AppTheme.line),
                        ),
                        child: Center(
                          child: Text(
                            f,
                            style: AppTheme.inter(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                              color: isSel ? AppTheme.violet700 : AppTheme.ink600,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: punches.length,
                  itemBuilder: (context, index) {
                    final p = punches[index];

                    return Container(
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
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: p.dotColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  p.studentName,
                                  style: AppTheme.inter(fontSize: 13, fontWeight: FontWeight.w700, color: AppTheme.ink900),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${p.inTime}${p.outTime != null ? " · ${p.outTime}" : ""} · ${p.description}',
                                  style: AppTheme.inter(fontSize: 11, color: AppTheme.ink600),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              if (state.canCurrentUserEdit)
                                GestureDetector(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Edit biometric punch for ${p.studentName}')),
                                    );
                                  },
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: AppTheme.line),
                                    ),
                                    child: const Center(
                                      child: Icon(Icons.edit_outlined, size: 15, color: AppTheme.ink600),
                                    ),
                                  ),
                                ),
                              if (state.canCurrentUserDelete) ...[
                                const SizedBox(width: 6),
                                GestureDetector(
                                  onTap: () {
                                    state.deleteBiometricRecord(p.id);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Biometric punch deleted by HOD')),
                                    );
                                  },
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: AppTheme.pink100,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: const Color(0xFFFBCFDA)),
                                    ),
                                    child: const Center(
                                      child: Icon(Icons.delete_outline_rounded, size: 15, color: AppTheme.pink500),
                                    ),
                                  ),
                                ),
                              ],
                              if (!state.canCurrentUserEdit && !state.canCurrentUserDelete)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AppTheme.lavenderBg,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    'View-Only',
                                    style: AppTheme.inter(fontSize: 10.5, fontWeight: FontWeight.w600, color: AppTheme.ink600),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Center(
                  child: Text(
                    state.isHodAdmin
                        ? '- Primary HOD view: edit & delete authorized -'
                        : isHod
                            ? '- Secondary HOD view: read-only inspection mode -'
                            : '- Adviser view: edit only, delete hidden -',
                    style: AppTheme.inter(fontSize: 11, color: AppTheme.ink400),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
