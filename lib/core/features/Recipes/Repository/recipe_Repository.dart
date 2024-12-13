import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipes/core/features/Recipes/Repository/recipe_API.dart';

class RecipeRepository {
  final String apiUrl = "https://dummyjson.com/recipes";

  Future<List<Recipe>> fetchRecipes() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        print('API Response: $jsonData'); // Debugging

        final List<dynamic> recipesJson = jsonData['recipes'] ?? [];
        return recipesJson.map((data) => Recipe.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load recipes: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error'); // Debugging
      throw Exception('Error fetching recipes: $error');
    }
  }

  getRecipes() {}
}
