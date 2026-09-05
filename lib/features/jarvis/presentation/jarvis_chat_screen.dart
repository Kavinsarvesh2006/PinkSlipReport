import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../shared/state/app_state_manager.dart';
import '../../advisor/presentation/screens/class_register_screen.dart';

class JarvisChatScreen extends StatefulWidget {
  const JarvisChatScreen({super.key});

  @override
  State<JarvisChatScreen> createState() => _JarvisChatScreenState();
}

class _JarvisChatScreenState extends State<JarvisChatScreen> {
  final TextEditingController _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppStateManager.instance,
      builder: (context, _) {
        final state = AppStateManager.instance;
        final messages = state.chatMessages;

        return Scaffold(
          backgroundColor: AppTheme.lavenderBg,
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment(-0.8, -0.8),
                      radius: 1.2,
                      colors: [Color(0xFF2D2A55), Color(0xFF12102A)],
                    ),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFF67E8F9), width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF67E8F9).withValues(alpha: 0.6),
                              blurRadius: 12,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Container(
                            width: 14,
                            height: 14,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF67E8F9),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFF67E8F9),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Jarvis',
                            style: AppTheme.poppins(fontSize: 17, fontWeight: FontWeight.w700, color: Colors.white),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF34D399),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'Online · PinkSlipReport assistant',
                                style: AppTheme.inter(fontSize: 11, color: const Color(0xFFA5B4FC)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final msg = messages[index];

                      if (msg.isUser) {
                        return Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 14),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.78),
                            decoration: const BoxDecoration(
                              color: AppTheme.violet600,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(4),
                              ),
                            ),
                            child: Text(
                              msg.text,
                              style: AppTheme.inter(fontSize: 13, color: Colors.white),
                            ),
                          ),
                        );
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Text(
                                'JARVIS · ${msg.time}',
                                style: AppTheme.inter(fontSize: 10, fontWeight: FontWeight.w700, color: AppTheme.violet600),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              padding: const EdgeInsets.all(14),
                              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.84),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4),
                                  topRight: Radius.circular(16),
                                  bottomLeft: Radius.circular(16),
                                  bottomRight: Radius.circular(16),
                                ),
                                border: Border.all(color: AppTheme.line),
                              ),
                              child: Text(
                                msg.text,
                                style: AppTheme.inter(fontSize: 13, color: AppTheme.ink900, height: 1.5),
                              ),
                            ),
                            if (msg.miniCardText != null)
                              Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppTheme.lavenderBg,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: AppTheme.line),
                                ),
                                child: Text(
                                  msg.miniCardText!,
                                  style: AppTheme.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.violet700),
                                ),
                              ),
                            if (msg.actionChips != null && msg.actionChips!.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: msg.actionChips!.map((chip) {
                                    return GestureDetector(
                                      onTap: () {
                                        if (chip.contains('register')) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => const ClassRegisterScreen(initialFilter: 'Uninformed'),
                                            ),
                                          );
                                        } else {
                                          state.addChatMessage(chip);
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                                        decoration: BoxDecoration(
                                          color: AppTheme.violet50,
                                          borderRadius: BorderRadius.circular(16),
                                          border: Border.all(color: AppTheme.violet100),
                                        ),
                                        child: Text(
                                          chip,
                                          style: AppTheme.inter(fontSize: 11.5, fontWeight: FontWeight.w600, color: AppTheme.violet700),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                          ],
                        );
                      }
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: AppTheme.lavenderBg,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: AppTheme.line),
                          ),
                          child: TextField(
                            controller: _inputController,
                            onSubmitted: (val) {
                              if (val.trim().isNotEmpty) {
                                state.addChatMessage(val.trim());
                                _inputController.clear();
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'Ask Jarvis anything...',
                              hintStyle: AppTheme.inter(fontSize: 13, color: AppTheme.ink400),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          if (_inputController.text.trim().isNotEmpty) {
                            state.addChatMessage(_inputController.text.trim());
                            _inputController.clear();
                          }
                        },
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: const BoxDecoration(
                            gradient: AppTheme.primaryGradient,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(Icons.send_rounded, size: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
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
