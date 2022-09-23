abstract class ShopStates {}
class ShopLoginInistialState extends ShopStates {}

class ShopLoginLoadingState extends ShopStates {}

class ShopLoginSuccessfulState extends ShopStates {

}
class ShopLoginfailedState extends ShopStates {}
class ShopLoginErrorState extends ShopStates {
  final String error ;

  ShopLoginErrorState(this.error);
}
class ShopLoginPasswordState extends ShopStates {}
class ShopBottomNavState extends ShopStates {}

class ShopHomeLoadingState extends ShopStates {}

class ShopHomeSuccessfulState extends ShopStates {

}
class ShopHomefailedState extends ShopStates
{
}

class ShopCategoriesLoadingState extends ShopStates {}

class ShopCategoriesSuccessfulState extends ShopStates {

}
class ShopCategoriesfailedState extends ShopStates
{
}
class ShopGetUserLoadingState extends ShopStates {}

class ShopGetUSerSuccessfulState extends ShopStates {

}
class ShopGetUserFailedState extends ShopStates
{
}

class ChangeFavouritesState extends ShopStates
{
}
class ChangeFavouritesStateError extends ShopStates
{
}


class ShopFavoritesLoadingState extends ShopStates {}

class ShopFavoritesSuccessfulState extends ShopStates {

}
class ShopFavoritesFailedState extends ShopStates
{
}