import 'package:flutter/material.dart';
import 'package:my_kv/l10n/app_localizations.dart';

class FriendCard extends StatelessWidget {
  final String name;
  final double balance;

  const FriendCard({super.key, required this.name, required this.balance});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    bool isOwed = balance > 0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFF5F5F5)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.black,
            child: Text(
              name.isNotEmpty ? name[0].toUpperCase() : "?",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  isOwed ? l10n.youAreOwed : l10n.youOwe,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          Text(
            "${balance.abs().toStringAsFixed(0)} UZS",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isOwed ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
