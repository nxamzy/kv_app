import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_kv/l10n/app_localizations.dart';
import 'package:my_kv/presentation/group_detail.dart';

class GroupSelector extends StatelessWidget {
  final String? userId;
  final String selectedGroupId;
  final Function(String) onGroupSelected;
  final VoidCallback onAllSelected;

  const GroupSelector({
    super.key,
    this.userId,
    required this.selectedGroupId,
    required this.onGroupSelected,
    required this.onAllSelected,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SizedBox(
      height: 100,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('groups')
            .where('members', arrayContains: userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          }
          final groups = snapshot.data!.docs;

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            itemCount: groups.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) return _buildAllTab(l10n);

              var g = groups[index - 1];
              final data = g.data() as Map<String, dynamic>;
              bool isSelected = selectedGroupId == g.id;

              return GestureDetector(
                onTap: () {
                  if (isSelected) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GroupDetailsPage(groupId: g.id),
                      ),
                    );
                  } else {
                    onGroupSelected(g.id);
                  }
                },
                child: Container(
                  width: 100,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.black : Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: isSelected ? Colors.black : Colors.black12,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        IconData(
                          data['iconCode'] ?? 58160,
                          fontFamily: 'MaterialIcons',
                        ),
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        data['name'],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildAllTab(AppLocalizations l10n) {
    bool isAllSelected = selectedGroupId == 'all';
    return GestureDetector(
      onTap: onAllSelected,
      child: Container(
        width: 80,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: isAllSelected ? Colors.black : Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.dashboard,
              color: isAllSelected ? Colors.white : Colors.black,
            ),
            const SizedBox(height: 5),
            Text(
              l10n.all,
              style: TextStyle(
                color: isAllSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
