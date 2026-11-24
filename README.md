# 📚 Ketaby — Book Store App

A modern, full-featured **Flutter Book Store** application built with **Clean Architecture**, **Cubit (BLoC)** state management, **ViewModel-Cubit** separation, **Multi-Language Localization** (English, Arabic with full RTL, and German), and **Light / Dark Theme** support.

<p>
  <a href="https://flutter.dev/">
    <img src="https://img.shields.io/badge/Made%20with-Flutter-02569B?style=flat&logo=flutter" alt="Made with Flutter" />
  </a>
  <img src="https://img.shields.io/badge/State%20Management-Cubit%20(BLoC)-0891B2?style=flat" alt="Cubit State Management" />
  <img src="https://img.shields.io/badge/Architecture-ViewModel--Cubit-0E7490?style=flat" alt="ViewModel-Cubit Architecture" />
  <img src="https://img.shields.io/badge/Localization-EN%20%7C%20AR%20%7C%20DE-84CC16?style=flat" alt="Localization EN AR DE" />
</p>

---

### Splash Screen

A custom animated book splash screen with smooth flipping pages, pulsing brand glow rings, timed auto-navigation, and instant tap-to-skip support.

<img src="screenshots/splash.gif" width="320" alt="Animated Splash Screen" />

---

### Book Details

This screen provides complete information about any selected book — including full cover artwork, title, category, original and discounted prices, detailed description, instant favorite toggling, and a prominent **Add To Cart** action.

<img src="screenshots/book_details_mockup.png" width="560" alt="Book Details Mockup" />

---

### Favorites

A dedicated **Wishlist** feature that lets you bookmark your favorite books with optimistic instant UI feedback and add them directly to your shopping cart whenever you're ready to buy.

<img src="screenshots/wishlist.png" width="320" alt="Favorites Screen" />

---

### Onboarding Screens

A smooth, multi-step onboarding walkthrough introducing new users to the app experience before signing in or creating an account.

<img src="screenshots/onboarding_banner.png" width="100%" alt="Onboarding Screens Banner" />

---

### Home

A dynamic **Book Store Home** screen featuring a personalized greeting header with user avatar, top featured carousel slider, **Best Seller** horizontal book cards with discount badges, promotional offer slider, **Categories**, and **New Arrivals** — all backed by live REST APIs and matching shimmer loading skeletons.

<img src="screenshots/home.png" width="320" alt="Home Screen" />

---

### Books Catalog

Browse the complete catalog of books with smooth staggered entrance animations, search filtering, discount tags, strikethrough pricing, quick favorite toggle, and one-tap **Add to Cart**.

<img src="screenshots/books.png" width="320" alt="Books Catalog Screen" />

---

### Shopping Cart & Checkout

Manage your selected books with interactive quantity controls (`+` / `-`), item removal, live total price calculation, pre-filled delivery details, an itemized **Order Summary**, and seamless one-tap **Order Now** checkout.

<p>
  <img src="screenshots/cart.png" width="300" alt="Shopping Cart Screen" />
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="screenshots/checkout.png" width="300" alt="Checkout Screen" />
</p>

---

### Profile & Settings

A branded curved-header **Profile** screen displaying user details (`Name`, `Email`, `Phone`, `City`, `Address`), instant profile editing, quick **Language (EN / AR / DE)** and **Light / Dark Theme** switching, and secure session logout.

<img src="screenshots/profile.png" width="320" alt="Profile Screen" />

---

### Screenshots

<img src="screenshots/screenshots_collage.png" width="100%" alt="Ketaby App Screenshots Collage" />

<br />

<img src="screenshots/auth_flow_showcase.png" width="100%" alt="Splash, Authentication and Profile Flow" />

---

## ✨ Key Features

- **Animated Splash & Onboarding** — Custom animated book splash screen with tap-to-skip and smart routing based on onboarding and session state.
- **Full Authentication Flow** — Login, Register, input validation, persistent session caching, and server-side logout.
- **Dynamic Home Feed** — Live sliders, Best Sellers, Promo Banners, Categories, and New Arrivals with shimmer placeholders and error retry.
- **Books Catalog & Details** — Searchable book list, staggered animations, discount badges, and rich book details view.
- **Wishlist & Cart** — Optimistic wishlist toggling, cart quantity steppers bounded by stock, and live order total calculation.
- **Complete Checkout** — Pre-filled customer delivery information, itemized order summary, and live order placement.
- **Profile, Multi-Language & Theming** — Editable profile, instant **English / Arabic (RTL) / German** switching, and **Light / Dark Mode**.

## 🛠️ Tech Stack

| Category | Packages / Tools |
| --- | --- |
| **Framework** | Flutter 3+, Material 3, Dart |
| **State Management** | `flutter_bloc` (Cubit), `ChangeNotifier` (ViewModels) |
| **Networking** | `dio`, `pretty_dio_logger`, `dartz` (`Either<Failure, T>`) |
| **Dependency Injection** | `get_it` |
| **Navigation** | `go_router` |
| **Localization** | `easy_localization` (EN, AR, DE) |
| **UI & UX** | `cached_network_image`, `shimmer`, `flutter_svg`, `bot_toast`, `pull_to_refresh_flutter3` |
| **Local Storage** | `shared_preferences` |

## 🚀 Getting Started

```bash
# 1. Clone the repository
git clone https://github.com/MahmoudBaioumy/NewBookApp.git
cd NewBookApp

# 2. Install dependencies
flutter pub get

# 3. Run the application
flutter run
```
