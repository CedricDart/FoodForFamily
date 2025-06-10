import 'package:food_for_family/common/viewmodels/base_viewmodel.dart';
import 'package:food_for_family/features/model/recipe.dart';

class ListRecipeViewModel extends BaseViewModel {
  List<Recipe> recipes = [];

  ListRecipeViewModel({List<Recipe> recipesList = const []}) {
    recipes = recipesList;
  }

  Future<void> getRecipes() async {
    setLoading(true);
    recipes = await recipeService.listRecipes();
    setLoading(false);
  }
}
