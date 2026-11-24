# Home With Navigation Bar Module

## 1. Overview
This module manages the main screen navigation shell of the Book Store application, featuring a bottom navigation bar layout that wraps the primary tabs.

## 2. Core Features
- Users can switch between the five core sections of the Book Store: **Home**, **Books**, **Favorites**, **Cart**, and **Profile**.
- Active tab highlights both the icon and its localized label in the primary brand color, while inactive tabs display clean icon-only indicators.
- Integrated hardware back-button handling that returns the user to the Home tab before prompting to exit the application.

## 3. Business Logic & Rules
- Bottom navigation tabs correspond to `MainScreenPageType` enum options (`home`, `books`, `favorites`, `cart`, `profile`).
- Pressing back on Android from any secondary tab first navigates back to the Home tab; pressing back while on the Home tab shows an exit confirmation dialog.

## 4. Recent Changes
- Connected the **Cart** bottom navigation tab directly to `CartScreen` to display the user's shopping cart items fetched from `/cart` with quantity controls and checkout summary bar.
- Connected the **Profile** bottom navigation tab directly to `ProfileScreen` to display the user's profile information, curved header with avatar, quick settings (language and theme), and edit profile action.
- Connected the **Favorites** bottom navigation tab directly to `WishlistScreen` to display the user's favorite books fetched from `/wishlist`.
- Connected the **Books** bottom navigation tab directly to `BooksListScreen` to display the catalog with search filtering and staggered entrance animations using already-cached data.
- Updated the bottom navigation bar tabs and icons to match the Book Store design (`Home`, `Books`, `Favorites`, `Cart`, `Profile`).
- Updated `NavBarIconWidget` to show the label under the active icon and use centralized `Dimensions` constants.
