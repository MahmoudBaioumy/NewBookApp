# Products (Book Store Home) Module

## 1. Overview
The Products module powers the Book Store home experience, presenting personalized user greetings, promotional book banners, best-selling books, book categories, and newly arrived titles.

## 2. Core Features
- **Personalized Greeting Header**: Welcomes the logged-in user by name and avatar (with fallback defaults for guests) alongside a quick filter/menu action.
- **Top Featured Carousel**: Displays a peeking horizontal banner slider highlighting featured collections and announcements.
- **Best Seller & New Arrivals Feeds**: Horizontal scrollable lists of book cards showing book cover art, discount percentage badge, book title, category, original strikethrough price, and discounted price in local currency.
- **Promotional Offer Slider**: Framed middle banner carousel with an animated page indicator for book club sales and special discounts.
- **Visual Categories Section**: Horizontal list of square category cards with book imagery, dark contrast overlays, and centered category titles.

## 3. Business Logic & Rules
- **User Identity Resolution**: User name and profile picture are resolved from the active session, defaulting to guest display values when not signed in.
- **Discount Display**: Books with an active discount percentage display a top-start badge on the cover and show both the original price (crossed out) and the final discounted price.
- **Loading Skeletons**: Each independent section (Top Banners, Best Sellers, Promo Banners, Categories, New Arrivals) displays a matching shimmer skeleton while data loads.

## 4. Recent Changes
- Connected `POST /add-to-cart` via `CartCubit` across `BooksListScreen` (Best Seller, New Arrivals, Books catalog), `BookDetailsScreen`, and `WishlistScreen`, updating the cached cart response and showing a toast confirmation.
- Integrated `POST /add-to-wishlist` with optimistic UI updates across `BooksListScreen` and `BookDetailsScreen`: tapping the heart icon immediately highlights it in the primary color while sending the request in the background, reverting the state and displaying an error toast if the request fails.
- Added `WishlistScreen` (`lib/modules/products/views/wishlist/`) integrated with the `/wishlist` endpoint (`WishlistResponse`), displaying favorite books in a vertical list with the same horizontal card design and staggered entrance animation as Best Seller, complete with shimmer loading, error retry, and empty state.
- Added `BookDetailsScreen` (`lib/modules/products/views/book_details/`) integrated with `/products/{id}` (`ProductDetailsResponse`), opening from any book card across `ProductsHomeScreen` and `BooksListScreen` with shimmer loading, error retry, and localized labels.
- Added `BooksListScreen` (`lib/modules/products/views/books_list/`) with search filtering, horizontal book cards (`BookListHorizontalCardWidget`), and staggered list entrance animations (`StaggeredListAnimationWidget`), reusing the already-fetched `ProductsResponse` model without making redundant API calls when tapping "See All" on Best Seller or New Arrivals.
- Integrated the live `/categories` API endpoint (`CategoriesResponse`) with pagination metadata and links, feeding the horizontal category cards with shimmer skeletons and error retry handling.
- Integrated the live `/products-bestseller` and `/products-new-arrivals` API endpoints using a unified product list response model (`ProductsResponse`), complete with shimmer skeletons and error retry states.
- Integrated the live `/sliders` API endpoint to populate the top featured banner carousel dynamically with error retry and shimmer loading states.
- Redesigned `ProductsHomeScreen` to match the Book Store home UI specification.
- Extracted modular, reusable widgets into `lib/modules/products/widgets/`: `HomeHeaderWidget`, `HomeTopSliderWidget`, `SectionHeaderWidget`, `BookCardWidget`, `BookHorizontalListWidget`, `PromoBannerSliderWidget`, `CategoryCardWidget`, and `HomeCategoriesListWidget`.
- Eliminated static layout numbers in favor of centralized `Dimensions` constants and added English/Arabic localizations.
