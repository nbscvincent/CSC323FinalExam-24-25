import 'dart:convert';
import 'package:http/http.dart' as http; // Import the http package
import 'package:recipes/model/recipe.dart';

class RecipeRepository {
  final String _baseUrl = 'https://dummyjson.com/recipes';

  Future<List<Recipe>> fetchRecipes() async {
    try {
      // Make the GET request to fetch data
      final response = await http.get(Uri.parse(_baseUrl));

      // Log the response status and body for debugging
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      // Check if the status code is 200 (OK)
      if (response.statusCode == 200) {
        // Parse the JSON response and extract the 'recipes' list
        final data = jsonDecode(response.body);

        // Ensure the 'recipes' key exists in the response and is a list
        if (data['recipes'] != null && data['recipes'] is List) {
          // Map the list of recipes and convert them to Recipe objects
          final recipesList = (data['recipes'] as List)
              .map((recipeJson) => Recipe.fromJson(recipeJson))
              .toList();

          // Return the list of recipes
          return recipesList;
        } else {
          throw Exception('Invalid response format: "recipes" key not found.');
        }
      } else {
        throw Exception('Failed to load recipes: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any errors and print them for debugging
      print('Error: $e');
      throw Exception('Error occurred while fetching recipes: $e');
    }
  }
}
