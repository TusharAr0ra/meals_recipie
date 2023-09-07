import 'package:flutter/material.dart';

import 'package:meals_recipe/screens/meals.dart';
import '../widgets/category_grid_item.dart';
import '../data/dummy_data.dart';
import '../models/category.dart';
import '../models/meal.dart';

class CategoriesScreen extends StatefulWidget {
  // final void Function(Meal meal) ontoggleFavourites;
  final List<Meal> availableMeals;

  const CategoriesScreen(
      {super.key,
      // required this.ontoggleFavourites,
      required this.availableMeals});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    _animationController.forward();
    //to start the animation
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          // ontoggleFavourites: ontoggleFavourites,
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 8.0,
        ),
        children: [
          for (final i in availableCategories)
            CategoriesGridItem(
              category: i,
              onSelectCategory: () {
                _selectCategory(context, i);
              },
            ),
        ],
      ),
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.3),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
              parent: _animationController, curve: Curves.easeInOut),
        ),
        child: child,
      ),
    );
  }
}
