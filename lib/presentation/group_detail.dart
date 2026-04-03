import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_kv/core/app_colors.dart';
import 'package:my_kv/l10n/app_localizations.dart';
import 'package:my_kv/logic/cubit/group_cubit.dart';

class GroupDetailsPage extends StatelessWidget {
  final String groupId;

  const GroupDetailsPage({super.key, required this.groupId});

  String _formatDate(dynamic timestamp, AppLocalizations l10n) {
    if (timestamp == null) return l10n.loadingLabel;
    DateTime date;
    if (timestamp is Timestamp) {
      date = timestamp.toDate();
    } else if (timestamp is DateTime) {
      date = timestamp;
    } else {
      return l10n.unknownProduct;
    }
    return "${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocListener<GroupCubit, GroupState>(
      listener: (context, state) {
        if (state is GroupSuccess) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(l10n.groupDeletedMsg)));
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.surface,
          elevation: 0,
          iconTheme: const IconThemeData(color: AppColors.textPrimary),
          title: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('groups')
                .doc(groupId)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData || !snapshot.data!.exists)
                return Text(l10n.groupLabel);
              var groupData = snapshot.data!.data() as Map<String, dynamic>;
              return Text(
                groupData['name'] ?? l10n.groupLabel,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
          actions: [
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('groups')
                  .doc(groupId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || !snapshot.data!.exists)
                  return const SizedBox();
                var data = snapshot.data!.data() as Map<String, dynamic>;
                final user = FirebaseAuth.instance.currentUser;

                if (user != null && data['createdBy'] == user.uid) {
                  return IconButton(
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.redAccent,
                    ),
                    onPressed: () => _showDeleteConfirmation(context, l10n),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
        body: Column(
          children: [
            _buildGroupHeader(groupId, l10n),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(thickness: 1, color: AppColors.border), // DEE2E6
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  l10n.expenseHistory,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
            Expanded(child: _buildExpensesList(groupId, l10n)),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text(
          l10n.deleteGroupTitle,
          style: const TextStyle(color: AppColors.textPrimary),
        ),
        content: Text(
          l10n.deleteGroupMsg,
          style: const TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text(
              "Bekor qilish",
              style: TextStyle(color: AppColors.gray600),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<GroupCubit>().deleteGroup(groupId);
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

  Widget _buildGroupHeader(String groupId, AppLocalizations l10n) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('groups')
          .doc(groupId)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || !snapshot.data!.exists)
          return const SizedBox();
        var data = snapshot.data!.data() as Map<String, dynamic>;

        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: AppColors.gray200,
                    child: Icon(
                      IconData(
                        data['iconCode'] ?? 58160,
                        fontFamily: 'MaterialIcons',
                      ),
                      size: 35,
                      color: AppColors.gray800,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['name'] ?? l10n.noName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        "${data['type'] ?? l10n.all} ${l10n.groupTypeSuffix}",
                        style: const TextStyle(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildDetailRow(
                Icons.calendar_today_outlined,
                l10n.openedDate,
                _formatDate(data['createdAt'], l10n),
              ),
              _buildDetailRow(
                Icons.group_outlined,
                l10n.membersCount,
                "${data['memberCount'] ?? 1} ${l10n.countUnit}",
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.textSecondary),
          const SizedBox(width: 10),
          Text(label, style: const TextStyle(color: AppColors.textSecondary)),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpensesList(String groupId, AppLocalizations l10n) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('expenses')
          .where('groupId', isEqualTo: groupId)
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              l10n.noExpenses,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var expense =
                snapshot.data!.docs[index].data() as Map<String, dynamic>;
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border.withOpacity(0.5)),
              ),
              child: ListTile(
                title: Text(
                  expense['title'] ?? l10n.expense,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                subtitle: Text(
                  _formatDate(expense['createdAt'], l10n),
                  style: const TextStyle(color: AppColors.textSecondary),
                ),
                trailing: Text(
                  "${expense['amount']} ${l10n.currencySom.toUpperCase()}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
