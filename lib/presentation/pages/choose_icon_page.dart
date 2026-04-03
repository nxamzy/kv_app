import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_kv/l10n/app_localizations.dart';
import 'package:my_kv/logic/cubit/expence_cubit.dart';

class CategoryPickerSheet extends StatefulWidget {
  final String? docId;
  final int? currentIconCode;
  final Function(IconData)? onSelect;

  const CategoryPickerSheet({
    super.key,
    required this.docId,
    this.onSelect,
    this.currentIconCode,
  });

  @override
  State<CategoryPickerSheet> createState() => _CategoryPickerSheetState();
}

class _CategoryPickerSheetState extends State<CategoryPickerSheet> {
  int? _selectedIconCode;

  @override
  void initState() {
    super.initState();
    _selectedIconCode = widget.currentIconCode;
  }

  Future<void> _updateIcon(int iconCode) async {
    setState(() => _selectedIconCode = iconCode);
    try {
      await context.read<ExpenseCubit>().updateIcon(widget.docId!, iconCode);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      debugPrint("Xato chiqdi: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              l10n.selectCategory,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _buildCategoryGroup(l10n.entertainment, [
                  Icons.sports_esports,
                  Icons.confirmation_number,
                  Icons.music_note,
                  Icons.movie,
                  Icons.sports_soccer,
                ]),
                _buildCategoryGroup(l10n.foodDrink, [
                  Icons.restaurant,
                  Icons.shopping_cart,
                  Icons.local_bar,
                  Icons.fastfood,
                  Icons.coffee,
                ]),
                _buildCategoryGroup(l10n.homeGroup, [
                  Icons.bolt,
                  Icons.chair,
                  Icons.sanitizer,
                  Icons.build,
                  Icons.home,
                  Icons.pets,
                ]),
                _buildCategoryGroup(l10n.transportation, [
                  Icons.directions_bike,
                  Icons.train,
                  Icons.directions_car,
                  Icons.local_gas_station,
                  Icons.directions_bus,
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryGroup(String title, List<IconData> icons) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.grey[600],
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 15,
          runSpacing: 15,
          children: icons.map((icon) => _buildIconItem(icon)).toList(),
        ),
        const Divider(height: 30),
      ],
    );
  }

  Widget _buildIconItem(IconData icon) {
    bool isSelected = _selectedIconCode == icon.codePoint;

    return InkWell(
      onTap: () => _updateIcon(icon.codePoint),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.transparent,
          border: Border.all(
            color: isSelected ? Colors.grey : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.grey[700],
          size: 28,
        ),
      ),
    );
  }
}
