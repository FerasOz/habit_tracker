# Habit Tracker

A Flutter habit tracking app focused on helping users build consistent routines with a clean UI, weekly goals, and simple local persistence.

## Overview

The app lets users create habits, choose active days, define a weekly target, track completion by day, and monitor progress through streaks and consistency insights. It also supports Arabic and English, light and dark themes, and keeps data saved locally between launches.

## Current Features

- Add new habits with title, optional description, active days, and weekly target.
- Edit existing habits without losing their saved progress history.
- Delete a single habit from the home list or habit details screen.
- Clear all habits from the settings screen.
- Browse habits for any selected day using the weekly day selector.
- Mark habits as done or undone for the selected day.
- Prevent marking a habit as completed on inactive days.
- Show daily summary cards for done and remaining habits.
- Track weekly progress for each habit against a configurable target.
- Show detailed stats such as current streak, best streak, total completions, and 28-day consistency rate.
- Support Arabic and English with `easy_localization`.
- Support light and dark themes with saved user preference.
- Persist habits, language, and theme locally using `SharedPreferences`.
- Use responsive sizing with `flutter_screenutil`.

## Screens Included

- Home screen
- Add habit screen
- Edit habit flow
- Habit details screen
- Settings screen

## Tech Stack

- Flutter
- Dart
- `flutter_bloc` / Cubit
- `shared_preferences`
- `easy_localization`
- `flutter_screenutil`
- `uuid`

## Project Structure

```text
lib/
├── core/
│   ├── helpers/        # Shared helpers, constants, dialogs, spacing
│   ├── routing/        # Named routes and route generation
│   └── styles/         # Colors and theme definitions
├── cubit/              # App state and business logic
├── data/
│   ├── local/          # SharedPreferences wrapper
│   └── models/         # Habit model and progress calculations
├── features/
│   ├── add_habit/      # Create / edit habit UI
│   ├── habit_details/  # Habit analytics and status view
│   ├── home/           # Weekly overview and habits list
│   └── settings/       # Theme, language, and app info
├── generated/          # Localization generated files
├── habit_tracker_app.dart
└── main.dart
```

## State Management

The app uses a single `HabitCubit` as the main source of truth for:

- Loading and saving habits
- Switching language
- Toggling theme
- Tracking the currently selected day
- Managing the create/edit habit form state

## Data Model

Each habit stores:

- `id`
- `title`
- `description`
- `createdAt`
- `activeDays`
- `targetPerWeek`
- `completedDates`

From this data, the app derives:

- completion state for a specific day
- completed count for the selected week
- remaining weekly target
- current streak
- best streak
- 28-day consistency rate

## Local Persistence

The app currently uses `SharedPreferences` to save:

- habits data
- selected language
- selected theme

This makes the app work fully offline with no backend dependency.

## Localization

Translations live in:

- `assets/translations/en.json`
- `assets/translations/ar.json`

Localization is initialized in `main.dart` using `easy_localization`, and generated keys are stored in `lib/generated/`.

## Routing

Named routing is centralized in `lib/core/routing/app_routers.dart`.

Current routes:

- home screen
- add habit screen
- habit details screen
- settings screen

## Running the Project

### Prerequisites

- Flutter SDK
- Dart SDK
- A configured Flutter environment for Android, iOS, Web, Windows, Linux, or macOS

### Install and Run

```bash
flutter pub get
flutter run
```

## Notes for Developers

- The add habit screen is also used for editing habits.
- Weekly target is automatically clamped so it does not exceed selected active days.
- Completion is stored as normalized `yyyy-MM-dd` date keys.
- The selected day affects both the home summary and habit details analytics.

## Possible Next Improvements

- Notifications and reminders
- Export or backup support
- Cloud sync
- Charts and advanced reports
- Search, filtering, and sorting options
- Better automated test coverage

## Author

**Feras Osama Abuzayed**
