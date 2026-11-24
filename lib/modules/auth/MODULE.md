# Auth Module

## 1. Overview
The Auth module manages user authentication, registration, and session initialization, providing users with a clean, streamlined interface to sign in to their accounts or create a new account.

## 2. Core Features
- **Brand Header & Welcome**: Displays the Ketaby brand logo and welcoming call-to-action header (`Join Us!`).
- **Account Redirect Prompt**: Allows users to seamlessly switch between the Login screen (`Don't have an account? Register`) and the Register screen (`already have an account? Login`).
- **Email & Password Login Card**: Provides a bordered card containing validated email and password fields with password visibility toggling and a primary pill-shaped action button.
- **Full Registration Card**: Provides a bordered card containing validated Name, Email, Password, and Confirm Password fields with a primary pill-shaped `Register` action button.

## 3. Business Logic & Rules
- **Input Validation**: Validates full name, email format, password requirements, and password confirmation matching before submitting.
- **Session Update**: Upon successful authentication or registration, the user's session and profile details are stored locally and the user is directed to the main home navigation screen.
- **Full Localization & RTL Support**: All labels, hints, and error messages adapt automatically to English, Arabic, and German with directional layouts.

## 4. Recent Changes
- Created `RegisterScreen` and `RegisterController` under `lib/modules/auth/register/` matching the Ketaby design (Name, Email, Password, Confirm Password, Register button).
- Extracted modular registration widgets into `lib/modules/auth/register/widgets/` (`RegisterHeaderWidget`, `RegisterRedirectPromptWidget`, `RegisterFormCardWidget`).
- Connected navigation between `LoginScreen` and `RegisterScreen` via `AppRoutes.register`.
- Redesigned `LoginScreen` to match the Ketaby card style with only Email and Password inputs.
- Created custom vector asset `ketaby_logo.svg` matching the brand mark.
- Replaced all static spacing and radius values with `Dimensions` constants and added full English, Arabic, and German localization keys.
- Added `POST /logout` endpoint in `ApiConstants.auth.logout`, `AuthRepo`, and `AuthCubit`, and connected it to `safeLogout()` and the logout confirmation flow to terminate the server session before clearing local user cache and redirecting to the Login screen.
