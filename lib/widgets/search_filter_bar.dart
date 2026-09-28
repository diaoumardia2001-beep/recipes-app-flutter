import 'package:flutter/material.dart';

class SearchFilterBar extends StatelessWidget {
  final TextEditingController searchController;
  final String? selectedCategory;
  final List<String> categories;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String?> onCategoryChanged;

  const SearchFilterBar({
    super.key,
    required this.searchController,
    required this.selectedCategory,
    required this.categories,
    required this.onSearchChanged,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search field
        TextField(
          controller: searchController,
          onChanged: onSearchChanged,
          decoration: InputDecoration(
            hintText: 'Rechercher une recette...',
            prefixIcon: Icon(
              Icons.search_rounded,
              color: colorScheme.onSurface.withValues(alpha: 0.5),
            ),
            suffixIcon: searchController.text.isNotEmpty
                ? IconButton(
                    icon: Icon(
                      Icons.clear_rounded,
                      color: colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                    onPressed: () {
                      searchController.clear();
                      onSearchChanged('');
                    },
                  )
                : null,
          ),
        ),
        const SizedBox(height: 12),
        // Category chips
        SizedBox(
          height: 36,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            children: [
              _buildChip(
                context,
                label: 'Tous',
                isSelected: selectedCategory == null || selectedCategory!.isEmpty,
                onTap: () => onCategoryChanged(null),
                colorScheme: colorScheme,
              ),
              ...categories.map((cat) => _buildChip(
                    context,
                    label: cat,
                    isSelected: selectedCategory == cat,
                    onTap: () => onCategoryChanged(
                        selectedCategory == cat ? null : cat),
                    colorScheme: colorScheme,
                  )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChip(
    BuildContext context, {
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required ColorScheme colorScheme,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: ChoiceChip(
          label: Text(label),
          selected: isSelected,
          onSelected: (_) => onTap(),
          selectedColor: colorScheme.primary.withValues(alpha: 0.15),
          checkmarkColor: colorScheme.primary,
          labelStyle: TextStyle(
            color: isSelected
                ? colorScheme.primary
                : colorScheme.onSurface.withValues(alpha: 0.7),
            fontWeight:
                isSelected ? FontWeight.w600 : FontWeight.w400,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
