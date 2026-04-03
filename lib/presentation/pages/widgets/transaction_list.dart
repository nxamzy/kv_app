import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_kv/l10n/app_localizations.dart';
import 'package:my_kv/logic/cubit/expence_cubit.dart';
import 'package:my_kv/logic/cubit/settings_cubit.dart';
import 'package:my_kv/logic/cubit/settings_state.dart';
import 'package:my_kv/presentation/pages/detail_page.dart';
import 'package:my_kv/presentation/pages/choose_icon_page.dart';
import 'empty_state.dart';

class TransactionList extends StatelessWidget {
  final List docs;
  final String? userId;

  const TransactionList({super.key, required this.docs, this.userId});

  String _formatDate(dynamic timestamp) {
    if (timestamp == null || timestamp is! Timestamp) return "";
    DateTime date = timestamp.toDate();
    return "${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (docs.isEmpty) return const EmptyExpenseState();

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: docs.length,
      itemBuilder: (context, index) {
        final doc = docs[index];
        final data = doc.data() as Map<String, dynamic>;
        bool isMe = data['userId'] == userId;

        return Dismissible(
          key: Key(doc.id),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            color: Colors.redAccent,
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (_) =>
              context.read<ExpenseCubit>().deleteExpense(doc.id),
          child: _buildTransactionItem(context, doc.id, data, isMe, l10n),
        );
      },
    );
  }

  Widget _buildTransactionItem(
    BuildContext context,
    String docId,
    Map<String, dynamic> data,
    bool isMe,
    AppLocalizations l10n,
  ) {
    String formatCurrency(dynamic amountData) {
      double value = 0;
      if (amountData is String) {
        value = double.tryParse(amountData) ?? 0;
      } else if (amountData is num) {
        value = amountData.toDouble();
      }
      final formatter = NumberFormat("#,###", "en_US");
      return formatter.format(value);
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF5F5F5)),
      ),
      child: ListTile(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExpenseDetailsPage(docId: docId, data: data),
          ),
        ),
        leading: GestureDetector(
          onTap: () => showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => CategoryPickerSheet(
              docId: docId,
              currentIconCode: data['iconCode'],
            ),
          ),
          child: CircleAvatar(
            backgroundColor: Colors.black,
            child: Icon(
              data['iconCode'] != null
                  ? IconData(data['iconCode'], fontFamily: 'MaterialIcons')
                  : Icons.receipt_long,
              color: Colors.white,
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                data['title'] ?? l10n.expense,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (data['createdAt'] != null)
              Text(
                _formatDate(data['createdAt']),
                style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              isMe
                  ? l10n.youPaid
                  : "${data['userName'] ?? l10n.friend} ${l10n.friendPaid}",
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.05),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                data['groupName'] ?? l10n.groupExpense,
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        trailing: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            String symbol = "UZS";
            if (state is SettingsLoaded) {
              symbol = state.user.currency == "USD" ? "\$" : l10n.currencySom;
            }
            return Text(
              "${formatCurrency(data['amount'])} $symbol",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      ),
    );
  }
}
