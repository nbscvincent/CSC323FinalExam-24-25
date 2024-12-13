import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes/Viewmodel/view_model.dart';
import 'package:recipes/model/recipe.dart';

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({Key? key}) : super(key: key);

  @override
  _RecipeListScreenState createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 3, vsync: this); // Three tabs (e.g., All, Popular, Vegetarian)
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RecipeViewModel>(context);

    if (viewModel.recipes.isEmpty && !viewModel.isLoading) {
      viewModel.loadRecipes();
    }

    // Filter recipes based on tab selection
    final filteredRecipes = _getFilteredRecipes(viewModel);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe List'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Popular'),
            Tab(text: 'Vegetarian'),
            // Add more tabs as needed
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildRecipeList(filteredRecipes),
          _buildRecipeList(viewModel.recipes
              .where((r) => r.rating > 4)
              .toList()), // Example filter
          _buildRecipeList(viewModel.recipes
              .where((r) => r.tags.contains('Vegetarian'))
              .toList()),
          // Add more filters based on tab
        ],
      ),
    );
  }

  // Function to build the recipe list
  Widget _buildRecipeList(List<Recipe> recipes) {
    return Center(
      child: recipes.isEmpty
          ? const CircularProgressIndicator()
          : ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                return ListTile(
                  title: Text(recipe.name),
                  subtitle: Text(
                    recipe.ingredients.isNotEmpty
                        ? recipe.ingredients.take(2).join(', ')
                        : 'No ingredients available',
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/details',
                      arguments: recipe,
                    );
                  },
                );
              },
            ),
    );
  }

  // Function to get filtered recipes based on the selected tab
  List<Recipe> _getFilteredRecipes(RecipeViewModel viewModel) {
    switch (_tabController.index) {
      case 0:
        return viewModel.recipes; // All recipes
      case 1:
        return viewModel.recipes
            .where((r) => r.rating > 4)
            .toList(); // Popular recipes
      case 2:
        return viewModel.recipes
            .where((r) => r.tags.contains('Vegetarian'))
            .toList(); // Vegetarian
      default:
        return viewModel.recipes;
    }
  }
}
