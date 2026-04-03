import 'package:flutter/material.dart';
import 'package:my_kv/l10n/app_localizations.dart';

class EmptyExpenseState extends StatelessWidget {
  const EmptyExpenseState({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.receipt_long, size: 50, color: Colors.grey.shade300),
            const SizedBox(height: 10),
            Text(
              l10n.noExpensesYet,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
