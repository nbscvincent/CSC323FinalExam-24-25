import 'package:flutter/material.dart';
import 'package:recipes/model/recipe.dart';

class RecipeDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Safely extract the recipe argument passed during navigation
    final recipe = ModalRoute.of(context)?.settings.arguments as Recipe?;

    // Handle the case where the recipe argument is not passed or is null
    if (recipe == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Recipe Details')),
        body: const Center(child: Text('No recipe data available')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(recipe.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Ingredients section
            Text('Ingredients:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 8),
            ...recipe.ingredients.map((ing) => Text('• $ing')).toList(),
            const SizedBox(height: 16),

            // Instructions section
            Text('Instructions:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 8),
            ...recipe.instructions.map((step) => Text('• $step')).toList(),
            const SizedBox(height: 16),

            // Recipe Details: Time, Servings, Cuisine, Difficulty
            Text('Prep Time: ${recipe.prepTimeMinutes} minutes',
                style: TextStyle(fontSize: 16)),
            Text('Cook Time: ${recipe.cookTimeMinutes} minutes',
                style: TextStyle(fontSize: 16)),
            Text('Servings: ${recipe.servings}',
                style: TextStyle(fontSize: 16)),
            Text('Cuisine: ${recipe.cuisine}', style: TextStyle(fontSize: 16)),
            Text('Difficulty: ${recipe.difficulty}',
                style: TextStyle(fontSize: 16)),
            const SizedBox(height: 16),

            // Recipe Image
            recipe.image.isNotEmpty
                ? Image.network(recipe.image)
                : const SizedBox.shrink(),
            const SizedBox(height: 16),

            // Rating and Review Count
            Text('Rating: ${recipe.rating} (${recipe.reviewCount} reviews)',
                style: TextStyle(fontSize: 16)),
            const SizedBox(height: 16),

            // Tags section
            Text('Tags: ${recipe.tags.join(', ')}',
                style: TextStyle(fontSize: 16)),
            const SizedBox(height: 16),

            // Meal Types section
            Text('Meal Types: ${recipe.mealType.join(', ')}',
                style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
