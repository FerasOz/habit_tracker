# Habit Tracker App

A clean and scalable **Habit Tracker** application built with **Flutter** and **Bloc (Cubit)**, designed to help users build and maintain daily habits with a simple, intuitive experience.

---

## 📱 Features

- Create, edit, and delete habits
- Assign habits to specific days of the week
- Automatically display habits based on the current day
- Mark habits as completed using swipe gestures
- Track:
  - Daily completion status
  - Current streak
  - Total completed days
- Local data persistence using **Shared Preferences**
- Clean UI with responsive layout (ScreenUtil)
- Confirmation dialogs for destructive actions

---

## 🧱 Architecture

The project follows a **clean and maintainable architecture** inspired by feature-first and separation of concerns principles.

```
lib/
│
├── core/          # App-wide utilities, themes, constants
├── cubit/         # Global Cubits
├── data/          # Models & local data sources
├── features/      # Feature-based modules (UI + logic)
│   └── home/
│       ├── view/
│       ├── widgets/
│       └── cubit/
```

- **Cubit** is used for state management
- Business logic is fully separated from UI
- Widgets are small, reusable, and stateless where possible

---

## 🗂 State Management

- Uses **flutter_bloc (Cubit)**
- Single source of truth for habit state
- Immutable state updates
- Clear loading, success, and error handling

---

## 💾 Local Storage

Habits and progress are stored locally using **SharedPreferences**, ensuring:

- Fast access
- Offline support
- Persistence between app launches

---

## 🎨 UI & UX

- Material 3 design principles
- Custom theme (no default purple accents)
- Swipe gestures for quick actions
- Confirmation dialogs to prevent accidental deletion
- Responsive design for different screen sizes

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (latest stable)
- Dart SDK

### Installation

```bash
git clone https://github.com/your-username/habit-tracker.git
cd habit-tracker
flutter pub get
flutter run
```

---

## 📦 Dependencies

- flutter_bloc
- shared_preferences
- flutter_screenutil

---

## 🔮 Future Improvements

- Cloud sync
- Statistics & charts
- Habit reminders & notifications
- Dark / Light theme toggle
- Weekly & monthly reports

---

## 👨‍💻 Author

**Feras Osama Abuzayed**

---

## 📄 License

This project is licensed under the MIT License.

