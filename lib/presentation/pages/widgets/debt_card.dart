import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_kv/l10n/app_localizations.dart';
import 'package:my_kv/logic/cubit/settings_cubit.dart';
import 'package:my_kv/logic/cubit/settings_state.dart';

class DebtSummaryCard extends StatelessWidget {
  final String userName;
  final List<QueryDocumentSnapshot> expenses;
  final String? currentUserId;

  const DebtSummaryCard({
    super.key,
    required this.userName,
    required this.expenses,
    this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    double iOwe = 0.0;
    double owedToMe = 0.0;

    for (var doc in expenses) {
      final data = doc.data() as Map<String, dynamic>;
      double amount = (data['amount'] ?? 0).toDouble();
      if (data['userId'] == currentUserId) {
        owedToMe += amount / 2;
      } else {
        iOwe += amount / 2;
      }
    }

    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${l10n.hello}, $userName!",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildDebtColumn(l10n.iOweLabel, iOwe, l10n),
              _buildDivider(),
              _buildDebtColumn(l10n.owedToMeLabel, owedToMe, l10n),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDebtColumn(String label, double amount, AppLocalizations l10n) {
    String formatCurrency(dynamic amount) {
      double value = 0;
      if (amount is String) {
        value = double.tryParse(amount) ?? 0;
      } else if (amount is num) {
        value = amount.toDouble();
      }
      final formatter = NumberFormat("#,###", "en_US");
      return formatter.format(value);
    }

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white54, fontSize: 12),
          ),
          BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              String symbol = "UZS";
              if (state is SettingsLoaded) {
                symbol = state.user.currency == "USD" ? "\$" : l10n.currencySom;
              }
              return Text(
                "${formatCurrency(amount)} $symbol",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 40,
      color: Colors.white24,
      margin: const EdgeInsets.symmetric(horizontal: 15),
    );
  }
}
