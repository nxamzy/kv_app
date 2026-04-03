import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_kv/core/app_colors.dart';
import 'package:my_kv/l10n/app_localizations.dart';
import 'package:my_kv/logic/cubit/expence_cubit.dart';
import 'package:my_kv/logic/cubit/expence_state.dart';
import 'package:my_kv/logic/cubit/settings_cubit.dart';
import 'package:my_kv/logic/cubit/settings_state.dart';
import 'package:my_kv/presentation/add/addProduct.dart';
import 'package:my_kv/presentation/pages/widgets/debt_card.dart';
import 'package:my_kv/presentation/pages/widgets/group_selector.dart';
import 'package:my_kv/presentation/pages/widgets/recent_activity_header.dart';
import 'package:my_kv/presentation/pages/widgets/transaction_list.dart';
import 'package:my_kv/routes/platform_routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedGroupId = 'all';

  @override
  void initState() {
    super.initState();
    context.read<ExpenseCubit>().getExpenses();
  }

  Future<void> _handleRefresh() async {
    if (selectedGroupId == 'all') {
      await context.read<ExpenseCubit>().getExpenses();
    } else {
      context.read<ExpenseCubit>().getExpensesByGroup(selectedGroupId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: AppColors.textPrimary), // 212529
        actions: [
          TextButton(
            onPressed: () => context.push(PlatformRoutes.addGroupPage.route),
            child: Text(
              l10n.createGroup,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<ExpenseCubit, ExpenseState>(
        builder: (context, state) {
          final settingsState = context.watch<SettingsCubit>().state;
          final user = FirebaseAuth.instance.currentUser;
          String currentUserName = l10n.friendDefault;

          if (settingsState is SettingsLoaded) {
            final dbName = settingsState.user.fullName.trim();
            final authName = user?.displayName;
            final emailPrefix = user?.email?.split('@')[0];

            if (dbName.isNotEmpty) {
              currentUserName = dbName;
            } else if (authName != null && authName.isNotEmpty) {
              currentUserName = authName;
            } else if (emailPrefix != null) {
              currentUserName = emailPrefix;
            }
          }

          if (state is ExpenseError) {
            return Center(
              child: Text(
                "${l10n.errorText}: ${state.message}",
                style: const TextStyle(color: AppColors.textPrimary),
              ),
            );
          }

          if (state is ExpenseLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.gray800),
            );
          }

          if (state is ExpenseLoaded) {
            final uniqueDocs = state.expenses.toSet().toList();

            return RefreshIndicator(
              color: AppColors.gray100,
              backgroundColor: AppColors.gray900,
              onRefresh: _handleRefresh,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DebtSummaryCard(
                        userName: currentUserName,
                        expenses: state.expenses,
                        currentUserId: user?.uid,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: Text(
                          l10n.myGroups,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      GroupSelector(
                        userId: user?.uid,
                        selectedGroupId: selectedGroupId,
                        onAllSelected: () {
                          setState(() => selectedGroupId = 'all');
                          context.read<ExpenseCubit>().getExpenses();
                        },
                        onGroupSelected: (id) {
                          setState(() => selectedGroupId = id);
                          context.read<ExpenseCubit>().getExpensesByGroup(id);
                        },
                      ),
                      const Divider(height: 30, color: AppColors.border),
                      RecentActivityHeader(selectedGroupId: selectedGroupId),
                      TransactionList(docs: uniqueDocs, userId: user?.uid),
                    ],
                  ),
                ],
              ),
            );
          }

          return Center(
            child: Text(
              l10n.loadingError,
              style: const TextStyle(color: AppColors.textPrimary),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddExpenseSheet(context, selectedGroupId),
        backgroundColor: AppColors.gray900,
        elevation: 4,
        child: const Icon(Icons.add, color: AppColors.gray100),
      ),
    );
  }
}
