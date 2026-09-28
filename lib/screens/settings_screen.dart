import 'package:flutter/material.dart';
import '../theme/theme_notifier.dart';

class SettingsScreen extends StatelessWidget {
  final ThemeNotifier themeNotifier;

  const SettingsScreen({super.key, required this.themeNotifier});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Réglages'),
      ),
      body: ListenableBuilder(
        listenable: themeNotifier,
        builder: (context, _) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // App info header
              _buildHeader(context, colorScheme),
              const SizedBox(height: 24),
              // Appearance section
              _buildSectionTitle(context, 'Apparence'),
              const SizedBox(height: 8),
              _buildThemeCard(context, theme, colorScheme),
              const SizedBox(height: 24),
              // About section
              _buildSectionTitle(context, 'À propos'),
              const SizedBox(height: 8),
              _buildAboutCard(context, colorScheme),
              const SizedBox(height: 24),
              // Stats section
              _buildSectionTitle(context, 'Statistiques'),
              const SizedBox(height: 8),
              _buildStatsCard(context, colorScheme),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ColorScheme colorScheme) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primary.withValues(alpha: 0.2),
            colorScheme.secondary.withValues(alpha: 0.15),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: Text('🇨🇮', style: TextStyle(fontSize: 36)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cuisine Ivoirienne',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Découvrez l\'authenticité\nde la gastronomie ivoirienne',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        title.toUpperCase(),
        style: theme.textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
          color: colorScheme.primary,
          fontSize: 11,
        ),
      ),
    );
  }

  Widget _buildThemeCard(
      BuildContext context, ThemeData theme, ColorScheme colorScheme) {
    final isDark = themeNotifier.isDark;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.onSurface.withValues(alpha: 0.08)),
      ),
      child: Column(
        children: [
          // Theme mode switch
          ListTile(
            leading: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF1A237E).withValues(alpha: 0.2)
                    : const Color(0xFFFFF59D).withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Icon(
                  isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                  color: isDark
                      ? const Color(0xFF7986CB)
                      : const Color(0xFFF9A825),
                  size: 22,
                ),
              ),
            ),
            title: const Text(
              'Mode sombre',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              isDark ? 'Thème sombre activé' : 'Thème clair activé',
              style: TextStyle(
                color: colorScheme.onSurface.withValues(alpha: 0.5),
                fontSize: 12,
              ),
            ),
            trailing: Switch(
              value: isDark,
              onChanged: (_) => themeNotifier.toggleTheme(),
              activeThumbColor: colorScheme.primary,
            ),
            onTap: () => themeNotifier.toggleTheme(),
          ),
          Divider(height: 1, color: colorScheme.onSurface.withValues(alpha: 0.08)),
          // Theme selector tiles
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                _ThemeModeButton(
                  label: 'Clair',
                  icon: Icons.light_mode_rounded,
                  isSelected: !isDark,
                  onTap: () => themeNotifier
                      .setThemeMode(ThemeMode.light),
                  colorScheme: colorScheme,
                ),
                const SizedBox(width: 12),
                _ThemeModeButton(
                  label: 'Sombre',
                  icon: Icons.dark_mode_rounded,
                  isSelected: isDark,
                  onTap: () => themeNotifier
                      .setThemeMode(ThemeMode.dark),
                  colorScheme: colorScheme,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutCard(BuildContext context, ColorScheme colorScheme) {
    final items = [
      (Icons.info_outline_rounded, 'Version', '1.0.0'),
      (Icons.code_rounded, 'Technologie', 'Flutter 3.x'),
      (Icons.language_rounded, 'Langue', 'Français'),
      (Icons.flag_rounded, 'Origine', 'Côte d\'Ivoire 🇨🇮'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.onSurface.withValues(alpha: 0.08)),
      ),
      child: Column(
        children: items.asMap().entries.map((entry) {
          final i = entry.key;
          final item = entry.value;
          return Column(
            children: [
              ListTile(
                leading: Icon(item.$1, color: colorScheme.primary, size: 22),
                title: Text(item.$2),
                trailing: Text(
                  item.$3,
                  style: TextStyle(
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                dense: true,
              ),
              if (i < items.length - 1)
                Divider(
                    height: 1,
                    indent: 56,
                    color: colorScheme.onSurface.withValues(alpha: 0.06)),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildStatsCard(BuildContext context, ColorScheme colorScheme) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.onSurface.withValues(alpha: 0.08)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatTile(
            emoji: '📚',
            value: '6+',
            label: 'Recettes',
            theme: theme,
            colorScheme: colorScheme,
          ),
          Container(
              width: 1, height: 40, color: colorScheme.onSurface.withValues(alpha: 0.1)),
          _StatTile(
            emoji: '🏷️',
            value: '5',
            label: 'Catégories',
            theme: theme,
            colorScheme: colorScheme,
          ),
          Container(
              width: 1, height: 40, color: colorScheme.onSurface.withValues(alpha: 0.1)),
          _StatTile(
            emoji: '⭐',
            value: '4.7',
            label: 'Note moy.',
            theme: theme,
            colorScheme: colorScheme,
          ),
        ],
      ),
    );
  }
}

class _ThemeModeButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final ColorScheme colorScheme;

  const _ThemeModeButton({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? colorScheme.primary.withValues(alpha: 0.12)
                : colorScheme.onSurface.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? colorScheme.primary
                  : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected
                    ? colorScheme.primary
                    : colorScheme.onSurface.withValues(alpha: 0.5),
                size: 22,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected
                      ? colorScheme.primary
                      : colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final String emoji;
  final String value;
  final String label;
  final ThemeData theme;
  final ColorScheme colorScheme;

  const _StatTile({
    required this.emoji,
    required this.value,
    required this.label,
    required this.theme,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w800,
            color: colorScheme.primary,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurface.withValues(alpha: 0.5),
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}
