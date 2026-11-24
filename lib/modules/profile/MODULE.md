# Profile Module

## 1. Overview
The Profile module displays and manages the authenticated user's personal information and account preferences in a clean, branded interface accessible from the main bottom navigation bar.

## 2. Core Features
- **Curved Profile Header & Avatar**: Displays the localized `Profile` header over a curved primary background with a quick logout button and an overlapping circular user avatar.
- **Personal Details Card**: Fetches the user's current profile data from `/profile` and displays `Name`, `Email`, `Phone`, `City`, and `Address` with floating labels when populated.
- **Quick Settings Button (Language & Theme)**: Located directly beneath the `Address` field, allowing users to expand and switch the application language (`EN`, `AR`, `DE`) and toggle between `Light Mode` and `Dark Mode` without leaving their profile.
- **Update Profile Action**: Allows the user to modify their `Name`, `Phone`, `City`, and `Address` and save changes directly to the server via `/update-profile` by tapping the `Edit Profile` button.

## 3. Business Logic & Rules
- **Unified Profile Model**: Both `/profile` and `/update-profile` share a single unified `ProfileResponse` model containing the user's profile data.
- **Session Data Synchronization**: Initial fields populate immediately from `AppSessionManager` while fetching fresh data from `/profile`, and any profile update persists back to `AppSessionManager`.
- **Instant Theme & Language Reactivity**: Toggling the language or dark/light mode inside the Settings section immediately updates the entire screen's colors, typography, and RTL/LTR directionality.
- **Logout Confirmation**: Tapping the logout icon in the header prompts the user with the confirmation dialog before clearing the session.

## 4. Recent Changes
- Integrated `GET /profile` and `POST /update-profile` endpoints in `ApiConstants.profile`, `ProfileRepo`, `ProfileCubit`, and `ProfileController` using a single unified `ProfileResponse` model.
- Created `ProfileScreen` and `ProfileController` under `lib/modules/profile/views/profile/`.
- Created modular widgets `ProfileHeaderWidget`, `ProfileInfoCardWidget`, `ProfileSettingsSectionWidget`, `ProfileEditButtonWidget`, and `ProfileShimmerWidget` using centralized `Dimensions` constants and localized strings.
- Connected the bottom navigation bar `Profile` tab to `ProfileScreen` and registered `AppRoutes.profileScreen`.
- Connected the Profile header logout action to the `POST /logout` endpoint via `ProfileController` and `safeLogout`.
