import 'package:flutter/material.dart';
import 'package:recipes/repositories/repository.dart';
import 'package:recipes/model/recipe.dart';

class RecipeViewModel extends ChangeNotifier {
  final RecipeRepository _repository;

  RecipeViewModel(this._repository);

  List<Recipe> _recipes = [];
  List<Recipe> get recipes => _recipes;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _hasError = false;
  bool get hasError => _hasError;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<void> loadRecipes() async {
    _isLoading = true;
    _hasError = false;
    _errorMessage = ''; // Reset any previous error messages
    notifyListeners(); // Notify listeners that loading state has changed

    try {
      final fetchedRecipes = await _repository.fetchRecipes();
      _recipes = fetchedRecipes; // Assign the fetched recipes to _recipes
    } catch (e) {
      _hasError = true;
      _errorMessage = 'Error loading recipes: $e';
      print('Error loading recipes: $e'); // Optionally, log the error
    } finally {
      _isLoading = false;
      notifyListeners(); // Notify listeners again to update UI
    }
  }
}
