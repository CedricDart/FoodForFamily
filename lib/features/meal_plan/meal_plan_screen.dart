import 'package:flutter/material.dart';
import 'package:food_for_family/features/model/recipe.dart';
import 'package:food_for_family/features/presenter/recipeList.dart';
import 'package:food_for_family/features/presenter/recipeListItem.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:food_for_family/common/services/recipeService.dart';
import 'package:food_for_family/common/utils/locator.dart';
import 'package:food_for_family/features/meal_plan/meal_plan_service.dart';

class MealPlanScreen extends StatefulWidget {

  @override
  _MealPlanScreenState createState() => _MealPlanScreenState();
}

class _MealPlanScreenState extends State<MealPlanScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final RecipeService _recipeService = locator<RecipeService>(); // Get RecipeService
  final MealPlanService _mealPlanService = locator<MealPlanService>();
  Map<DateTime, Recipe> _meals = {};

  @override
  void initState() {
    super.initState();
    _loadMealPlans();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Plan Calendar'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                _selectDate(selectedDay, focusedDay);
              }
            },
            eventLoader: (day) {
              // Load events (recipes) for the day
              return _getEventsForDay(day);
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          if (_selectedDay != null)
            Expanded(
              child: _buildMealDetails(),
            ),
        ],
      ),
    );
  }

  List<dynamic> _getEventsForDay(DateTime day) {
    // Return a list of events (in this case, just a placeholder for the dot) for the given day.
    return _meals.containsKey(day) ? [ _meals[day]! ] : [];
  }

  Future<void> _loadMealPlans() async {
    final savedMeals = await _mealPlanService.loadMealPlans();
    setState(() {
      _meals = savedMeals;
    });
  }


  void _selectDate(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      // Keep focusedDay on the current month when selecting a day
      _focusedDay = DateTime(
        _focusedDay.year,
        _focusedDay.month,
        selectedDay.day,
      );
      // Ensure the selected day is within the currently displayed month
      if (_selectedDay!.month != _focusedDay.month) {
        _focusedDay = _selectedDay!;
      }
    });
    // Show recipe selection dialog or navigate to recipe list
    _showRecipeSelectionDialog(selectedDay);
  }

  void _showRecipeSelectionDialog(DateTime date) async {
    // Assuming you have a way to get a list of all recipes
    List<Recipe> allRecipes = await _recipeService.getRecipes(); // Replace with your actual method

    Recipe? selectedRecipe = await showDialog<Recipe>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select a Recipe for ${date.toLocal().toString().split(' ')[0]}'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: allRecipes.length,
              itemBuilder: (context, index) {
                return RecipeListItem(recipe: allRecipes[index], onTap: () => Navigator.of(context).pop(allRecipes[index]));
              },
            ),
          ),
        );
      },
    );

    if (selectedRecipe != null) {
      // Ensure date is a pure date without time for consistent mapping
      DateTime pureDate = DateTime(date.year, date.month, date.day);
      setState(() {
        _meals[pureDate] = selectedRecipe; // Associate recipe with date
      });
      _mealPlanService.saveMealPlan(_meals); // Save the updated meal plan
    } else if (_meals.containsKey(date) && selectedRecipe == null) {
      // If a recipe was previously planned and the dialog was dismissed without selecting a new recipe, remove it
      _removeMeal(date);
    }
  }

  void _removeMeal(DateTime date) {
    // Ensure date is a pure date without time for consistent mapping
    DateTime pureDate = DateTime(date.year, date.month, date.day);
      setState(() {
        _meals.remove(pureDate);
      });
    }
  }

  Widget _buildMealDetails() {
    if (_selectedDay != null && _meals.containsKey(_selectedDay)) {
      Recipe recipe = _meals[_selectedDay]!;
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Meal for ${_selectedDay!.toLocal().toString().split(' ')[0]}:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              recipe.name,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () => _removeMeal(_selectedDay!),
              child: Text('Remove Meal'),
            ),
            // You can add more details about the recipe here
          ],
        ),
      );
    } else if (_selectedDay != null) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'No meal planned for ${_selectedDay!.toLocal().toString().split(' ')[0]}. Tap a recipe above to add one.',
          style: TextStyle(fontSize: 16),
        ),
      );
    } else {
      return Container(); // Should not happen if _selectedDay is not null
    }
  }
}