import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_kv/l10n/app_localizations.dart';
import 'package:my_kv/logic/cubit/group_cubit.dart';
import 'package:my_kv/logic/cubit/settings_cubit.dart';
import 'package:my_kv/logic/cubit/settings_state.dart';
import 'package:my_kv/presentation/pages/choose_icon_page.dart';

class CreateGroupPage extends StatefulWidget {
  final String initialType;
  const CreateGroupPage({super.key, this.initialType = "Uy"});

  @override
  State<CreateGroupPage> createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  final TextEditingController _groupNameController = TextEditingController();
  late String _selectedType;
  IconData _customIconForOther = Icons.more_horiz;

  @override
  void initState() {
    super.initState();
    _selectedType = widget.initialType;
  }

  void showTopNotification(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 10,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }

  void _showIconPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CategoryPickerSheet(
        docId: null,
        onSelect: (newIcon) {
          setState(() {
            _customIconForOther = newIcon;
            _selectedType = "Boshqa";
          });
        },
      ),
    );
  }

  void _saveGroup(AppLocalizations l10n) {
    if (_groupNameController.text.trim().isEmpty) {
      showTopNotification(context, l10n.enterGroupName);
      return;
    }

    int finalIconCode;
    if (_selectedType == "Boshqa") {
      finalIconCode = _customIconForOther.codePoint;
    } else {
      final Map<String, IconData> technicalIcons = {
        'Uy': Icons.home_outlined,
        'Sayohat': Icons.flight_takeoff,
        "Do'stlar": Icons.group,
        'Boshqa': Icons.more_horiz,
      };
      finalIconCode = technicalIcons[_selectedType]!.codePoint;
    }

    context.read<GroupCubit>().createGroup(
      name: _groupNameController.text.trim(),
      type: _selectedType,
      iconCode: finalIconCode,
      memberEmails: [],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, settingsState) {
        final l10n = AppLocalizations.of(context);

        final List<Map<String, dynamic>> groupTypes = [
          {'id': 'Uy', 'name': l10n.home, 'icon': Icons.home_outlined},
          {'id': 'Sayohat', 'name': l10n.travel, 'icon': Icons.flight_takeoff},
          {'id': "Do'stlar", 'name': l10n.friends, 'icon': Icons.group},
          {'id': 'Boshqa', 'name': l10n.other, 'icon': Icons.more_horiz},
        ];

        return BlocListener<GroupCubit, GroupState>(
          listener: (context, state) {
            if (state is GroupSuccess) {
              Navigator.pop(context);
            }
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.close, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                l10n.newGroup,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.groupName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _groupNameController,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      hintText: l10n.groupNameHint,
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    l10n.groupType,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: groupTypes
                        .map((type) => _buildTypeChip(type))
                        .toList(),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(24),
              child: BlocBuilder<GroupCubit, GroupState>(
                builder: (context, state) {
                  bool isLoading = state is GroupLoading;

                  return ElevatedButton(
                    onPressed: isLoading ? null : () => _saveGroup(l10n),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      disabledBackgroundColor: Colors.grey,
                      minimumSize: const Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            l10n.createGroup,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTypeChip(Map<String, dynamic> type) {
    bool isSelected = _selectedType == type['id'];
    IconData displayIcon = (type['id'] == 'Boshqa')
        ? _customIconForOther
        : type['icon'];

    return GestureDetector(
      onTap: () => type['id'] == 'Boshqa'
          ? _showIconPicker()
          : setState(() => _selectedType = type['id']),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: isSelected ? Colors.black : Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: Icon(
              displayIcon,
              color: isSelected ? Colors.white : Colors.black54,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            type['name'],
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.black54,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
