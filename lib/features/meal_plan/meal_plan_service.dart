import 'package:food_for_family/features/model/recipe.dart';

class MealPlanService {
  // In-memory storage for meal plans
  final Map<DateTime, Recipe> _mealPlans = {};

  /// Saves a meal plan entry.
  void saveMealPlan(DateTime date, Recipe recipe) {
    // For simplicity, storing in-memory.
    // In a real app, this would interact with persistent storage (e.g., SharedPreferences, database, etc.)
    _mealPlans[date] = recipe;
    print('Meal plan saved for ${date.toLocal().toString().split(' ')[0]}: ${recipe.name}');
  }

  /// Loads the meal plan for a specific date.
  Recipe? loadMealPlan(DateTime date) {
    // For simplicity, loading from in-memory.
    return _mealPlans[date];
  }

  /// Loads all meal plans.
  Map<DateTime, Recipe> loadMealPlans() {
    return Map.from(_mealPlans);

  }

  /// Removes the meal plan for a specific date.
  void removeMealPlan(DateTime date) {
    _mealPlans.remove(date);
    print('Meal plan removed for ${date.toLocal().toString().split(' ')[0]}');
  }
}