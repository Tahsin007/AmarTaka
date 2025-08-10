# Amar Taka - Your Personal Finance Companion

Amar Taka is a Flutter-based mobile application designed to help you manage your personal finances effectively. Track your income and expenses, create budgets, and gain insights into your spending habits to achieve your financial goals.

## Features

- **Transaction Management:** Easily add, edit, and delete your daily income and expenses.
- **Budgeting:** Create custom budgets for different categories to control your spending.
- **Categorization:** Organize your transactions into various categories for better analysis.
- **Financial Overview:** Get a clear picture of your financial health with a comprehensive dashboard.
- **Recurring Transactions:** Set up recurring transactions for your regular bills and income.
- **Search:** Quickly find specific transactions using the search functionality.
- **User Authentication:** Secure your financial data with user authentication.
- **Profile Management:** Manage your user profile and settings.

## App Snapshots

<img width="270" height="600" alt="Screen1" src="https://github.com/user-attachments/assets/0f399827-6d8b-4cfc-a8fa-70fa9052790c" />

<img width="270" height="600" alt="Screen2" src="https://github.com/user-attachments/assets/eb164941-1c73-4f0e-b905-62c18c907d4c" />

<img width="270" height="600" alt="Screen3" src="https://github.com/user-attachments/assets/0be1f67d-9b30-4588-910b-1ac4469027df" />

<img width="270" height="600" alt="Screen4" src="https://github.com/user-attachments/assets/ba300219-7a58-4b4a-ab51-ef0109c566c7" />

<img width="270" height="600" alt="Screen5" src="https://github.com/user-attachments/assets/05a87ff0-8e3b-4a86-9de0-eb7b4dd75b6c" />

<img width="270" height="600" alt="Screen6" src="https://github.com/user-attachments/assets/801b2b6f-7da9-4b9c-a9d7-a7b05854bb0e" />

<img width="270" height="600" alt="Screen7" src="https://github.com/user-attachments/assets/79afe600-2e12-4ee7-b3d8-457d353c348a" />

<img width="270" height="600" alt="Screen8" src="https://github.com/user-attachments/assets/d4796064-e3f8-4291-9896-aa4c4292c2b2" />

## Libraries and Packages Used

- **[flutter_bloc](https://pub.dev/packages/flutter_bloc):** State management library for predictable state changes.
- **[go_router](https://pub.dev/packages/go_router):** Navigation library for handling routes.
- **[get_it](https://pub.dev/packages/get_it):** Service locator for dependency injection.
- **[hive](https://pub.dev/packages/hive):** Lightweight and fast key-value database for local storage.
- **[http](https://pub.dev/packages/http):** For making HTTP requests to a server.
- **[google_fonts](https://pub.dev/packages/google_fonts):** For using custom fonts from Google Fonts.
- **[lottie](https://pub.dev/packages/lottie):** For displaying Lottie animations.
- **[fpdart](https://pub.dev/packages/fpdart):** Functional programming library for Dart.
- **[internet_connection_checker_plus](https://pub.dev/packages/internet_connection_checker_plus):** To check for internet connectivity.
- **[shared_preferences](https://pub.dev/packages/shared_preferences):** For storing simple data.
- **[table_calendar](https://pub.dev/packages/table_calendar):** For displaying calendars.
- **[easy_date_timeline](https://pub.dev/packages/easy_date_timeline):** For creating horizontal date timelines.

## App Architecture

This project follows a feature-first architecture with a clean separation of concerns. The core principles of the architecture are:

- **Feature-based Structure:** The code is organized into features, with each feature having its own directory containing the necessary components (e.g., `auth`, `budgets`, `transaction`).
- **State Management:** The app uses `flutter_bloc` for state management, ensuring a predictable and maintainable state.
- **Dependency Injection:** `get_it` is used for dependency injection, making the code more modular and testable.
- **Repository Pattern:** The repository pattern is used to abstract the data layer from the rest of the app.

## Folder Structure

The project follows a clean architecture with a feature-based approach. Here's a simplified overview of the folder structure:

```
lib/
├── core/
│   ├── common/
│   ├── constants/
│   ├── error/
│   ├── network/
│   ├── theme/
│   ├── usecases/
│   └── utils/
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── bloc/
│   │       ├── pages/
│   │       └── widgets/
│   ├── budgets/
│   ├── category/
│   ├── home/
│   ├── profile/
│   ├── recurring_transactions/
│   ├── search/
│   └── transaction/
├── init_dependencies.dart
└── main.dart
```

## Installation

To get a local copy up and running, follow these simple steps.

### Prerequisites

- **Flutter SDK:** Make sure you have the Flutter SDK installed. For instructions, see the [official Flutter documentation](https://flutter.dev/docs/get-started/install).

### Installation Steps

1.  **Clone the repo**
    ```sh
    git clone https://github.com/your_username/amar_taka.git
    ```
2.  **Navigate to the project directory**
    ```sh
    cd amar_taka
    ```
3.  **Install dependencies**
    ```sh
    flutter pub get
    ```
4.  **Run the app**
    ```sh
    flutter run
    ```
