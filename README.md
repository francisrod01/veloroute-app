# 🚍 VeloRoute-Flutter-PostGIS

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Platform](https://img.shields.io/badge/Platform-Android%20|%20macOS-green.svg)](#)
[![codecov](https://codecov.io/github/francisrod01/veloroute-app/graph/badge.svg?token=76G8YBIB55)](https://codecov.io/github/francisrod01/veloroute-app)

A high-performance transit scheduling platform built with **Flutter** and **Clean Architecture**.   
Powered by a **Dockerised PostGIS** and **PostgREST** backend ecosystem.

Developed and maintained by [Francis Batista](https://github.com/francisrod01).

## 🛠️ Development Setup

**Prerequisites**

- **Flutter SDK**: ^3.5.0
- **Docker** & **Docker Compose**
- **Make** (optional, for using the shortcut commands)

**Quick Start**

1. Clone the repository:

```bash
git clone https://github.com/francisrod01/veloroute-app.git
cd veloroute-app
```

2. Initialise the backend:

```bash
# This will pull images and run the init.sql script,
make run-backend
```

*The database will be available on port 5432, API on 3000, and Adminer on 8000.*

3. Run the Flutter App

```bash
flutter pub get
# For macOS Desktop
flutter run -d macos
```

## 🏗️ Architecture

This project follows **Clean Architecture** principles to ensure scalability and testability:

- **Domain:** Entities, Use Cases, and Repository Interfaces.
- **Data:** Repository implementations and Data Providers (PostgREST).
- **Presentation:** BLoC state management and Material 3 UI components.

## 🤝 How to Contribute

Contributions are what make the open-source community such an amazing place to learn, inspire, and create.

1. Fork the Project.
2. Create your Feature Branch (git checkout -b feature/AmazingFeature).
3. Commit your changes (git commit -m 'feat: add some amazing feature').
4. Push to the Branch (git push origin feature/AmazingFeature).
5. Open a Pull Request.

## 📄 License

Distributed under the **Apache License 2.0**. See `LICENSE` for more information.
