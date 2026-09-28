import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/recipe.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final bool isGridView;

  const RecipeCard({
    super.key,
    required this.recipe,
    this.isGridView = true,
  });

  Color _difficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'facile':
        return const Color(0xFF2D7D46);
      case 'intermédiaire':
        return const Color(0xFFE8701A);
      case 'difficile':
        return const Color(0xFFD32F2F);
      default:
        return Colors.grey;
    }
  }

  /// Image.network avec loading indicator et fallback emoji
  Widget _buildNetworkImage({
    required String url,
    required String fallbackEmoji,
    required double height,
    BoxFit fit = BoxFit.cover,
    ColorScheme? colorScheme,
  }) {
    return Image.network(
      url,
      fit: fit,
      height: height,
      width: double.infinity,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Container(
          height: height,
          color: colorScheme?.surfaceContainerHighest ??
              const Color(0xFFEEEEEE),
          child: Center(
            child: SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                value: progress.expectedTotalBytes != null
                    ? progress.cumulativeBytesLoaded /
                        progress.expectedTotalBytes!
                    : null,
                color: colorScheme?.primary ?? const Color(0xFF2D7D46),
              ),
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Container(
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                (colorScheme?.primary ?? const Color(0xFF2D7D46))
                    .withValues(alpha: 0.2),
                (colorScheme?.secondary ?? const Color(0xFFE8701A))
                    .withValues(alpha: 0.15),
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(fallbackEmoji,
                    style: TextStyle(fontSize: height * 0.35)),
                const SizedBox(height: 4),
                Icon(Icons.image_not_supported_outlined,
                    size: 16,
                    color: (colorScheme?.onSurface ?? Colors.grey)
                        .withValues(alpha: 0.3)),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (isGridView) {
      return _buildGridCard(context, theme, colorScheme);
    }
    return _buildListCard(context, theme, colorScheme);
  }

  Widget _buildGridCard(
      BuildContext context, ThemeData theme, ColorScheme colorScheme) {
    return GestureDetector(
      onTap: () => context.pushNamed(
        'recipe_detail',
        pathParameters: {'id': recipe.id},
      ),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with Hero + gradient overlay
            SizedBox(
              height: 118,
              child: Hero(
                tag: 'recipe-image-${recipe.id}',
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    _buildNetworkImage(
                      url: recipe.imageUrl,
                      fallbackEmoji: recipe.imageEmoji,
                      height: 118,
                      colorScheme: colorScheme,
                    ),
                    // Gradient overlay (bottom)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 55,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Color(0xCC000000),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Category badge top-right
                    Positioned(
                      top: 7,
                      right: 7,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(
                              color: Colors.white.withValues(alpha: 0.2),
                              width: 0.5),
                        ),
                        child: Text(
                          recipe.category,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    // Rating badge top-left
                    Positioned(
                      top: 7,
                      left: 7,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star_rounded,
                                color: Color(0xFFF5C542), size: 11),
                            const SizedBox(width: 2),
                            Text(
                              recipe.rating.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Info section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(
                          Icons.timer_outlined,
                          size: 12,
                          color: colorScheme.onSurface.withValues(alpha: 0.5),
                        ),
                        const SizedBox(width: 3),
                        Text(
                          '${recipe.totalTimeMinutes} min',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurface.withValues(alpha: 0.6),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    // Difficulty badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: _difficultyColor(recipe.difficulty)
                            .withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.local_fire_department_rounded,
                            size: 11,
                            color: _difficultyColor(recipe.difficulty),
                          ),
                          const SizedBox(width: 3),
                          Text(
                            recipe.difficulty,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: _difficultyColor(recipe.difficulty),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListCard(
      BuildContext context, ThemeData theme, ColorScheme colorScheme) {
    return GestureDetector(
      onTap: () => context.pushNamed(
        'recipe_detail',
        pathParameters: {'id': recipe.id},
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              // Thumbnail with Hero
              Hero(
                tag: 'recipe-image-${recipe.id}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    width: 76,
                    height: 76,
                    child: _buildNetworkImage(
                      url: recipe.imageUrl,
                      fallbackEmoji: recipe.imageEmoji,
                      height: 76,
                      colorScheme: colorScheme,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      recipe.category,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.timer_outlined,
                            size: 13,
                            color: colorScheme.onSurface
                                .withValues(alpha: 0.5)),
                        const SizedBox(width: 4),
                        Text(
                          '${recipe.totalTimeMinutes} min',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurface.withValues(alpha: 0.6),
                            fontSize: 11,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: _difficultyColor(recipe.difficulty)
                                .withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.local_fire_department_rounded,
                                  size: 11,
                                  color:
                                      _difficultyColor(recipe.difficulty)),
                              const SizedBox(width: 3),
                              Text(
                                recipe.difficulty,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: _difficultyColor(recipe.difficulty),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: colorScheme.onSurface.withValues(alpha: 0.3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
