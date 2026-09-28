import '../models/recipe.dart';

class RecipesRepository {
  static final List<Recipe> _recipes = [
    const Recipe(
      id: '1',
      title: 'Garba',
      category: 'Plat Principal',
      description:
          'Le Garba est un plat emblématique de Côte d\'Ivoire, adoré de tous. Il se compose de semoule de manioc (attiéké) accompagnée de thon frit croustillant. Un régal du quotidien abidjanais.',
      imageEmoji: '🐟',
      imageUrl:
          'https://images.unsplash.com/photo-1467003909585-2f8a72700288?auto=format&fit=crop&w=800&q=80',
      prepTimeMinutes: 15,
      cookTimeMinutes: 20,
      difficulty: 'Facile',
      rating: 4.8,
      servings: 4,
      ingredients: [
        '500g d\'attiéké (semoule de manioc)',
        '4 darnes de thon frais',
        '2 oignons moyens',
        '3 tomates mûres',
        '2 piments (selon goût)',
        'Huile de friture',
        'Sel et poivre',
        'Cube Maggi',
        'Jus de citron',
      ],
      steps: [
        'Assaisonnez le thon avec le sel, le poivre et le cube Maggi. Laissez mariner 10 minutes.',
        'Chauffez l\'huile dans une poêle profonde à feu moyen-vif.',
        'Faites frire les darnes de thon jusqu\'à ce qu\'elles soient bien dorées et croustillantes (environ 8-10 min).',
        'Pendant ce temps, réchauffez l\'attiéké à la vapeur pendant 5 minutes.',
        'Tranchez les oignons en rondelles fines et les tomates en quartiers.',
        'Arrosez l\'attiéké de jus de citron et mélangez délicatement.',
        'Disposez l\'attiéké dans les assiettes, ajoutez le thon frit par-dessus.',
        'Garnissez avec les oignons, tomates et piment. Servez chaud.',
      ],
    ),
    const Recipe(
      id: '2',
      title: 'Alloco',
      category: 'Entrée',
      description:
          'L\'Alloco est une spécialité ivoirienne à base de bananes plantains mûres frites dans l\'huile. Croustillant à l\'extérieur et fondant à l\'intérieur, il se déguste en accompagnement ou en street food.',
      imageEmoji: '🍌',
      imageUrl:
          'https://images.unsplash.com/photo-1571846304724-8dbba4fb5e28?auto=format&fit=crop&w=800&q=80',
      prepTimeMinutes: 10,
      cookTimeMinutes: 15,
      difficulty: 'Facile',
      rating: 4.6,
      servings: 2,
      ingredients: [
        '3 bananes plantains très mûres (peau noire)',
        'Huile de friture (750ml)',
        '1 piment rouge',
        '1 oignon moyen',
        'Sel fin',
        '1 tomate',
      ],
      steps: [
        'Épluchez les bananes plantains et coupez-les en rondelles diagonales d\'environ 1,5 cm.',
        'Salez légèrement les rondelles de banane.',
        'Chauffez l\'huile à 170°C dans une casserole ou une friteuse.',
        'Plongez les rondelles de banane par petites quantités pour éviter de faire baisser la température.',
        'Faites frire 5 à 7 minutes jusqu\'à obtenir une belle couleur dorée.',
        'Égouttez sur du papier absorbant.',
        'Préparez la sauce : mixez la tomate, l\'oignon et le piment avec une pincée de sel.',
        'Servez les allocos chauds avec la sauce tomate-piment.',
      ],
    ),
    const Recipe(
      id: '3',
      title: 'Kedjenou de Poulet',
      category: 'Plat Principal',
      description:
          'Le Kedjenou est un ragoût traditionnel ivoirien cuit à l\'étouffée dans une canari (poterie en terre cuite). La cuisson lente sans eau préserve tous les arômes et donne une viande incroyablement tendre.',
      imageEmoji: '🍗',
      imageUrl:
          'https://images.unsplash.com/photo-1604908176997-125f25cc6f3d?auto=format&fit=crop&w=800&q=80',
      prepTimeMinutes: 20,
      cookTimeMinutes: 60,
      difficulty: 'Intermédiaire',
      rating: 4.9,
      servings: 6,
      ingredients: [
        '1 poulet fermier entier coupé en morceaux',
        '3 tomates mûres',
        '2 oignons',
        '1 poivron vert',
        '3 gousses d\'ail',
        '1 morceau de gingembre frais',
        '2 feuilles de laurier',
        '1 cube Maggi',
        'Sel, poivre',
        '2 piments frais',
        'Thym frais',
      ],
      steps: [
        'Nettoyez et coupez le poulet en morceaux. Assaisonnez avec sel, poivre, ail écrasé et gingembre râpé.',
        'Laissez mariner au moins 30 minutes (idéalement toute une nuit).',
        'Dans une cocotte ou canari, disposez les morceaux de poulet sans ajouter d\'eau ni d\'huile.',
        'Ajoutez les tomates coupées, les oignons émincés, le poivron, le piment et les herbes.',
        'Couvrez hermétiquement avec un couvercle. Placez sur feu très doux.',
        'Secouez la cocotte toutes les 10-15 minutes sans soulever le couvercle.',
        'Faites cuire 60 minutes à feu doux. Le poulet cuit dans son propre jus.',
        'Vérifiez l\'assaisonnement. Servez avec de l\'attiéké ou du riz blanc.',
      ],
    ),
    const Recipe(
      id: '4',
      title: 'Sauce Graine',
      category: 'Sauce',
      description:
          'La Sauce Graine (ou Sauce Palmiste) est une sauce riche et onctueuse préparée à partir de noix de palme. C\'est l\'une des sauces les plus emblématiques de la cuisine ivoirienne, généralement accompagnée de riz ou d\'igname pilée.',
      imageEmoji: '🌴',
      imageUrl:
          'https://images.unsplash.com/photo-1585937421612-70a008356fbe?auto=format&fit=crop&w=800&q=80',
      prepTimeMinutes: 30,
      cookTimeMinutes: 90,
      difficulty: 'Difficile',
      rating: 4.7,
      servings: 8,
      ingredients: [
        '1kg de noix de palme fraîches',
        '1 poulet coupé en morceaux',
        '300g de bœuf',
        '2 oignons',
        '4 tomates',
        '3 gousses d\'ail',
        'Gingembre frais',
        '2 piments',
        'Feuilles de laurier',
        'Cube Maggi',
        'Sel et poivre',
        'Feuilles de gombo (okra) séchées',
      ],
      steps: [
        'Faites bouillir les noix de palme 20 minutes jusqu\'à ce qu\'elles ramollissent.',
        'Pilez les noix dans un mortier pour en extraire la pulpe. Filtrez en ajoutant de l\'eau chaude.',
        'Récupérez le jus de palme rouge obtenu. Réservez.',
        'Faites revenir les viandes avec oignon, ail et assaisonnements jusqu\'à coloration.',
        'Ajoutez les tomates concassées et laissez mijoter 10 minutes.',
        'Versez le jus de palme sur les viandes. Portez à ébullition.',
        'Ajoutez le piment, les feuilles de laurier et les feuilles de gombo séchées.',
        'Laissez mijoter 60-70 minutes à feu moyen jusqu\'à ce que la sauce épaississe.',
        'Rectifiez l\'assaisonnement. Servez bien chaud avec du riz blanc.',
      ],
    ),
    const Recipe(
      id: '5',
      title: 'Placali',
      category: 'Accompagnement',
      description:
          'Le Placali est une pâte de manioc fermenté, aliment de base en Côte d\'Ivoire. Sa texture lisse et sa légère acidité en font un accompagnement parfait pour les sauces ivoiriennes comme la sauce graine ou la sauce arachide.',
      imageEmoji: '🥣',
      imageUrl:
          'https://images.unsplash.com/photo-1574484284002-952d92456975?auto=format&fit=crop&w=800&q=80',
      prepTimeMinutes: 10,
      cookTimeMinutes: 20,
      difficulty: 'Intermédiaire',
      rating: 4.3,
      servings: 4,
      ingredients: [
        '500g de farine de manioc fermentée (wacrou)',
        '1 litre d\'eau',
        'Sel (optionnel)',
      ],
      steps: [
        'Délayez la farine de manioc fermentée dans un peu d\'eau froide pour former une pâte lisse sans grumeaux.',
        'Portez le reste de l\'eau à ébullition dans une grande casserole.',
        'Versez la pâte de manioc dans l\'eau bouillante en remuant constamment avec une cuillère en bois.',
        'Continuez de remuer vigoureusement pour éviter les grumeaux.',
        'Baissez le feu et continuez à travailler la pâte pendant 15 à 20 minutes.',
        'La pâte est prête quand elle se détache des parois et forme une boule homogène.',
        'Humidifiez vos mains et formez des boules de placali.',
        'Servez immédiatement avec votre sauce préférée (sauce graine, sauce arachide...).',
      ],
    ),
    const Recipe(
      id: '6',
      title: 'Attiéké Poisson Braisé',
      category: 'Plat Principal',
      description:
          'L\'Attiéké Poisson Braisé est LE plat de rue par excellence en Côte d\'Ivoire. Le poisson (brème, capitaine ou tilapia) est grillé au charbon et servi avec de l\'attiéké frais et une sauce tomate épicée.',
      imageEmoji: '🐠',
      imageUrl:
          'https://images.unsplash.com/photo-1559847844-5315695dadae?auto=format&fit=crop&w=800&q=80',
      prepTimeMinutes: 25,
      cookTimeMinutes: 30,
      difficulty: 'Intermédiaire',
      rating: 4.8,
      servings: 4,
      ingredients: [
        '2 poissons entiers (brème ou tilapia)',
        '600g d\'attiéké frais',
        '3 tomates',
        '2 oignons',
        '2 piments',
        '1 citron',
        'Ail (4 gousses)',
        'Gingembre',
        'Cube Maggi',
        'Sel et poivre',
        'Huile de palme',
        'Persil frais',
      ],
      steps: [
        'Nettoyez les poissons et faites des incisions profondes des deux côtés.',
        'Préparez la marinade : mixez ail, gingembre, piment, sel, poivre et cube Maggi.',
        'Badigeonnez généreusement les poissons de marinade, en faisant pénétrer dans les incisions.',
        'Laissez mariner 20 minutes minimum.',
        'Faites griller les poissons sur un barbecue ou au four (200°C) 15 min de chaque côté.',
        'Réchauffez l\'attiéké et arrosez-le de jus de citron.',
        'Préparez la sauce : faites revenir oignons et tomates dans l\'huile de palme avec les piments.',
        'Disposez l\'attiéké en base, le poisson braisé par-dessus, nappez de sauce et garnissez de persil.',
      ],
    ),
  ];

  /// Retourne toutes les recettes
  static List<Recipe> getAllRecipes() => List.unmodifiable(_recipes);

  /// Retourne une recette par son id
  static Recipe? getRecipeById(String id) {
    try {
      return _recipes.firstWhere((r) => r.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Retourne toutes les catégories uniques
  static List<String> getCategories() {
    final cats = _recipes.map((r) => r.category).toSet().toList();
    cats.sort();
    return cats;
  }

  /// Filtre les recettes par recherche et catégorie
  static List<Recipe> filterRecipes({
    String? query,
    String? category,
  }) {
    return _recipes.where((r) {
      final matchesQuery = query == null ||
          query.isEmpty ||
          r.title.toLowerCase().contains(query.toLowerCase()) ||
          r.description.toLowerCase().contains(query.toLowerCase());
      final matchesCategory =
          category == null || category.isEmpty || r.category == category;
      return matchesQuery && matchesCategory;
    }).toList();
  }

  /// Ajoute une recette (simulé en mémoire)
  static void addRecipe(Recipe recipe) {
    _recipes.add(recipe);
  }
}
