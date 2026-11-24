# Cart Module

## 1. Overview
The Cart module manages the user's shopping cart experience, allowing users to review selected books, adjust item quantities, remove items, inspect original and discounted unit prices, and view the live total order price before proceeding to checkout.

## 2. Core Features
- **Cart Items List**: Displays all books added to the user's cart using the unified horizontal card style and staggered entrance animation consistent with the Book Store catalog and Wishlist screens.
- **Book Item Details**: Each cart card shows the book cover image, title, delete action button, interactive quantity selector (`+` / `-`), strikethrough original unit price, and discounted unit price in local currency.
- **Interactive Quantity & Item Removal**: Users can increment or decrement item quantities (bounded between 1 and available stock) or remove an item from the cart, immediately recalculating the total price.
- **Sticky Checkout Summary Bar**: Displays the total cart price in local currency alongside a prominent pill-shaped **CheckOut** button at the bottom of the screen when items are present.
- **Loading, Empty & Error States**: Displays a matching shimmer skeleton while fetching cart data, an error state with retry support on network failure, and an empty cart state (hiding the bottom checkout bar) when no items remain.

## 3. Business Logic & Rules
- **Minimum & Maximum Quantity**: Item quantity cannot be decremented below `1` and cannot exceed the product's available stock (`item_product_stock`).
- **Dynamic Total Calculation**: Defaults to the server-provided cart total when unmodified and dynamically recalculates the total price whenever quantities or items are adjusted locally.
- **Book Details Navigation**: Tapping any cart item card opens the Book Details screen for that book.

## 4. Recent Changes
- Integrated `POST /place-order` (`PlaceOrderRequest`, `PlaceOrderResponse`) with the **Order Now** button in `CheckoutScreen`, sending customer details (`name`, `governorate_id`, `phone`, `address`, `email`), clearing cached cart items on success, and displaying a confirmation dialog that navigates the user back to the Home tab.
- Added `CheckoutScreen` (`lib/modules/cart/views/checkout/`) integrated with `GET /checkout` (`CheckoutResponse`), displaying pre-filled customer delivery information fields, an itemized order summary card (book title, unit price, quantity badge, and line total), shimmer loading, error retry, and a bottom total price & **Order Now** bar opened when tapping **CheckOut** in `CartScreen`.
- Integrated `POST /add-to-cart`, `POST /update-cart`, and `POST /remove-from-cart` in `CartRepo` and `CartCubit`, connecting quantity increment/decrement and item removal in `CartController` with optimistic UI updates and automatic rollback on failure.
- Created the `cart` module (`lib/modules/cart/`) with `CartRepo`, `CartCubit`, `CartResponse`, `CartController`, and `CartScreen` integrated with `GET /cart`.
- Connected the bottom navigation bar **Cart** tab directly to `CartScreen`.
- Added centralized layout constants in `Dimensions` and English/Arabic translations for all Cart UI labels.
