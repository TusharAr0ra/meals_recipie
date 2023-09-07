import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/meal.dart';

class FavouriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavouriteMealsNotifier() : super([]); //constructor to call super
  // FavouriteMealsNotifier(super._state); this format is also acceptable.

  toggleMealFavouriteStatus(Meal meal) {
    final mealIsFavourite = state.contains(meal);
    if (mealIsFavourite) {
      state = state.where((t) => t.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      //'...' it is uses on a list to pull out all the existing data in that list and add the other "meal" in it seperated by the "," here.
      return true;
    }
  }
}

final favouriteMealsProvider =
    StateNotifierProvider<FavouriteMealsNotifier, List<Meal>>((ref) {
  return FavouriteMealsNotifier();
});
