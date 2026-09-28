import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/recipes_data.dart';
import '../models/recipe.dart';
import '../widgets/recipe_card.dart';
import '../widgets/search_filter_bar.dart';
import '../widgets/custom_empty_state.dart';
import '../widgets/app_logo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String? _selectedCategory;
  bool _isGridView = true;

  List<Recipe> get _filteredRecipes => RecipesRepository.filterRecipes(
        query: _searchQuery,
        category: _selectedCategory,
      );

  List<String> get _categories => RecipesRepository.getCategories();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  int _crossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 900) return 4;
    if (width > 600) return 3;
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final recipes = _filteredRecipes;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 16,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppLogo(size: 38),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Cuisine Ivoirienne',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.4,
                  ),
                ),
                Text(
                  '${RecipesRepository.getAllRecipes().length} recettes authentiques',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.5),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => setState(() => _isGridView = !_isGridView),
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                _isGridView
                    ? Icons.view_list_rounded
                    : Icons.grid_view_rounded,
                key: ValueKey(_isGridView),
                color: colorScheme.primary,
              ),
            ),
            tooltip: _isGridView ? 'Vue liste' : 'Vue grille',
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: Column(
        children: [
          // Search & Filter Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: SearchFilterBar(
              searchController: _searchController,
              selectedCategory: _selectedCategory,
              categories: _categories,
              onSearchChanged: (q) => setState(() => _searchQuery = q),
              onCategoryChanged: (cat) =>
                  setState(() => _selectedCategory = cat),
            ),
          ),
          const SizedBox(height: 6),
          // Results count
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
            child: Row(
              children: [
                Text(
                  '${recipes.length} résultat${recipes.length > 1 ? 's' : ''}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.5),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          // Recipe list or grid
          Expanded(
            child: recipes.isEmpty
                ? CustomEmptyState(
                    emoji: '🔍',
                    title: 'Aucune recette trouvée',
                    subtitle:
                        'Essayez un autre terme de recherche ou ajoutez votre propre recette.',
                    buttonLabel: 'Ajouter une recette',
                    onButtonPressed: () => context.goNamed('add_recipe'),
                  )
                : _isGridView
                    ? LayoutBuilder(
                        builder: (context, constraints) {
                          return GridView.builder(
                            padding: const EdgeInsets.fromLTRB(
                                16, 4, 16, 100),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: _crossAxisCount(context),
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 0.70,
                            ),
                            itemCount: recipes.length,
                            itemBuilder: (context, index) => RecipeCard(
                              recipe: recipes[index],
                              isGridView: true,
                            ),
                          );
                        },
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
                        itemCount: recipes.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: RecipeCard(
                            recipe: recipes[index],
                            isGridView: false,
                          ),
                        ),
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.goNamed('add_recipe'),
        backgroundColor: colorScheme.secondary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'Ajouter',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
