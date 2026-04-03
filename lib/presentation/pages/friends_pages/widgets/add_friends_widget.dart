import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_kv/l10n/app_localizations.dart';
import 'package:my_kv/logic/cubit/settings_cubit.dart';
import 'package:my_kv/logic/cubit/settings_state.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

class QrInvitePage extends StatefulWidget {
  const QrInvitePage({super.key});

  @override
  State<QrInvitePage> createState() => _QrInvitePageState();
}

class _QrInvitePageState extends State<QrInvitePage> {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  late String myUid;
  late String inviteLink;

  @override
  void initState() {
    super.initState();
    myUid = currentUser?.uid ?? "noma'lum_id";
    _generateLink();
  }

  void _generateLink() {
    setState(() {
      inviteLink = "planway.com/add_friend/$myUid";
    });
  }

  void _copyCode(AppLocalizations l10n) {
    Clipboard.setData(ClipboardData(text: inviteLink));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.linkCopied),
        backgroundColor: Colors.black,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _shareCode(AppLocalizations l10n) {
    Share.share("${l10n.shareMessage} $inviteLink");
  }

  void _changeCode(AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.changeCodeTitle),
        content: Text(l10n.changeCodeDesc),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              l10n.cancel,
              style: const TextStyle(color: Colors.black),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(l10n.newCodeCreated),
                  backgroundColor: Colors.black,
                ),
              );
            },
            child: Text(
              l10n.other,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final l10n = AppLocalizations.of(context);

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.close, color: Colors.black, size: 28),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              l10n.myCode,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 35,
                        left: 30,
                        right: 30,
                      ),
                      padding: const EdgeInsets.only(
                        top: 50,
                        bottom: 40,
                        left: 40,
                        right: 40,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          colors: [Colors.black, Colors.grey],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 15,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            state is SettingsLoaded
                                ? state.user.fullName
                                : l10n.loading,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: QrImageView(
                              data: myUid,
                              version: QrVersions.auto,
                              size: 190.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 0,
                      child: Container(
                        height: 75,
                        width: 75,
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey.shade800,
                          child: Text(
                            state is SettingsLoaded &&
                                    state.user.fullName.isNotEmpty
                                ? state.user.fullName[0].toUpperCase()
                                : "U",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                _buildActionTile(
                  icon: Icons.ios_share,
                  title: l10n.shareCode,
                  onTap: () => _shareCode(l10n),
                ),
                const Divider(height: 1, color: Color(0xFFEEEEEE)),
                _buildActionTile(
                  icon: Icons.copy,
                  title: l10n.copyCode,
                  onTap: () => _copyCode(l10n),
                ),
                const Divider(height: 1, color: Color(0xFFEEEEEE)),
                _buildActionTile(
                  icon: Icons.block,
                  title: l10n.changeCode,
                  onTap: () => _changeCode(l10n),
                  isDestructive: true,
                ),
                const Divider(height: 1, color: Color(0xFFEEEEEE)),

                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    l10n.qrWarning,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      leading: Icon(
        icon,
        color: isDestructive ? Colors.red : Colors.grey.shade600,
        size: 28,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: isDestructive ? Colors.red : Colors.black,
        ),
      ),
      onTap: onTap,
    );
  }
}
