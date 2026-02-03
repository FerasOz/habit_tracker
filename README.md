# Habit Tracker App

A clean and scalable **Habit Tracker** application built with **Flutter** and **Bloc (Cubit)**, designed to help users build and maintain daily habits with a simple, intuitive experience.

---

## 📱 Features

- Create, edit, and delete habits
- Assign habits to specific days of the week
- Light & Dark mode
- Automatically display habits based on the current day
- Supports **Arabic & English** languages
- Seamless language switching using **easy_localization**
- Mark habits as completed using swipe gestures
- Track:
  - Daily completion status
  - Current streak
  - Total completed days
- Local data persistence using **Shared Preferences**
- Clean UI with responsive layout (ScreenUtil)
- Confirmation dialogs for destructive actions

---

## 📸 Screenshots

### Home Screen
| Light Mode | Dark Mode |
|------------|-----------|
| <img src="https://github.com/user-attachments/assets/8922369f-25ee-4931-b810-6f224cad2975" width="600"/> | <img src="https://github.com/user-attachments/assets/7637094b-3a00-44eb-8bba-40ea75666b25" width="600"/> |

### Habit Management
| Add Habit(Arabic) | Habit Details |
|-----------|---------------|
| <img src="https://github.com/user-attachments/assets/c4fb847d-31ed-4dee-9658-bce073f8389c" width="600"/> | <img src="https://github.com/user-attachments/assets/d21216a2-eec8-4bb7-b926-a8f3c47257c3" width="600"/> |

### Settings Screen
| Settings (Arabic) |
|-----------|
| <img width="1200" alt="settings_arabic" src="https://github.com/user-attachments/assets/f95382e0-6835-48cf-aa08-82f415be23bb" />

---

## 🧱 Architecture

The project follows a **clean and maintainable architecture** inspired by feature-first and separation of concerns principles.

```
lib/
│
├── core/          # App-wide utilities, themes, constants
├── cubit/         # Global Cubits
├── data/          # Models & local data sources
├── features/      # Feature-based modules (UI (Screens + Widgets))
│   └── home/
│       ├── view/
│       ├── widgets/
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
- Weekly & monthly reports

---

## 👨‍💻 Author

**Feras Osama Abuzayed**


