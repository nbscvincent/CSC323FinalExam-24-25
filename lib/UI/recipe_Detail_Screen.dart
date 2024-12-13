import 'package:flutter/material.dart';
import 'package:recipes/core/features/Recipes/Repository/recipe_API.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              if (recipe.image.isNotEmpty)
                Image.network(recipe.image),
              
              // Ingredients
              const Text(
                'Ingredients:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...recipe.ingredients.map((ingredient) => Text('- $ingredient')),
              
              const SizedBox(height: 16),
              // Instructions
              const Text(
                'Instructions:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...recipe.instructions.map((step) => Text('${recipe.instructions.indexOf(step) + 1}. $step')),
              
              const SizedBox(height: 16),
              // Additional details
              Text('Prep time: ${recipe.prepTimeMinutes} minutes'),
              Text('Cook time: ${recipe.cookTimeMinutes} minutes'),
            ],
          ),
        ),
      ),
    );
  }
}
