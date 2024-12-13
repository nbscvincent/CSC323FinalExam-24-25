import 'package:flutter/foundation.dart';
import 'package:recipes/core/features/Recipes/Repository/Recipe_Repository.dart';
import 'package:recipes/core/features/Recipes/Repository/recipe_API.dart';


class RecipeViewModel extends ChangeNotifier {
  final RecipeRepository _repository = RecipeRepository();

  bool isLoading = false;
  bool hasError = false;
  List<Recipe> recipes = [];

  Future<void> loadRecipes() async {
    isLoading = true;
    hasError = false;
    notifyListeners();

    try {
      recipes = await _repository.fetchRecipes();
    } catch (error) {
      hasError = true;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
