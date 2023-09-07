import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/main_drawer.dart';
import 'categories.dart';
import 'meals.dart';
import 'filters.dart';
// import '../data/dummy_data.dart';//now doing with provider
// import '../providers/meal_provider.dart';
import '../providers/favourites_providers.dart';
import '../providers/filtes_provider.dart';

class TabsScreen extends ConsumerStatefulWidget
//ConsumerStatefulWidget is provided by flutter_riverpod package to listen and to change our provider value.
//if we had stateless widget then we would have use ConsumerWidget
{
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen>
//here we are using ConsumerState instead of normal "state" for providers
{
  int _selectedPageIndex = 0;
  // final List<Meal> _favouriteMeals = []; now doing with provider.

  // Map<Filter, bool> _selectedFilters = {
  //   Filter.glutenFree: false,
  //   Filter.lactoseFree: false,
  //   Filter.vegan: false,
  //   Filter.vegeterian: false,
  // };

  // void _toggleMealFavouriteStatus(Meal meal) {
  //   final isExisting = _favouriteMeals.contains(meal);
  //   if (isExisting) {
  //     setState(() {
  //       _favouriteMeals.remove(meal);
  //     });
  //     _showInfoMessege('Item is no longer a favourite!');
  //   } else {
  //     setState(() {
  //       _favouriteMeals.add(meal);
  //     });
  //     _showInfoMessege('Item is added to favourites!');
  //   }
  // }

  void _setScreen(String identifier) async {
    if (identifier == 'filters') {
      // final result = // now we're not getting any value - lect. 187
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) =>
              const FiltersScreen(), //(currentFilters: _selectedFilters),
        ),
      );
      // setState(() {
      //   _selectedFilters = result!;
      // });
    } else {
      Navigator.of(context).pop();
      //here we are just poping the page, becase we will already be on meals page so we just have to close the drawer.
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final tushar = ref.watch(mealsProvider); //we set it in provider.
    // //.watch() is recommmended instead of .read(), it waits.
    // //it is used to setup a listener as our data changes.
    // final activeFilters = ref.watch(filtersProvider);
    // final availableMeals = tushar.where(
    //   (meal) {
    //     if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
    //       return false;
    //     }
    //     if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
    //       return false;
    //     }
    //     if (activeFilters[Filter.vegeterian]! && !meal.isVegetarian) {
    //       return false;
    //     }
    //     if (activeFilters[Filter.vegan]! && !meal.isVegan) {
    //       return false;
    //     }
    //     return true;
    //   },
    // ).toList();
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activePage = CategoriesScreen(
      // ontoggleFavourites: _toggleMealFavouriteStatus,
      availableMeals: availableMeals,
    );
    dynamic activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final tusharFavouriteMeals = ref.watch(favouriteMealsProvider);
      activePage = MealsScreen(
        // ontoggleFavourites: _toggleMealFavouriteStatus,
        meals: tusharFavouriteMeals, //_favouriteMeals,
      );
      activePageTitle = 'Your Favourites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      drawer: MainDrawer(onSelectScreen: _setScreen),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favourites',
          ),
        ],
      ),
    );
  }
}
