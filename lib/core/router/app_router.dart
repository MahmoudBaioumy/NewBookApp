import 'package:bot_toast/bot_toast.dart';
import 'package:flustra_template/core/localization/locale_watcher.dart';
import 'package:flustra_template/core/services/console_printer.dart';
import 'package:flustra_template/main.dart';
import 'package:flustra_template/modules/auth/login/login_screen.dart';
import 'package:flustra_template/modules/auth/register/register_screen.dart';
import 'package:flustra_template/modules/cart/views/cart/cart_screen.dart';
import 'package:flustra_template/modules/cart/views/checkout/checkout_screen.dart';
import 'package:flustra_template/modules/debug_helper/views/peoxy/proxy_view.dart';
import 'package:flustra_template/modules/debug_helper/views/theme_showcase_screen.dart';
import 'package:flustra_template/modules/home_with_navigation_bar/views/home_navigation_bar/home_navigation_bar.dart';
import 'package:flustra_template/modules/products/views/book_details/book_details_controller.dart';
import 'package:flustra_template/modules/products/views/book_details/book_details_screen.dart';
import 'package:flustra_template/modules/products/views/books_list/books_list_controller.dart';
import 'package:flustra_template/modules/products/views/books_list/books_list_screen.dart';
import 'package:flustra_template/modules/products/views/wishlist/wishlist_screen.dart';
import 'package:flustra_template/modules/profile/views/profile/profile_screen.dart';
import 'package:flustra_template/modules/settings/views/language_selection/language_selection_screen.dart';
import 'package:flustra_template/modules/settings/views/settings/settings_screen.dart';
import 'package:flustra_template/modules/splash/views/onboarding/onbearding_screen.dart';
import 'package:flustra_template/modules/splash/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'not_found_screen.dart';

// ========================== 🔥 Routers 🔥 ==========================

abstract class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String onboarding = '/onboarding';
  static const String homeScreenWithNavigationBar = '/homeScreenWithNavigationBar';
  static const String themeShowcaseScreen = '/ThemeShowcaseScreen';
  static const String proxyView = '/ProxyView';
  static const String languageSelectionScreen = '/LanguageSelectionScreen';
  static const String settingsScreen = '/SettingsScreen';
  static const String booksListScreen = '/BooksListScreen';
  static const String bookDetailsScreen = '/BookDetailsScreen';
  static const String wishlistScreen = '/WishlistScreen';
  static const String cartScreen = '/CartScreen';
  static const String checkoutScreen = '/CheckoutScreen';
  static const String profileScreen = '/ProfileScreen';
}

// ========================== 🔥 routerConfig 🔥 ==========================

final GoRouter routerConfig = GoRouter(
  navigatorKey: navigatorKey,
  observers: [BotToastNavigatorObserver()],
  initialLocation: AppRoutes.splash,
  errorBuilder: (context, state) => NotFoundScreen(homeRoute: AppRoutes.home),
  routes: _buildRoutes(),
);

// ========================== 🔥 _buildRoutes 🔥 ==========================

/// Build and return all application routes
List<RouteBase> _buildRoutes() {
  return [
    _baseGoRoute(AppRoutes.login, (_) => const LoginScreen()),
    _baseGoRoute(AppRoutes.register, (_) => const RegisterScreen()),
    _baseGoRoute(AppRoutes.splash, (_) => SplashScreen()),
    _baseGoRoute(AppRoutes.onboarding, (_) => OnboardingScreen()),
    _baseGoRoute(AppRoutes.themeShowcaseScreen, (_) => ThemeShowcaseScreen()),
    _baseGoRoute<HomeScreenWithNavigationBarData>(AppRoutes.homeScreenWithNavigationBar, (data) => HomeScreenWithNavigationBar(data: data)),
    _baseGoRoute(AppRoutes.proxyView, (_) => ProxyView()),
    _baseGoRoute(AppRoutes.languageSelectionScreen, (_) => const LanguageSelectionScreen()),
    _baseGoRoute(AppRoutes.settingsScreen, (_) => const SettingsScreen()),
    _baseGoRoute<BooksListScreenArgs>(AppRoutes.booksListScreen, (data) => BooksListScreen(args: data)),
    _baseGoRoute<BookDetailsScreenArgs>(AppRoutes.bookDetailsScreen, (data) => BookDetailsScreen(args: data)),
    _baseGoRoute(AppRoutes.wishlistScreen, (_) => const WishlistScreen()),
    _baseGoRoute(AppRoutes.cartScreen, (_) => const CartScreen()),
    _baseGoRoute(AppRoutes.checkoutScreen, (_) => const CheckoutScreen()),
    _baseGoRoute(AppRoutes.profileScreen, (_) => const ProfileScreen()),
  ];
}

// ========================== 🔥 base GoRoute 🔥 ==========================
GoRoute _baseGoRoute<T>(String path, Widget Function(T? data) screen) {
  // if first char in path not "/" add it
  if (path.isNotEmpty && path[0] != '/') path = '/$path';

  return GoRoute(
    path: path,
    name: path,
    builder: (context, state) => LocaleWatcher(child: () => screen(getTheObjectOrNull(state.extra))),
  );
}

// -------------------------- getTheObjectOrNull --------------------------

T? getTheObjectOrNull<T>(Object? extra) {
  "extra : $extra type ${extra.runtimeType}".printWithColor();

  if (extra == null || extra is! T) return null;
  "2".printWithColor();
  return extra as T;
}
