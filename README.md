🚀 Student Registration App

A mobile application built as part of the Technical Test – Staff Mobile Developer, designed to demonstrate clean architecture, scalable state management, and proper local data handling in a real-world mobile development scenario.

📱 Overview

Student Registration App is a mobile application that allows administrators to register students digitally, manage student data locally, and view detailed student information through a clean and user-friendly interface.

The project focuses on:

Clean code & maintainable architecture

Proper state management

Local data persistence

Input validation & error handling

Production-ready project structure

✨ Features
🔐 Authentication

Dummy login (mock API Apiary)

Input validation

Clear error messages

📝 Student Registration

Full name
NISN
Date of birth
Major selection (dropdown)

Includes:
Required field validation
User-friendly form interaction
Local data persistence (Sharedpreferences)
mock api data

📋 Student List
Display registered students from mock api
Data loaded from from mock api

👤 Student Detail
Full student information view
Clean and readable layout

⚠️ Error Handling
Empty field validation
Informative error messages
Proper UI state handling (loading, success, error)

⭐ Additional Features (Bonus)
Mock REST API integration
Dark mode support
Push notification simulation (Firebase)
Basic unit testing

🧱 Tech Stack
Category Technology
Platform Flutter
Language Dart
State Management Bloc
Local Storage SharedPreferences
Networking Dio / HTTP
Architecture Clean Architecture
Dependency Injection get_it
Testing Unit Test

🏗 Architecture
This project follows Clean Architecture principles:
Presentation
│
├── UI Screens
├── State Management
│
Domain
│
├── Entities
├── Use Cases
│
Data
│
├── Models
├── Local Data Source
├── Repository Implementation

This approach ensures:
Separation of concerns
Easier testing
High maintainability
Scalability for future development

📁 Project Structure
lib/
│
├── core/
│ ├── constants/
│ ├── utils/
│ └── storage/
│
├── data/
│ ├── datasources/
│ ├── models/
│ └── repositories/
│
├── domain/
│ ├── entities/
│ ├── repositories/
│ └── usecases/
│
├── presentation/
│ ├── login/
│ ├── register_student/
│ ├── student_list/
│ └── student_detail/
│
└── main.dart

▶️ Getting Started

1. Clone Repository
   git clone https://github.com/fandiaspraja/Pmb-App.git
2. Install Dependencies
   flutter pub get
3. Run Application
   flutter run

🔑 Dummy Login Credentials
Email Password
admin@test.com
123456

📦 Deliverables
✅ Source Code (Public GitHub Repository)
✅ APK File
✅ Demo Video Youtube (Screen Recording)
https://youtu.be/mMvvL7a7MNg

⏱ Development Timeline
Duration: 5 days (including weekend)
Deadline: 20 January 2026

🔗 Submission Link
👉 https://bit.ly/PengumpulanTahap3StafIT

🧠 Key Highlights
Clean Architecture implementation
Scalable state management
Production-style folder structure
Readable, maintainable, and testable code

🙌 Closing
Thank you for the opportunity to complete this technical test.
This project reflects my approach to building maintainable mobile applications with clean structure, clear separation of responsibility, and readiness for future scaling.

👨‍💻 Author
Fikry Andias Praja
Mobile Developer (Flutter • Android)
