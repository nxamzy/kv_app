# 🚀 Ocam POS — Modern Retail & Inventory Management System

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)
![BLoC](https://img.shields.io/badge/State-BLoC-546E7A?style=for-the-badge)

**Ocam POS** is a high-performance retail management ecosystem built with Flutter. The project is designed with a focus on scalability, maintainability, and professional coding standards using **Clean Architecture** and **BLoC** state management.

---

## 💎 Key Features

* **📦 Smart Inventory:** Real-time product scanning and tracking using QR-code integration.
* **👥 Supplier Management:** Comprehensive module to manage suppliers, with advanced filtering and history tracking.
* **⚡ Real-time Synchronization:** Powered by Firebase Firestore for instant data sync across all authorized devices.
* **🎨 Centralized Design System:** 100% implementation of `AppColors` and custom themes. No hardcoded values for a consistent UI/UX.
* **🛡 Robust Error Handling:** Implementation of specialized BLoC states for Loading, Success, and Failure (using Dartz for functional error handling).

---

## 🏗 Architecture: Clean Architecture + MVVM

The project follows strict **SOLID** principles, ensuring the business logic is completely decoupled from the UI:

### 1. Data Layer
* **DataSources:** Handling remote API calls and Firebase interactions.
* **Models:** Data Transfer Objects (DTOs) with JSON serialization logic.
* **Repositories:** Concrete implementations of the domain repository interfaces.

### 2. Domain Layer (The Core)
* **Entities:** Pure Dart objects representing the business models.
* **Repositories (Abstract):** Contracts that define how data should be fetched/sent.
* **Use Cases:** Individual business logic units (e.g., `AddProduct`, `FetchSuppliers`).

### 3. Presentation Layer
* **State Management (BLoC):** All business logic is handled within BLoCs. The UI is a "passive" observer of states.
* **Pages & Widgets:** Clean, reusable UI components following Flutter best practices.



---

## 📂 Project Structure

```text
lib/
 ├── core/                 # AppColors, Themes, Failure classes, Constants
 ├── data/                 # Models, Repository Implementations, Data sources
 ├── domain/               # Entities, Abstract Repositories, UseCases
 ├── presentation/         # BLoCs, Pages, Reusable Widgets
 └── main.dart             # Application Entry Point