import 'package:flutter/material.dart';
import 'package:food_for_family/features/camera/cameraScreen.dart';
import 'package:food_for_family/features/detail/addEdit/recipeForm.dart';
import 'package:food_for_family/features/home/home_viewmodel.dart';
import 'package:food_for_family/features/model/recipe.dart';
import 'package:food_for_family/features/presenter/listRecipeScreen.dart';
import 'package:food_for_family/features/presenter/recipeshortscreen.dart';
import 'package:stacked/stacked.dart';

class HomeScreenArguments {
  List<Recipe> recipes;

  HomeScreenArguments(this.recipes);
}

class HomeScreen extends StatefulWidget {
  final HomeScreenArguments arguments;

  const HomeScreen({Key? key, required this.arguments}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var allScreens = [];

  int _activeScreen = 1;

  void _onItemTapped(int index) {
    setState(() {
      _activeScreen = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onViewModelReady: (viewModel) {
        allScreens.addAll([
          ListRecipeScreen(recipes: widget.arguments.recipes),
          RecipeShortsScreen(recipes: widget.arguments.recipes),
          RecipeForm(),
        ]);
        viewModel.onOpenMenu.listen((event) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return CameraScreen();
          }));
        });
      },
      builder: (context, model, child) {
        return Scaffold(
            body: SafeArea(
              child: Stack(fit: StackFit.expand, children: [
                allScreens[_activeScreen],
                //Container(color: AppColors.neutralLight),
                // Opens list view on top of map view
              ]),
            ),
            /*floatingActionButton: FloatingActionButton(
              onPressed: model.openMenu,
              backgroundColor: Colors.transparent,
              shape: SunShape(),
              child: const Icon(Icons.camera_alt),
            ),*/
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.black,
              currentIndex: _activeScreen,
              selectedItemColor: Colors.red,
              unselectedItemColor: Colors.white60,
              showUnselectedLabels: true,
              onTap: _onItemTapped,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  label: 'Recepten',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.view_agenda),
                  label: 'view',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  label: 'add',
                ),
              ],
            ));
      },
    );
  }
}
