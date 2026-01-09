# Contributing to Balance Sheet

First off, thank you for considering contributing to Balance Sheet! It's people like you that make the open-source community such an amazing place to learn, inspire, and create.

By contributing to this project, you agree to abide by the terms of the [MIT License](LICENSE).

## 🛠️ Getting Started

### Prerequisites
Before you begin, ensure you have the following installed:
* **Flutter SDK**: Version 3.0.0 or higher
* **Dart SDK**: Version 3.0.0 or higher
* **IDE**: Android Studio or VS Code with Flutter extensions

### Installation
1.  **Fork the repository** on GitHub.
2.  **Clone your fork** locally:
    ```bash
    git clone [https://github.com/Emelio101/balance-sheet.git](https://github.com/Emelio101/balance-sheet.git)
    cd balance-sheet
    ```
3.  **Install dependencies**:
    ```bash
    flutter pub get
    ```

---

## 🏗️ Project Architecture

We follow a **Clean Architecture** approach with a **Feature-First** structure. Please familiarize yourself with this structure before adding new features.

* **State Management**: We use `flutter_bloc` (BLoC/Cubit pattern).
* **Code Generation**: We use `very_good_analysis` for strict linting.

When adding a new feature (e.g., `budgeting`), create a new directory in `lib/` following this pattern:

lib/budgeting/ ├── cubit/ ├── widgets/ ├── models/ └── budgeting_body.dart

---

## 📏 Coding Standards

To maintain a high-quality codebase, we adhere to strict coding standards.

### Style Guide
* We use **Very Good Analysis** for linting. Please ensure your code passes all lints.
* Run the linter locally before committing:
    ```bash
    flutter analyze
    ```

### Testing
* **Unit Tests**: Required for all Cubits/Blocs and repositories.
* **Widget Tests**: Required for critical UI components.
* Ensure all tests pass before submitting a PR:
    ```bash
    flutter test
    ```
* We encourage maintaining high test coverage. You can check this locally:
    ```bash
    flutter test --coverage
    genhtml coverage/lcov.info -o coverage/html
    ```

---

## 🔁 Workflow

1.  **Create a Branch**:
    Create a new branch for your feature or bugfix. Use a descriptive name:
    ```bash
    git checkout -b feature/amazing-feature
    # or
    git checkout -b fix/critical-bug
    ```

2.  **Make Changes**: Implement your changes, adhering to the coding standards above.

3.  **Commit Changes**:
    Write clear, concise commit messages.
    ```bash
    git commit -m 'Add transaction editing functionality'
    ```

4.  **Push to GitHub**:
    ```bash
    git push origin feature/amazing-feature
    ```

5.  **Submit a Pull Request**:
    * Go to the original repository.
    * Click "New Pull Request".
    * Select your fork and branch.
    * Provide a clear description of the changes and link to any relevant issues.

---

## 🐛 Reporting Bugs

If you find a bug, please create a GitHub Issue including:
1.  **Description**: What went wrong?
2.  **Steps to Reproduce**: How can we see the bug?
3.  **Expected Behavior**: What should have happened?
4.  **Screenshots**: If applicable.
5.  **Environment**: Device/Emulator details.

---

## 💡 Feature Requests

We welcome new ideas! (See our [Roadmap](README.md#road-map) for what is already planned).
If you have a suggestion, open an Issue with the tag **enhancement** and describe:
* The problem you are trying to solve.
* Your proposed solution.
* Any alternatives you considered.

---

## ❓ Questions?

Feel free to contact the author, **Emmanuel C Phiri**, via the links provided in the README.