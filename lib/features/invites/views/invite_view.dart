import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/invite_view_model.dart';

class InviteView extends StatefulWidget {
  const InviteView({super.key});

  @override
  State<InviteView> createState() => _InviteViewState();
}

class _InviteViewState extends State<InviteView> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invite friends'),
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
                  const Text(
                    'Share your referral code',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1A2A33),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Invite friends and earn 10% discount on your next booking.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF60707C),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Consumer<InviteViewModel>(
                    builder: (context, vm, _) {
                      return Column(
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              // Mock user ID for demo
                              final result = await vm.createInvitation(
                                userId: 'user123',
                                userName: 'You',
                                userEmail: 'user@example.com',
                                recipientEmail: _emailController.text.isNotEmpty
                                    ? _emailController.text
                                    : null,
                              );

                              if (result != null && mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Invitation created! Copy the code below.')),
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
                            child: const SizedBox(
                              width: double.infinity,
                              child: Center(
                                child: Text('Generate Referral Code'),
                              ),
                            ),
                          ),
                          if (vm.lastGeneratedCode != null) ...[
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: const Color(0xFFE8B45F), width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      vm.lastGeneratedCode!,
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
                                      // Copy to clipboard functionality
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Copied: ${vm.lastGeneratedCode}'),
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
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            const Text(
              'Or invite via email',
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
                hintText: 'friend@example.com',
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
                    const SnackBar(content: Text('Invitation sent!')),
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
                child: const Text(
                  'Send Invitation',
                  style: TextStyle(
                    color: Color(0xFF1B2D2A),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 28),
            const Text(
              'Sent Invitations',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1A2A33),
              ),
            ),
            const SizedBox(height: 12),
            Consumer<InviteViewModel>(
              builder: (context, vm, _) {
                if (vm.sentInvitations.isEmpty) {
                  return Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'No invitations sent yet',
                        style: TextStyle(color: Color(0xFF60707C)),
                      ),
                    ),
                  );
                }

                return Column(
                  children: vm.sentInvitations
                      .map((inv) => Container(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    inv.referralCode,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xFF1A2A33),
                                    ),
                                  ),
                                  Text(
                                    inv.status,
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
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE8B45F).withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text(
                                '10% Off',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFE8B45F),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
