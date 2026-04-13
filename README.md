# DevTrack – Build in Public Platform

DevTrack is a full-stack developer platform that allows users to **build in public**, share their projects, track progress, collaborate, and celebrate completed work.

The system is designed to encourage transparency, learning, and collaboration among developers.

---

## 🌟 Features

### 👤 User Management

* Register a new account
* Login with existing credentials
* Logout functionality

### 📁 Project Management

* Create a project with:

  * Title
  * Description
  * Stage (Idea, Development, Testing, Completed)
  * Visibility (Public / Private)
* Update project stage dynamically
* Track progress over time

###  Public Feed

* View all public projects created by other developers
* See project stages and descriptions
* Live refresh when new projects are added

### 🔒 Private Projects

* View your own private projects
* Only visible to the project owner

### 🤝 Collaboration

* Developers can view what others are working on
* Foundation ready for collaboration requests

### 🎉 Celebration Wall

* Mark a project as **Completed**
* Display completed projects on a shared celebration wall

---

## 🛠️ Tech Stack

### Frontend

* Flutter (Web / Mobile ready)
* Material UI
* Dart

### Backend

* Node.js
* Express.js

### Database

* MySQL (via MySQL Workbench)

---

## 🏗️ Project Structure

```
devtrack_app/
│
├── backend/
│   ├── server.js
│   ├── db.js
│   └── routes/
│       ├── auth.js
│       └── projects.js
│
├── lib/
│   ├── screens/
│   │   ├── login.dart
│   │   ├── register.dart
│   │   ├── home.dart
│   │   ├── create_project.dart
│   │   ├── celebration.dart
│   │   └── private_projects.dart
│   │
│   └── services/
│       └── api.dart
```

---

## 🗄️ Database Schema

Main tables:

* **users**
* **projects**
* **updates**
* **comments**
* **collaboration_requests**

Key feature:

* Projects include a `visibility` field (`public` / `private`)

---

## ⚙️ How to Run the Project

### 1. Backend Setup

```bash
cd backend
npm install
node server.js
```

Server runs on:

```
http://localhost:3000
```

---

### 2. Database Setup

* Open MySQL Workbench
* Run the provided SQL script
* Ensure database name is:

```
devtrack
```
connect and add your password
---

### 3. Flutter Setup

```bash
flutter pub get
flutter run
```

If running on web (Edge/Chrome):

```
http://localhost:3000
```

---

## 🔌 API Endpoints

### Auth

* `POST /auth/register`
* `POST /auth/login`

### Projects

* `GET /projects` → Public projects
* `POST /projects/create`
* `PUT /projects/update-stage/:id`
* `GET /projects/private/:userId`
* `GET /projects/completed`

---

## 🎨 Design Theme

* Black (background)
* Green (primary accent)
* White (text)

---

## 🧠 Key Concepts Demonstrated

* Full-stack development
* REST API design
* State management in Flutter
* Database integration
* CRUD operations
* User-based data filtering
* Build-in-public concept

---


---

## 👨‍💻 Author

**Itumeleng More**
Software Developer | Computer Science & Informatics Graduate

Passionate about building scalable, user-focused applications and exploring modern technologies including mobile development, backend systems, and AI-driven solutions.

---

## 📌 Notes

This project was built as part of a practical assignment to demonstrate:

* Application design
* Backend architecture
* User interaction workflows
* Real-world development practices

---


