# Splash Module

## 1. Overview

The Splash module serves as the initial entry point of the application. It displays an animated book visual matching the bookstore theme while initializing essential configurations and directing users to the appropriate destination based on their onboarding and authentication status.

## 2. Core Features

- **Animated Book Showcase**: Displays a smooth, Lottie-style animated book with flipping pages and subtle theme-matched visual accents in a clean, centered layout upon launch (without static logo or app name text).
- **Timed Auto-Navigation**: Automatically transitions users to the next screen after a short display duration (3 seconds).
- **Interactive Tap-to-Skip**: Allows users to immediately skip the splash wait time and navigate forward by tapping anywhere on the screen.

## 3. Business Logic & Rules

- **First-Time Users**: If the user has not completed or skipped onboarding, they are directed to the Onboarding walkthrough.
- **Unauthenticated Users**: If onboarding was previously completed but no active session exists, the user is directed to the Login screen.
- **Authenticated Users**: If an active session exists, the user is directed straight to the Home dashboard.
- **Single Navigation Guarantee**: Navigation occurs only once, regardless of multiple quick taps or race conditions between user interaction and timer expiration.

## 4. Recent Changes

- Replaced the static logo and application name on the splash screen with a custom Lottie-style animated book illustration that adapts to the app's light and dark themes.
- Fixed full-screen tap-to-skip behavior so tapping anywhere on the screen immediately advances past the splash screen.
- Added navigation guard to prevent duplicate transition attempts.
- Documented module specifications and routing rules.
- Opening navigation now follows the same destination rules as the rest of the app.
