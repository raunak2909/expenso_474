import 'package:expenso_474/data/models/cat_model.dart';

class AppConstants{

  static const String PREF_USER_KEY = "user_id";

  static final List<CatModel> mCat = [
    CatModel(id: 1, title: "Restaurant", imgPath: "assets/cat_icons/restaurant.png"),
    CatModel(id: 2, title: "Movie", imgPath: "assets/cat_icons/popcorn.png"),
    CatModel(id: 3, title: "Shopping", imgPath: "assets/cat_icons/hawaiian-shirt.png"),
    CatModel(id: 4, title: "Snacks", imgPath: "assets/cat_icons/snack.png"),
    CatModel(id: 5, title: "Petrol", imgPath: "assets/cat_icons/vehicles.png"),
    CatModel(id: 6, title: "Travel", imgPath: "assets/cat_icons/travel.png"),
    CatModel(id: 7, title: "Coffee", imgPath: "assets/cat_icons/coffee.png"),
  ];


}