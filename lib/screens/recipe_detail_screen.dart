import 'package:flutter/material.dart';
import '../data/recipes_data.dart';
import '../models/recipe.dart';
import '../widgets/custom_empty_state.dart';

class RecipeDetailScreen extends StatelessWidget {
  final String recipeId;

  const RecipeDetailScreen({super.key, required this.recipeId});

  @override
  Widget build(BuildContext context) {
    final recipe = RecipesRepository.getRecipeById(recipeId);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (recipe == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Recette introuvable')),
        body: const CustomEmptyState(
          emoji: '😕',
          title: 'Recette introuvable',
          subtitle: 'Cette recette n\'existe pas ou a été supprimée.',
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Hero SliverAppBar with real image
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            stretch: true,
            backgroundColor: colorScheme.surface,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [StretchMode.zoomBackground],
              background: Hero(
                tag: 'recipe-image-${recipe.id}',
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Real image
                    Image.network(
                      recipe.imageUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return Container(
                          color: colorScheme.surfaceContainerHighest,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(recipe.imageEmoji,
                                    style: const TextStyle(fontSize: 60)),
                                const SizedBox(height: 16),
                                SizedBox(
                                  width: 32,
                                  height: 32,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: colorScheme.primary,
                                    value: progress.expectedTotalBytes != null
                                        ? progress.cumulativeBytesLoaded /
                                            progress.expectedTotalBytes!
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                colorScheme.primary.withValues(alpha: 0.3),
                                colorScheme.secondary.withValues(alpha: 0.2),
                                colorScheme.tertiary.withValues(alpha: 0.15),
                              ],
                            ),
                          ),
                          child: Center(
                            child: Text(recipe.imageEmoji,
                                style: const TextStyle(fontSize: 100)),
                          ),
                        );
                      },
                    ),
                    // Top vignette for legible back button
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.0, 0.25, 0.65, 1.0],
                          colors: [
                            Color(0xAA000000),
                            Color(0x33000000),
                            Colors.transparent,
                            Color(0x99000000),
                          ],
                        ),
                      ),
                    ),
                    // Bottom gradient to surface
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 90,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              colorScheme.surface,
                              colorScheme.surface.withValues(alpha: 0),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category chip
                  Chip(
                    label: Text(recipe.category),
                    backgroundColor: colorScheme.primary.withValues(alpha: 0.12),
                    labelStyle: TextStyle(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                    side: BorderSide.none,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4, vertical: 0),
                    visualDensity: VisualDensity.compact,
                  ),
                  const SizedBox(height: 8),
                  // Title
                  Text(
                    recipe.title,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Stats Row
                  _StatsRow(recipe: recipe, colorScheme: colorScheme),
                  const SizedBox(height: 20),
                  // Description
                  Text(
                    recipe.description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.7),
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 28),
                  // Ingredients
                  _SectionHeader(
                    icon: Icons.restaurant_menu_rounded,
                    title: 'Ingrédients',
                    subtitle:
                        '${recipe.ingredients.length} ingrédients · ${recipe.servings} portions',
                    colorScheme: colorScheme,
                  ),
                  const SizedBox(height: 12),
                  _IngredientsCard(
                      ingredients: recipe.ingredients,
                      colorScheme: colorScheme),
                  const SizedBox(height: 28),
                  // Steps
                  _SectionHeader(
                    icon: Icons.format_list_numbered_rounded,
                    title: 'Préparation',
                    subtitle: '${recipe.steps.length} étapes',
                    colorScheme: colorScheme,
                  ),
                  const SizedBox(height: 12),
                  _StepsList(steps: recipe.steps, colorScheme: colorScheme),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  final Recipe recipe;
  final ColorScheme colorScheme;

  const _StatsRow({required this.recipe, required this.colorScheme});

  Color _difficultyColor(String d) {
    switch (d.toLowerCase()) {
      case 'facile':
        return const Color(0xFF2D7D46);
      case 'intermédiaire':
        return const Color(0xFFE8701A);
      default:
        return const Color(0xFFD32F2F);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorScheme.onSurface.withValues(alpha: 0.08),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatItem(
            icon: Icons.timer_outlined,
            label: 'Prép.',
            value: '${recipe.prepTimeMinutes} min',
            colorScheme: colorScheme,
          ),
          _Divider(colorScheme: colorScheme),
          _StatItem(
            icon: Icons.local_fire_department_rounded,
            label: 'Cuisson',
            value: '${recipe.cookTimeMinutes} min',
            iconColor: const Color(0xFFE8701A),
            colorScheme: colorScheme,
          ),
          _Divider(colorScheme: colorScheme),
          _StatItem(
            icon: Icons.trending_up_rounded,
            label: 'Niveau',
            value: recipe.difficulty,
            valueColor: _difficultyColor(recipe.difficulty),
            colorScheme: colorScheme,
          ),
          _Divider(colorScheme: colorScheme),
          _StatItem(
            icon: Icons.star_rounded,
            label: 'Note',
            value: '${recipe.rating}/5',
            iconColor: const Color(0xFFF5C542),
            valueColor: const Color(0xFFF5C542),
            colorScheme: colorScheme,
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  final ColorScheme colorScheme;
  const _Divider({required this.colorScheme});

  @override
  Widget build(BuildContext context) => Container(
        width: 1,
        height: 36,
        color: colorScheme.onSurface.withValues(alpha: 0.1),
      );
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;
  final Color? iconColor;
  final ColorScheme colorScheme;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
    this.iconColor,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon,
            size: 20,
            color: iconColor ?? valueColor ?? colorScheme.primary),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 12,
            color: valueColor ?? colorScheme.onSurface,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: colorScheme.onSurface.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final ColorScheme colorScheme;

  const _SectionHeader({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: colorScheme.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 20, color: colorScheme.primary),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              subtitle,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.5),
                fontSize: 11,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _IngredientsCard extends StatelessWidget {
  final List<String> ingredients;
  final ColorScheme colorScheme;

  const _IngredientsCard(
      {required this.ingredients, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: colorScheme.onSurface.withValues(alpha: 0.08)),
      ),
      child: Column(
        children: ingredients.asMap().entries.map((entry) {
          final index = entry.key;
          final ingredient = entry.value;
          final isLast = index == ingredients.length - 1;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: colorScheme.secondary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(ingredient,
                          style: theme.textTheme.bodyMedium),
                    ),
                  ],
                ),
              ),
              if (!isLast)
                Divider(
                  height: 1,
                  indent: 36,
                  color: colorScheme.onSurface.withValues(alpha: 0.06),
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _StepsList extends StatelessWidget {
  final List<String> steps;
  final ColorScheme colorScheme;

  const _StepsList({required this.steps, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: steps.asMap().entries.map((entry) {
        final index = entry.key;
        final step = entry.value;
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(14),
                      bottomLeft: Radius.circular(14),
                      bottomRight: Radius.circular(14),
                    ),
                    border: Border.all(
                        color:
                            colorScheme.onSurface.withValues(alpha: 0.08)),
                  ),
                  child: Text(
                    step,
                    style:
                        theme.textTheme.bodyMedium?.copyWith(height: 1.5),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
