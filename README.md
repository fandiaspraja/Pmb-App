# 🚀 Student Registration App

A mobile application built as part of the **Technical Test – Staff Mobile Developer**, designed to demonstrate **Clean Architecture**, **scalable state management**, and **proper API data handling** in a real-world Flutter development scenario.

---

## 📱 Overview

**Student Registration App** is a Flutter-based mobile application that enables administrators to digitally register students, manage student data locally, and view detailed student information through a clean and user-friendly interface.

This project focuses on:

- ✅ Clean code & maintainable architecture
- ✅ Scalable state management
- ✅ Mock API integration
- ✅ Input validation & error handling
- ✅ Production-ready project structure

---

## ✨ Features

### 🔐 Authentication

- Dummy login using **Mock API (Apiary)**
- Input validation
- Clear and informative error messages

---

### 📝 Student Registration

Fields:

- Full name
- NISN
- Date of birth
- Major selection (dropdown)

Includes:

- Required field validation
- User-friendly form interaction
- Local data persistence (**SharedPreferences**)
- Mock API data handling

---

### 📋 Student List

- Display registered students from mock API
- Data fetched dynamically

---

### 👤 Student Detail

- Full student information view
- Clean and readable UI layout

---

### ⚠️ Error Handling

- Empty field validation
- Informative error messages
- Proper UI state handling:
  - Loading
  - Success
  - Error

---

### ⭐ Additional Features (Bonus)

- Mock REST API integration
- Dark mode support
- Push notification simulation (Firebase)
- Basic unit testing

---

## 🧱 Tech Stack

| Category             | Technology         |
| -------------------- | ------------------ |
| Platform             | Flutter            |
| Language             | Dart               |
| State Management     | Bloc               |
| Local Storage        | SharedPreferences  |
| Networking           | Dio / HTTP         |
| Architecture         | Clean Architecture |
| Dependency Injection | get_it             |
| Testing              | Unit Test          |

---

## 🏗 Architecture

This project follows **Clean Architecture principles**:

```
Presentation
│
├── UI Screens
├── State Management (Bloc)
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
```

### Benefits:

- Separation of concerns
- Easier testing
- High maintainability
- Scalable for future development

---

## 📁 Project Structure

```
lib/
│
├── core/
│   ├── constants/
│   ├── utils/
│   └── storage/
│
├── data/
│   ├── datasources/
│   ├── models/
│   └── repositories/
│
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
│
├── presentation/
│   ├── login/
│   ├── register_student/
│   ├── student_list/
│   └── student_detail/
│
└── main.dart
```

---

## ▶️ Getting Started

### 1️⃣ Clone Repository

```bash
git clone https://github.com/fandiaspraja/Pmb-App.git
```

### 2️⃣ Install Dependencies

```bash
flutter pub get
```

### 3️⃣ Run Application

```bash
flutter run
```

---

## 🔑 Dummy Login Credentials

| Email                                   | Password |
| --------------------------------------- | -------- |
| [admin@test.com](mailto:admin@test.com) | 123456   |

---

## 📦 Deliverables

- ✅ Source Code (Public GitHub Repository)
- ✅ APK File
- ✅ Demo Video (YouTube)

🎥 **Demo Video:**
[https://youtu.be/mMvvL7a7MNg](https://youtu.be/mMvvL7a7MNg)

---

## ⏱ Development Timeline

- **Duration:** 5 days (including weekend)
- **Deadline:** 20 January 2026

---

## 🔗 Submission Link

👉 [https://bit.ly/PengumpulanTahap3StafIT](https://bit.ly/PengumpulanTahap3StafIT)

---

## 🧠 Key Highlights

- Clean Architecture implementation
- Scalable state management using Bloc
- Production-style folder structure
- Readable, maintainable, and testable code

---

## 🙌 Closing

Thank you for the opportunity to complete this technical test.

This project reflects my approach to building maintainable mobile applications with:

- clean structure
- clear separation of responsibility
- readiness for future scaling

---

## 👨‍💻 Author

**Fikry Andias Praja**
Mobile Developer
_(Flutter • Android)_
