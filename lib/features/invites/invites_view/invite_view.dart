import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../services/invite_service.dart';
import '../invites_view_model/invite_view_model.dart';

class InviteView extends StatefulWidget {
  const InviteView({super.key});

  @override
  State<InviteView> createState() => _InviteViewState();
}

class _InviteViewState extends State<InviteView> {
  final _emailController = TextEditingController();
  late final InviteViewModel _vm;

  @override
  void initState() {
    super.initState();
    _vm = InviteViewModel(inviteService: InviteService());
  }

  @override
  void dispose() {
    _vm.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return AnimatedBuilder(
      animation: _vm,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(strings.inviteFriends),
            backgroundColor: const Color(0xFF1B3D35),
            foregroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F1EB),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        strings.shareReferral,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1A2A33),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        strings.referralBody,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF60707C),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              if (!mounted) return;
                              final messenger = ScaffoldMessenger.of(context);
                              final result = await _vm.createInvitation(
                                userId: 'user123',
                                userName: 'You',
                                userEmail: 'user@example.com',
                                recipientEmail: _emailController.text.isNotEmpty
                                    ? _emailController.text
                                    : null,
                              );

                              if (result != null && mounted) {
                                messenger.showSnackBar(
                                  SnackBar(
                                    content: Text(strings.invitationCreated),
                                  ),
                                );
                                _emailController.clear();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1B3D35),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              child: Center(
                                child: Text(strings.generateReferral),
                              ),
                            ),
                          ),
                          if (_vm.lastGeneratedCode != null) ...[
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: const Color(0xFFE8B45F),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      _vm.lastGeneratedCode!,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFFE8B45F),
                                        letterSpacing: 2,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            strings.copiedCode(
                                              _vm.lastGeneratedCode!,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.copy),
                                    color: const Color(0xFFE8B45F),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                Text(
                  strings.inviteByEmail,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1A2A33),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: strings.emailHint,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.email),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(strings.invitationSent)),
                      );
                      _emailController.clear();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE8B45F),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      strings.sendInvitation,
                      style: TextStyle(
                        color: Color(0xFF1B2D2A),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                Text(
                  strings.sentInvitations,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1A2A33),
                  ),
                ),
                const SizedBox(height: 12),
                if (_vm.sentInvitations.isEmpty)
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        strings.noInvitations,
                        style: TextStyle(color: Color(0xFF60707C)),
                      ),
                    ),
                  )
                else
                  Column(
                    children: _vm.sentInvitations
                        .map(
                          (inv) => Container(
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        inv.referralCode,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w800,
                                          color: Color(0xFF1A2A33),
                                        ),
                                      ),
                                      Text(
                                        inv.status == 'accepted'
                                            ? strings.accepted
                                            : strings.pending,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: inv.status == 'accepted'
                                              ? Colors.green
                                              : Colors.orange,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFFE8B45F,
                                    ).withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    strings.discount,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFFE8B45F),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
