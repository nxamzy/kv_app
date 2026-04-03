import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_kv/l10n/app_localizations.dart';
import 'package:my_kv/logic/cubit/settings_cubit.dart';
import 'package:my_kv/logic/cubit/settings_state.dart';
import 'package:my_kv/presentation/pages/profile_pages/widgets_profile_page.dart/account_advanced_actions.dart';
import 'package:my_kv/presentation/pages/profile_pages/widgets_profile_page.dart/account_dropdown_fields.dart';
import 'package:my_kv/presentation/pages/profile_pages/widgets_profile_page.dart/account_form_fields.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({Key? key}) : super(key: key);

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _currentPassController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();

  bool _isEditingName = false;
  bool _isEditingEmail = false;
  bool _isEditingPhone = false;
  bool _isEditingPassword = false;

  @override
  void initState() {
    super.initState();
    context.read<SettingsCubit>().loadSettings();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _currentPassController.dispose();
    _newPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l10n.accountSettings,
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoaded) {
            final user = state.user;

            if (!_isEditingName && _nameController.text.isEmpty)
              _nameController.text = user.fullName;
            if (!_isEditingEmail && _emailController.text.isEmpty)
              _emailController.text = user.email;
            if (!_isEditingPhone && _phoneController.text.isEmpty)
              _phoneController.text = user.phoneNumber;

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  AccountFormFields(
                    user: user,
                    isEditingName: _isEditingName,
                    isEditingEmail: _isEditingEmail,
                    isEditingPhone: _isEditingPhone,
                    isEditingPassword: _isEditingPassword,
                    nameController: _nameController,
                    emailController: _emailController,
                    phoneController: _phoneController,
                    currentPasswordController: _currentPassController,
                    newPasswordController: _newPassController,
                    onEditName: () =>
                        setState(() => _isEditingName = !_isEditingName),
                    onEditEmail: () =>
                        setState(() => _isEditingEmail = !_isEditingEmail),
                    onEditPhone: () =>
                        setState(() => _isEditingPhone = !_isEditingPhone),
                    onEditPassword: () => setState(
                      () => _isEditingPassword = !_isEditingPassword,
                    ),
                  ),
                  const SizedBox(height: 20),
                  AccountDropdownFields(user: user),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () async {
                        try {
                          await context
                              .read<SettingsCubit>()
                              .updateUserSettings(
                                fullName: _nameController.text,
                                phoneNumber: _phoneController.text,
                                email: _emailController.text,
                              );

                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(l10n.settingsSaved),
                                backgroundColor: Colors.green,
                              ),
                            );
                            Navigator.pop(context);
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("${l10n.errorOccurred}: $e"),
                              ),
                            );
                          }
                        }
                      },
                      child: Text(
                        l10n.saveChanges,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const AccountAdvancedActions(),
                  const SizedBox(height: 20),
                ],
              ),
            );
          }
          return Center(child: Text(l10n.noDataFound));
        },
      ),
    );
  }
}
