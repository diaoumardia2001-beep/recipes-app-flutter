import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/recipes_data.dart';
import '../models/recipe.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _prepTimeController = TextEditingController();
  final _cookTimeController = TextEditingController();
  final _servingsController = TextEditingController();
  final _ingredientsController = TextEditingController();

  String? _selectedCategory;
  String _selectedDifficulty = 'Facile';
  String _selectedEmoji = '🍽️';
  bool _isSubmitting = false;

  static const List<String> _categories = [
    'Plat Principal',
    'Entrée',
    'Sauce',
    'Accompagnement',
    'Dessert',
    'Boisson',
  ];

  static const List<String> _difficulties = [
    'Facile',
    'Intermédiaire',
    'Difficile',
  ];

  static const List<String> _emojis = [
    '🍽️', '🐟', '🍌', '🍗', '🌴', '🥣', '🐠', '🥘', '🍲', '🥗',
    '🫕', '🍛', '🌶️', '🥬', '🫙', '🍤', '🥩', '🫚',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _prepTimeController.dispose();
    _cookTimeController.dispose();
    _servingsController.dispose();
    _ingredientsController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    // Simulate async save
    await Future.delayed(const Duration(milliseconds: 600));

    final ingredients = _ingredientsController.text
        .split('\n')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    final newRecipe = Recipe(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      category: _selectedCategory!,
      description: _descriptionController.text.trim(),
      imageEmoji: _selectedEmoji,
      imageUrl: '',
      prepTimeMinutes: int.parse(_prepTimeController.text.trim()),
      cookTimeMinutes: int.parse(_cookTimeController.text.trim()),
      difficulty: _selectedDifficulty,
      ingredients: ingredients.isNotEmpty
          ? ingredients
          : ['Ingrédients à compléter'],
      steps: ['Étapes à compléter'],
      rating: 0.0,
      servings: int.tryParse(_servingsController.text.trim()) ?? 2,
    );

    RecipesRepository.addRecipe(newRecipe);

    if (mounted) {
      setState(() => _isSubmitting = false);
      _showSuccessDialog(newRecipe);
    }
  }

  void _showSuccessDialog(Recipe recipe) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Column(
          children: [
            Text(recipe.imageEmoji,
                style: const TextStyle(fontSize: 48)),
            const SizedBox(height: 8),
            const Text(
              'Recette ajoutée !',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ],
        ),
        content: Text(
          '« ${recipe.title} » a été ajoutée avec succès à votre collection de recettes ivoiriennes.',
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.go('/');
            },
            child: const Text('Voir les recettes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nouvelle recette'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.go('/'),
        ),
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          children: [
            // Header
            _buildSectionCard(
              context,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Informations générales',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Emoji selector
                  Text(
                    'Choisir une icône',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.6),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 56,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _emojis.length,
                      itemBuilder: (context, i) {
                        final emoji = _emojis[i];
                        final isSelected = emoji == _selectedEmoji;
                        return GestureDetector(
                          onTap: () =>
                              setState(() => _selectedEmoji = emoji),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.only(right: 8),
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? colorScheme.primary.withValues(alpha: 0.15)
                                  : colorScheme.surface,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected
                                    ? colorScheme.primary
                                    : colorScheme.onSurface.withValues(alpha: 0.12),
                                width: isSelected ? 2 : 1,
                              ),
                            ),
                            child: Center(
                              child: Text(emoji,
                                  style: const TextStyle(fontSize: 24)),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Title
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Nom de la recette *',
                      hintText: 'Ex: Attiéké au thon',
                      prefixIcon: Icon(Icons.restaurant_menu_rounded),
                    ),
                    textCapitalization: TextCapitalization.sentences,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) {
                        return 'Le nom de la recette est obligatoire';
                      }
                      if (v.trim().length < 3) {
                        return 'Le nom doit contenir au moins 3 caractères';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 14),
                  // Description
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Description *',
                      hintText: 'Décrivez votre recette...',
                      prefixIcon: Icon(Icons.description_rounded),
                      alignLabelWithHint: true,
                    ),
                    maxLines: 3,
                    textCapitalization: TextCapitalization.sentences,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) {
                        return 'La description est obligatoire';
                      }
                      if (v.trim().length < 10) {
                        return 'La description doit contenir au moins 10 caractères';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Category & Difficulty
            _buildSectionCard(
              context,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Catégorie & Difficulté',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Category dropdown
                  DropdownButtonFormField<String>(
                    initialValue: _selectedCategory,
                    decoration: const InputDecoration(
                      labelText: 'Catégorie *',
                      prefixIcon: Icon(Icons.category_rounded),
                    ),
                    items: _categories
                        .map((c) => DropdownMenuItem(
                              value: c,
                              child: Text(c),
                            ))
                        .toList(),
                    onChanged: (v) =>
                        setState(() => _selectedCategory = v),
                    validator: (v) => v == null
                        ? 'Veuillez sélectionner une catégorie'
                        : null,
                  ),
                  const SizedBox(height: 14),
                  // Difficulty
                  Text(
                    'Niveau de difficulté',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.6),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: _difficulties.map((d) {
                      final isSelected = d == _selectedDifficulty;
                      Color diffColor;
                      switch (d) {
                        case 'Facile':
                          diffColor = const Color(0xFF2D7D46);
                          break;
                        case 'Intermédiaire':
                          diffColor = const Color(0xFFE8701A);
                          break;
                        default:
                          diffColor = const Color(0xFFD32F2F);
                      }
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            child: ChoiceChip(
                              label: Text(d),
                              selected: isSelected,
                              onSelected: (_) =>
                                  setState(() => _selectedDifficulty = d),
                              selectedColor: diffColor.withValues(alpha: 0.15),
                              checkmarkColor: diffColor,
                              labelStyle: TextStyle(
                                color: isSelected
                                    ? diffColor
                                    : colorScheme.onSurface.withValues(alpha: 0.7),
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Time & Servings
            _buildSectionCard(
              context,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Temps & Portions',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _prepTimeController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Préparation (min) *',
                            prefixIcon: Icon(Icons.schedule_rounded),
                          ),
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return 'Obligatoire';
                            }
                            final n = int.tryParse(v.trim());
                            if (n == null || n < 1) {
                              return 'Nombre valide';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: _cookTimeController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Cuisson (min) *',
                            prefixIcon: Icon(
                                Icons.local_fire_department_rounded),
                          ),
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return 'Obligatoire';
                            }
                            final n = int.tryParse(v.trim());
                            if (n == null || n < 0) {
                              return 'Nombre valide';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _servingsController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Nombre de portions *',
                      prefixIcon: Icon(Icons.people_alt_rounded),
                      hintText: 'Ex: 4',
                    ),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) {
                        return 'Le nombre de portions est obligatoire';
                      }
                      final n = int.tryParse(v.trim());
                      if (n == null || n < 1) {
                        return 'Entrez un nombre valide (≥ 1)';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Ingredients
            _buildSectionCard(
              context,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ingrédients',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Entrez un ingrédient par ligne',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _ingredientsController,
                    maxLines: 6,
                    decoration: const InputDecoration(
                      hintText:
                          '500g d\'attiéké\n2 darnes de thon\n1 oignon...',
                      prefixIcon: Icon(Icons.list_rounded),
                      alignLabelWithHint: true,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            // Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isSubmitting ? null : _submitForm,
                icon: _isSubmitting
                    ? SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      )
                    : const Icon(Icons.check_rounded),
                label: Text(
                    _isSubmitting ? 'Enregistrement...' : 'Ajouter la recette'),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(BuildContext context, {required Widget child}) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.onSurface.withValues(alpha: 0.08)),
      ),
      child: child,
    );
  }
}
