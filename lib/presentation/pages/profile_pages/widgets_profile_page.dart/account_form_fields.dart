import 'package:flutter/material.dart';
import 'package:my_kv/data/model/user_model.dart';
import 'package:my_kv/l10n/app_localizations.dart';

class AccountFormFields extends StatelessWidget {
  final UserModel user;
  final bool isEditingName, isEditingEmail, isEditingPhone, isEditingPassword;
  final VoidCallback onEditName, onEditEmail, onEditPhone, onEditPassword;
  final TextEditingController nameController,
      emailController,
      phoneController,
      currentPasswordController,
      newPasswordController;

  const AccountFormFields({
    super.key,
    required this.user,
    required this.isEditingName,
    required this.isEditingEmail,
    required this.isEditingPhone,
    required this.isEditingPassword,
    required this.onEditName,
    required this.onEditEmail,
    required this.onEditPhone,
    required this.onEditPassword,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.currentPasswordController,
    required this.newPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(l10n.fullNameLabel),
        isEditingName
            ? _buildTextField(nameController, "Jamshidbek")
            : _buildDisplayRow(
                user.fullName.isEmpty ? "Jamshidbek" : user.fullName,
                onEditName,
                l10n,
              ),
        const SizedBox(height: 16),
        _buildLabel(l10n.emailAddressLabel),
        isEditingEmail
            ? _buildEmailEditBlock(l10n)
            : _buildDisplayRow(
                user.email.isEmpty ? "example@gmail.com" : user.email,
                onEditEmail,
                l10n,
              ),
        const SizedBox(height: 16),
        _buildLabel(l10n.phoneNumberLabel),
        isEditingPhone
            ? _buildPhoneEditBlock(l10n)
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDisplayRow(
                    user.phoneNumber.isEmpty
                        ? "+998200179181"
                        : user.phoneNumber,
                    onEditPhone,
                    l10n,
                  ),
                  Text(
                    l10n.confirmPhone,
                    style: const TextStyle(color: Colors.blue, fontSize: 14),
                  ),
                ],
              ),
        const SizedBox(height: 16),
        _buildLabel(l10n.passwordLabel),
        isEditingPassword
            ? _buildPasswordEditBlock(l10n)
            : _buildDisplayRow('••••••••', onEditPassword, l10n),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Text(text, style: const TextStyle(color: Colors.grey, fontSize: 14));
  }

  Widget _buildDisplayRow(
    String value,
    VoidCallback onEdit,
    AppLocalizations l10n,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            value.isEmpty ? l10n.nameNotEntered : value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onEdit,
            child: const Icon(Icons.edit, size: 18, color: Colors.blue),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return Container(
      height: 45,
      margin: const EdgeInsets.only(top: 6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildEmailEditBlock(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.emailAddressLabel,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),

                leading: Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    color: Color(0xFF007BFF),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(Icons.circle, color: Colors.white, size: 12),
                  ),
                ),

                title: Text(
                  emailController.text,
                  style: const TextStyle(fontSize: 16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  l10n.unconfirmed,
                  style: const TextStyle(
                    color: Color(0xFF007BFF),
                    fontSize: 14,
                  ),
                ),

                trailing: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4C8C4A),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    l10n.primaryBadge,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5AB981),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: Text(
                      l10n.addNewEmail,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneEditBlock(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 50,
          margin: const EdgeInsets.only(top: 6, bottom: 8),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(4),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(border: InputBorder.none),
              items: [
                DropdownMenuItem(
                  value: "+998",
                  child: Row(
                    children: [
                      const Text("🇺🇿 "),
                      Text("${l10n.uzbekistan} +998"),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: "+1",
                  child: Row(
                    children: [const Text("🇺🇸 "), Text("${l10n.usa} +1")],
                  ),
                ),
              ],
              onChanged: (value) {},
            ),
          ),
        ),
        _buildTextField(phoneController, "20 017 91 81"),
      ],
    );
  }

  Widget _buildPasswordEditBlock(AppLocalizations l10n) {
    return Column(
      children: [
        _buildTextField(currentPasswordController, l10n.currentPasswordHint),
        _buildTextField(newPasswordController, l10n.newPasswordHint),
      ],
    );
  }
}
