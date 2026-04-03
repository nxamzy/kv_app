import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_kv/l10n/app_localizations.dart';
import 'package:my_kv/logic/cubit/settings_cubit.dart';
import 'package:my_kv/logic/cubit/settings_state.dart';
import 'package:my_kv/presentation/pages/profile_pages/widgets_profile_page.dart/profile_header.dart';

class MainProfilePage extends StatefulWidget {
  const MainProfilePage({super.key});

  @override
  State<MainProfilePage> createState() => _MainProfilePageState();
}

class _MainProfilePageState extends State<MainProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final l10n = AppLocalizations.of(context);
        final currentLangCode = Localizations.localeOf(context).languageCode;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              l10n.myAccount,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0.5,
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          body: ListView(
            children: [
              const ProfileHeader(),
              const Divider(height: 1, color: Color(0xFFEEEEEE)),

              _buildSectionTitle(l10n.general),

              _buildSettingsTile(
                icon: Icons.language_outlined,
                title: l10n.language,
                subtitle: currentLangCode == 'uz'
                    ? "O'zbekcha"
                    : currentLangCode == 'ru'
                    ? "Русский"
                    : "English",
                onTap: () => _showLanguagePicker(context, l10n),
              ),

              _buildSectionTitle(l10n.notifications),
              _buildSettingsTile(
                icon: Icons.notifications_none_outlined,
                title: l10n.push_notifications,
                trailing: Switch(
                  value: true,
                  onChanged: (v) {},
                  activeColor: Colors.black,
                ),
              ),

              _buildSectionTitle(l10n.help),
              _buildSettingsTile(
                icon: Icons.help_outline,
                title: l10n.faq,
                onTap: () {},
              ),
              _buildSettingsTile(
                icon: Icons.info_outline,
                title: l10n.about_app,
                onTap: () {},
              ),

              const SizedBox(height: 20),
              Center(
                child: Text(
                  "${l10n.versionTxt} 1.0.0",
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  void _showLanguagePicker(BuildContext context, AppLocalizations l10n) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.selectLanguageTitle,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 15),
              _languageItem(context, "O'zbekcha", "uz", "🇺🇿"),
              _languageItem(context, "Русский", "ru", "🇷🇺"),
              _languageItem(context, "English", "en", "🇺🇸"),
            ],
          ),
        );
      },
    );
  }

  Widget _languageItem(
    BuildContext context,
    String name,
    String code,
    String flag,
  ) {
    return ListTile(
      leading: Text(flag, style: const TextStyle(fontSize: 24)),
      title: Text(name, style: const TextStyle(color: Colors.black)),
      onTap: () {
        context.read<SettingsCubit>().updateLanguage(code);
        Navigator.pop(context);
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: Colors.grey.shade600,
          fontWeight: FontWeight.bold,
          fontSize: 11,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(
        title,
        style: const TextStyle(color: Colors.black, fontSize: 15),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
            )
          : null,
      trailing:
          trailing ??
          const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
      onTap: onTap,
    );
  }
}
