import 'package:flutter/material.dart';
import 'package:my_kv/l10n/app_localizations.dart';

class RecentActivityHeader extends StatelessWidget {
  final String selectedGroupId;

  const RecentActivityHeader({super.key, required this.selectedGroupId});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            l10n.recentExpenses,
            style: const TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          if (selectedGroupId != 'all')
            Text(
              l10n.selectedGroupLabel,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
        ],
      ),
    );
  }
}
