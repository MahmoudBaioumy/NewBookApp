import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/helper/dialogs/exit_dialog.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';
import 'package:flustra_template/modules/cart/views/cart/cart_screen.dart';
import 'package:flustra_template/modules/products/views/books_list/books_list_screen.dart';
import 'package:flustra_template/modules/products/views/products_home/products_home.dart';
import 'package:flustra_template/modules/products/views/wishlist/wishlist_screen.dart';
import 'package:flustra_template/modules/profile/views/profile/profile_screen.dart';
import 'package:flutter/material.dart';

import '../../widgets/nav_bar_icon_widget.dart';
import 'home_navigation_bar.dart';

/// HomeNavigationBarController manages the bottom navigation bar active tab state and pages list.
class HomeNavigationBarController extends ChangeNotifier {
  // ========================== Constructor ========================== //
  HomeNavigationBarController._();

  static final HomeNavigationBarController i = HomeNavigationBarController._();

  // ========================== 🗝️ Public variables 🗝️ ========================== //
  MainScreenPageType selectedPageType = MainScreenPageType.home;

  MainScreenPageType get defaultPageType =>
      _pages.keys.firstOrNull ?? MainScreenPageType.home;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Widget get selectedPage =>
      _pages[selectedPageType]?.screen ??
      _pages.values.firstOrNull?.screen ??
      const SizedBox.shrink();

  List<Widget> get navBarItems =>
      _pages.values.map((e) => e.buttonIcon).toList();

  // --------------------------[ _pages ]-------------------------- //
  Map<MainScreenPageType, NavBarItemModel> get _pages => {
    MainScreenPageType.home: _homePage(),
    MainScreenPageType.books: _booksPage(),
    MainScreenPageType.favorites: _favoritesPage(),
    MainScreenPageType.cart: _cartPage(),
    MainScreenPageType.profile: _profilePage(),
  };

  // ========================== 🔥 initialization 🔥 ========================== //
  void init() {}

  // ========================== 🌍 Public methods and events 🌍 ========================== //
  // --------------------------[ onItemTapped ]-------------------------- //
  void onItemTapped(MainScreenPageType type) {
    if (selectedPageType == type) return;
    selectedPageType = type;
    notifyListeners();
  }

  // --------------------------[ handleBackButton ]-------------------------- //
  void handleBackButton(BuildContext context) {
    final firstPageType = _pages.keys.firstOrNull ?? MainScreenPageType.home;
    if (selectedPageType != firstPageType) {
      onItemTapped(firstPageType);
      return;
    }
    showExitConfirmationDialog();
  }

  // ========================== 🔒 Private methods 🔒 ========================== //
  // --------------------------[ _homePage ]-------------------------- //
  NavBarItemModel _homePage() => NavBarItemModel(
    screen: const ProductsHomeScreen(),
    buttonIcon: NavBarIconWidget(
      isSelected: selectedPageType == MainScreenPageType.home,
      onTap: () => onItemTapped(MainScreenPageType.home),
      icon: Icons.home_rounded,
      label: () => AppStrings.home.tx(),
    ),
  );

  // --------------------------[ _booksPage ]-------------------------- //
  NavBarItemModel _booksPage() => NavBarItemModel(
    screen: const BooksListScreen(),
    buttonIcon: NavBarIconWidget(
      isSelected: selectedPageType == MainScreenPageType.books,
      onTap: () => onItemTapped(MainScreenPageType.books),
      icon: Icons.book_rounded,
      label: () => AppStrings.books.tx(),
    ),
  );

  // --------------------------[ _favoritesPage ]-------------------------- //
  NavBarItemModel _favoritesPage() => NavBarItemModel(
    screen: const WishlistScreen(),
    buttonIcon: NavBarIconWidget(
      isSelected: selectedPageType == MainScreenPageType.favorites,
      onTap: () => onItemTapped(MainScreenPageType.favorites),
      icon: Icons.favorite_border_rounded,
      label: () => AppStrings.favorites.tx(),
    ),
  );

  // --------------------------[ _cartPage ]-------------------------- //
  NavBarItemModel _cartPage() => NavBarItemModel(
    screen: const CartScreen(),
    buttonIcon: NavBarIconWidget(
      isSelected: selectedPageType == MainScreenPageType.cart,
      onTap: () => onItemTapped(MainScreenPageType.cart),
      icon: Icons.shopping_cart_outlined,
      label: () => AppStrings.cart.tx(),
    ),
  );

  // --------------------------[ _profilePage ]-------------------------- //
  NavBarItemModel _profilePage() => NavBarItemModel(
    screen: const ProfileScreen(),
    buttonIcon: NavBarIconWidget(
      isSelected: selectedPageType == MainScreenPageType.profile,
      onTap: () => onItemTapped(MainScreenPageType.profile),
      icon: Icons.person_rounded,
      label: () => AppStrings.profile.tx(),
    ),
  );
}

class NavBarItemModel {
  final Widget screen;
  final Widget buttonIcon;

  NavBarItemModel({required this.screen, required this.buttonIcon});
}
