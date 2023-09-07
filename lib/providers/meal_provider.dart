import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_recipe/data/dummy_data.dart';

//We are just providing the dummyMeals file by this provider which can be done by simple importing the file in the required file, but here we are doing it with the help of providers and we gonna do the with this "ref" property.
final mealsProvider = Provider((ref) {
  return dummyMeals;
});

//this basic "Provider()" is great if we have static data. if we have more dynamic data then we should use "StateNotifierProvider()" class, like in favourites_providers.dart

