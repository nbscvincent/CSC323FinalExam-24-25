import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes/core/features/Recipes/view%20model/recipe_View_Model.dart';
import 'package:recipes/UI/recipe_detail_screen.dart';

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({super.key});

  @override
  RecipeListScreenState createState() => RecipeListScreenState();
}

class RecipeListScreenState extends State<RecipeListScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RecipeViewModel()..loadRecipes(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Recipes'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(56.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (query) {
                  setState(() {
                    _searchQuery = query.toLowerCase();
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Search recipes...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
        ),
        body: Consumer<RecipeViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (viewModel.hasError) {
              return const Center(child: Text('Failed to load recipes.'));
            } else if (viewModel.recipes.isEmpty) {
              return const Center(child: Text('No recipes available.'));
            } else {
              // Filter recipes by search query
              final filteredRecipes = viewModel.recipes.where((recipe) {
                return recipe.title.toLowerCase().contains(_searchQuery);
              }).toList();

              return ListView.builder(
                itemCount: filteredRecipes.length,
                itemBuilder: (context, index) {
                  final recipe = filteredRecipes[index];
                  return ListTile(
                    title: Text(recipe.title),
                    subtitle: Text(recipe.ingredients.take(2).join(', ')),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeDetailScreen(recipe: recipe),
                        ),
                      );
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
