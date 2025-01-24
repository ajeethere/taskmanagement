# taskmanagement


Task Management App
A Flutter-based task management application with theme switching and Riverpod state management.

Features
Add, Edit, and Delete Tasks
Persistent storage using SQLite with sqflite
Dark Mode and Light Mode support using Hive
Dynamic state management with Riverpod

Prerequisites
Make sure you have the following installed on your system:

Flutter SDK (https://docs.flutter.dev/get-started/install)
Dart SDK (Included with Flutter)
An Android Emulator or a physical device to test the app.
VS Code or Android Studio (for development).
Hive Database Adapter:
Run the following command to generate Hive type adapters:
              flutter packages pub run build_runner build

Installation
Follow these steps to set up and run the project:

Clone the Repository:
git clone <repository_url>
cd <repository_folder>
Install Dependencies: Run the following command to fetch all required Flutter packages:
flutter pub get


Set Up the Database:
Ensure you have initialized sqflite for storing tasks.
Hive is used for managing app themes. Open the database file or directory (themeBox) automatically created during runtime.
Run the App: Use the Flutter CLI to run the application:
flutter run


Test on Emulator or Physical Device:
Use a connected emulator or a USB-connected device for testing.
Ensure the device is listed using:
flutter devices


Project Structure
lib/
│
├── main.dart                 # Application entry point
├── database/                 # Contains database classes
│   └── database_helper.dart  # Database instance provider
├── object_models/            # Object models
│   └── task_obj.dart         # Task Object class
├── router/                   # App screen routers
│   └── navigation_state.dart # Navigation state for routing
│   └── routes.dart           # App screen endpoints
├── scheduler/                # Schedule classes
│   └── schedule.dart         # Notification schedule class
├── screens/                  # UI screens for the app
│   └── home_screen.dart      # Home screen with tasks list and other features
│   └── add_task_screen.dart  # Add or edit task screen
├── states/                   # MVVM through Rivepod state
│   └── add_task_state.dart   # State management for Add Task Screen
│   └── tasks_state.dart      # State management for Tasks list Screen
├── theme/                    # Theme classes
│   └── theme_notifier.dart   # Theme notifier class
└── utils/                    # All app util classes
    └── add_date_utils.dart   # App Date picker utils
    └── utils.dart            # App utils 

Key Commands for Database and Hive
Generate Hive Adapters: If you've modified any object models using Hive annotations, generate adapters:
flutter packages pub run build_runner build


Clear Hive Data: In case you need to reset Hive storage for testing:
await Hive.box('themeBox').clear();
Customization
Changing Theme Preferences
To manually change the default theme or modify Hive storage logic, edit the following file:

Ensure SQLite is initialized properly by debugging task_repository.dart.
Emulator issues:
Restart your emulator or try a physical device.

Contributing
Contributions are welcome! Please fork this repository, make changes, and submit a pull request.


