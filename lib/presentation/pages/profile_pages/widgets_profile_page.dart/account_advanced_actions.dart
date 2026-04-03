import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_kv/l10n/app_localizations.dart';

class AccountAdvancedActions extends StatelessWidget {
  const AccountAdvancedActions({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.advancedFeature,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          l10n.yourAccount,
          style: const TextStyle(color: Colors.black87, fontSize: 15),
        ),
        const SizedBox(height: 8),
        _buildAdvancedButton(
          text: l10n.closeAccount,
          icon: Icons.delete_forever,
          isDangerous: true,
          onPressed: () {
            _showLogoutDialog(context, l10n);
          },
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          l10n.logoutConfirmTitle,
          style: const TextStyle(color: Colors.black),
        ),
        content: Text(l10n.logoutConfirmDesc),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              l10n.cancel,
              style: const TextStyle(color: Colors.black),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await FirebaseAuth.instance.signOut();
              if (context.mounted) {
                context.go('/');
              }
            },
            child: Text(l10n.logout, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Widget _buildAdvancedButton({
    required String text,
    required IconData icon,
    required VoidCallback onPressed,
    bool isDangerous = false,
  }) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          side: BorderSide(
            color: isDangerous ? Colors.red.shade200 : Colors.grey.shade300,
          ),
          backgroundColor: isDangerous
              ? Colors.red.shade50
              : Colors.grey.shade50,
          alignment: Alignment.centerLeft,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 20,
          color: isDangerous ? Colors.red : Colors.black87,
        ),
        label: Text(
          text,
          style: TextStyle(
            color: isDangerous ? Colors.red : Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
