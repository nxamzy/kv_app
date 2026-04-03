import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_kv/data/model/user_model.dart';
import 'package:my_kv/l10n/app_localizations.dart';
import 'package:my_kv/logic/cubit/settings_cubit.dart';
import 'package:my_kv/logic/cubit/settings_state.dart';

class AccountDropdownFields extends StatefulWidget {
  final UserModel user;

  const AccountDropdownFields({super.key, required this.user});

  @override
  State<AccountDropdownFields> createState() => _AccountDropdownFieldsState();
}

class _AccountDropdownFieldsState extends State<AccountDropdownFields> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(l10n.defaultCurrency),
        const SizedBox(height: 10),
        _buildCurrencyDropdown(l10n),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildCurrencyDropdown(AppLocalizations l10n) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        String currentSelection = "USD";
        if (state is SettingsLoaded) {
          currentSelection = state.user.currency;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.selectCurrency,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            Container(
              height: 55,
              margin: const EdgeInsets.only(top: 8, bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400, width: 1),
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: currentSelection,
                  isExpanded: true,
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.blueAccent,
                  ),
                  items: [
                    DropdownMenuItem(
                      value: "UZS",
                      child: Row(
                        children: [
                          const Text("🇺🇿 ", style: TextStyle(fontSize: 20)),
                          Text(
                            "${l10n.uzbekistan} (UZS)",
                            style: const TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: "USD",
                      child: Row(
                        children: [
                          const Text("🇺🇸 ", style: TextStyle(fontSize: 20)),
                          Text(
                            "${l10n.usa} (USD)",
                            style: const TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ],
                  onChanged: (String? newValue) async {
                    if (newValue != null) {
                      await context.read<SettingsCubit>().updateCurrency(
                        newValue,
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
