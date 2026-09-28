class Recipe {
  final String id;
  final String title;
  final String category;
  final String description;
  final String imageEmoji;
  final String imageUrl;
  final int prepTimeMinutes;
  final int cookTimeMinutes;
  final String difficulty;
  final List<String> ingredients;
  final List<String> steps;
  final double rating;
  final int servings;

  const Recipe({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.imageEmoji,
    required this.imageUrl,
    required this.prepTimeMinutes,
    required this.cookTimeMinutes,
    required this.difficulty,
    required this.ingredients,
    required this.steps,
    required this.rating,
    required this.servings,
  });

  int get totalTimeMinutes => prepTimeMinutes + cookTimeMinutes;

  Recipe copyWith({
    String? id,
    String? title,
    String? category,
    String? description,
    String? imageEmoji,
    String? imageUrl,
    int? prepTimeMinutes,
    int? cookTimeMinutes,
    String? difficulty,
    List<String>? ingredients,
    List<String>? steps,
    double? rating,
    int? servings,
  }) {
    return Recipe(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      description: description ?? this.description,
      imageEmoji: imageEmoji ?? this.imageEmoji,
      imageUrl: imageUrl ?? this.imageUrl,
      prepTimeMinutes: prepTimeMinutes ?? this.prepTimeMinutes,
      cookTimeMinutes: cookTimeMinutes ?? this.cookTimeMinutes,
      difficulty: difficulty ?? this.difficulty,
      ingredients: ingredients ?? this.ingredients,
      steps: steps ?? this.steps,
      rating: rating ?? this.rating,
      servings: servings ?? this.servings,
    );
  }
}
