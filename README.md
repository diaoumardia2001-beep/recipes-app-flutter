# 🇨🇮 Cuisine Ivoirienne — Application Flutter

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart&logoColor=white)
![go_router](https://img.shields.io/badge/go__router-18.0.1-4CAF50)
![License](https://img.shields.io/badge/License-MIT-green)
![Status](https://img.shields.io/badge/Status-Production%20Ready-brightgreen)

> Application Flutter multi-écrans dédiée aux **recettes de cuisine ivoirienne authentiques** — Garba, Alloco, Kedjenou, Sauce Graine, Placali, Attiéké Poisson Braisé.

---

## 📸 Captures d'écran

| Accueil | Détail | Ajouter | Réglages |
|---------|--------|---------|----------|
| ![Accueil](screenshots/home.png) | ![Détail](screenshots/detail.png) | ![Ajouter](screenshots/add.png) | ![Réglages](screenshots/settings.png) |

---

## 🚀 Lancement

```bash
# Installer les dépendances
flutter pub get

# Lancer l'application
flutter run

# Lancer sur un appareil spécifique
flutter run -d android
flutter run -d ios
flutter run -d windows
flutter run -d chrome
```

---

## 🗂️ Architecture

```
lib/
├── main.dart                        # Point d'entrée + GoRouter + ThemeNotifier
├── models/
│   └── recipe.dart                  # Classe Recipe (12 champs)
├── data/
│   └── recipes_data.dart            # Repository statique avec 6 recettes
├── theme/
│   ├── app_theme.dart               # Thèmes Material 3 clair & sombre
│   └── theme_notifier.dart          # ChangeNotifier pour toggle thème
├── screens/
│   ├── app_shell.dart               # Shell avec NavigationBar persistante
│   ├── home_screen.dart             # Accueil : grille/liste + recherche
│   ├── recipe_detail_screen.dart    # Détail recette + Hero animation
│   ├── add_recipe_screen.dart       # Formulaire ajout avec validation
│   └── settings_screen.dart        # Réglages + toggle thème clair/sombre
└── widgets/
    ├── app_logo.dart               # Logo personnalisé gradient ivoirien
    ├── recipe_card.dart            # Card réutilisable (grille & liste)
    ├── search_filter_bar.dart      # Barre recherche + ChoiceChips
    └── custom_empty_state.dart     # État vide avec emoji + bouton
```

---

## 🗺️ Navigation (go_router — Routes nommées)

| Route | Nom | Écran |
|-------|-----|-------|
| `/` | `home` | HomeScreen |
| `/recipe/:id` | `recipe_detail` | RecipeDetailScreen |
| `/add` | `add_recipe` | AddRecipeScreen |
| `/settings` | `settings` | SettingsScreen |

Toute navigation utilise `context.goNamed()` ou `context.pushNamed()`.

---

## 🍽️ Recettes incluses

| # | Recette | Catégorie | Difficulté |
|---|---------|-----------|------------|
| 1 | 🐟 Garba | Plat Principal | Facile |
| 2 | 🍌 Alloco | Entrée | Facile |
| 3 | 🍗 Kedjenou de Poulet | Plat Principal | Intermédiaire |
| 4 | 🌴 Sauce Graine | Sauce | Difficile |
| 5 | 🥣 Placali | Accompagnement | Intermédiaire |
| 6 | 🐠 Attiéké Poisson Braisé | Plat Principal | Intermédiaire |

---

## ✅ Exigences techniques respectées

### Widgets Flutter (≥ 8 obligatoires — 14 utilisés)

- `ListView` — vue liste recettes + formulaire
- `GridView` — vue grille responsive
- `Card` — RecipeCard (grille & liste)
- `Stack` — overlay gradient sur images
- `Chip` / `ChoiceChip` — filtres catégories
- `TextFormField` — champs de formulaire validés
- `NavigationBar` — navigation persistante
- `AppBar` / `SliverAppBar` — en-têtes
- `Switch` — toggle thème sombre
- `DropdownButtonFormField` — sélection catégorie
- `Hero` — animation de transition
- `FloatingActionButton` — bouton ajout
- `AlertDialog` — confirmation
- `CircularProgressIndicator` — chargement

### 3 Widgets réutilisables dans `lib/widgets/`

- `RecipeCard` — carte recette (mode grille ET liste)
- `SearchFilterBar` — barre recherche + filtres catégories
- `CustomEmptyState` — état vide paramétrable

### Séparation UI / Données

- `lib/models/recipe.dart` — modèle de données pur
- `lib/data/recipes_data.dart` — repository avec méthodes de filtrage
- Aucune donnée codée en dur dans les widgets

### Responsive Design

```
< 600px   → 2 colonnes  (smartphone)
600–900px → 3 colonnes  (tablette)
> 900px   → 4 colonnes  (desktop)
```

### Formulaire avec validation complète

- `Form` + `GlobalKey<FormState>`
- `autovalidateMode: AutovalidateMode.onUserInteraction`
- Validators sur : Titre · Description · Temps de préparation · Cuisson · Portions
- `ElevatedButton` déclenche `_formKey.currentState!.validate()`

### Thème clair / sombre

- `ThemeMode` géré via `ThemeNotifier` (ChangeNotifier)
- Persistant pendant la session
- Togglable depuis SettingsScreen

---

## 📦 Dépendances

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  go_router: ^18.0.1
```

---

## 🔍 Analyse statique

```bash
flutter analyze
# → No issues found!
```

---

## 👨‍💻 Auteur

Développé avec ❤️ pour la certification Flutter — [diaoumardia2001-beep](https://github.com/diaoumardia2001-beep)
