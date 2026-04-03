import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_kv/l10n/app_localizations.dart';
import 'package:my_kv/logic/cubit/expence_cubit.dart';
import 'package:my_kv/logic/cubit/settings_cubit.dart';
import 'package:my_kv/logic/cubit/settings_state.dart';

class ExpenseDetailsPage extends StatelessWidget {
  final String docId;
  final Map<String, dynamic> data;

  const ExpenseDetailsPage({
    super.key,
    required this.docId,
    required this.data,
  });

  String _getFormattedDate(Map<String, dynamic> data, AppLocalizations l10n) {
    dynamic dateValue = data['date'] ?? data['createdAt'] ?? data['timestamp'];
    if (dateValue == null) return l10n.dateNotFound;
    if (dateValue is Timestamp) {
      DateTime dt = dateValue.toDate();
      return DateFormat('dd.MM.yyyy, HH:mm').format(dt);
    }
    return dateValue.toString();
  }

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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final currentUser = FirebaseAuth.instance.currentUser;
    final bool isOwner = data['userId'] == currentUser?.uid;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          l10n.expenseDetails,
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Center(
              child: SizedBox(
                height: 80,
                width: 80,
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Icon(
                    data['iconCode'] != null
                        ? IconData(
                            data['iconCode'],
                            fontFamily: 'MaterialIcons',
                          )
                        : Icons.receipt_long,
                    size: 45,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            BlocBuilder<SettingsCubit, SettingsState>(
              builder: (context, state) {
                String symbol = l10n.currencySom;
                if (state is SettingsLoaded) {
                  symbol = state.user.currency == "USD"
                      ? "\$"
                      : l10n.currencySom;
                }
                return Text(
                  "${formatCurrency(data['amount'])} $symbol",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
            const SizedBox(height: 5),
            Text(
              data['title'] ?? l10n.unknownProduct,
              style: const TextStyle(fontSize: 20, color: Colors.grey),
            ),
            const SizedBox(height: 40),
            BlocBuilder<SettingsCubit, SettingsState>(
              builder: (context, state) {
                String displayName = data['person'] ?? l10n.unknownPerson;
                if (isOwner && state is SettingsLoaded) {
                  displayName = state.user.fullName;
                }
                return _buildDetailRow(l10n.payerLabel, displayName);
              },
            ),
            _buildDetailRow(l10n.dateLabel, _getFormattedDate(data, l10n)),
            const Spacer(),
            if (isOwner)
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[50],
                    foregroundColor: Colors.red,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () => _showDeleteExpenseDialog(context, l10n),
                  icon: const Icon(Icons.delete_outline),
                  label: Text(
                    l10n.deleteThisExpense,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showDeleteExpenseDialog(
    BuildContext parentContext,
    AppLocalizations l10n,
  ) {
    showDialog(
      context: parentContext,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(
          l10n.deleteConfirmTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(l10n.deleteConfirmMsg),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              l10n.cancelBtn,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              try {
                await parentContext.read<ExpenseCubit>().deleteExpense(docId);
                if (parentContext.mounted) {
                  ScaffoldMessenger.of(parentContext).clearSnackBars();
                  ScaffoldMessenger.of(parentContext).showSnackBar(
                    SnackBar(content: Text(l10n.expenseDeletedMsg)),
                  );
                  Navigator.of(parentContext).pop();
                }
              } catch (e) {
                debugPrint("Xato yuz berdi: $e");
              }
            },
            child: Text(
              l10n.deleteBtn,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 16)),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
