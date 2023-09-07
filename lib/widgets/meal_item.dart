import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart'; //for kTransparentImage

import '../models/meal.dart';
import 'meal_item_trait.dart';

class MealItem extends StatelessWidget {
  final Meal meal;
  final void Function(Meal meal) onSelectMeal;

  const MealItem({required this.onSelectMeal, required this.meal, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ), //it just won't set the shape, we have to cut the extra part using clipBehavious
      clipBehavior: Clip.hardEdge,
      //it will simply cut off the extra material

      child: InkWell(
        onTap: () {
          onSelectMeal(meal);
        },
        splashColor: Colors.purple,
        // borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Hero(
              tag: meal.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                height: 230,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 44),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow
                          .ellipsis, //will cut with lines with 3 dotes cause we have defined that max line should be 2.
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                            icon: Icons.schedule,
                            label: '${meal.duration} min'),
                        const SizedBox(
                          width: 12,
                        ),
                        MealItemTrait(
                            icon: Icons.bar_chart,
                            label:
                                '${meal.complexity.name[0].toUpperCase()}${meal.complexity.name.substring(1)}'),
                        const SizedBox(width: 12),
                        MealItemTrait(
                            icon: Icons.currency_rupee,
                            label:
                                '${meal.affordability.name[0].toUpperCase()}${meal.affordability.name.substring(1)}')
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
