# Blog Application

This is a full-stack Blog Application with a Django backend and a Flutter frontend.

## Project Structure

```
BLOG-APPLICATION/
  backend/    # Django REST API
  frontend/   # Flutter app (mobile/web/desktop)
```

---

## Backend (Django)

### Setup
1. Navigate to the backend directory:
   ```bash
   cd backend
   ```
2. (Optional) Create and activate a virtual environment:
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```
3. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```
4. Run migrations:
   ```bash
   python manage.py migrate
   ```
5. Start the development server:
   ```bash
   python manage.py runserver
   ```

---

## Frontend (Flutter)

### Setup
1. Navigate to the frontend directory:
   ```bash
   cd frontend
   ```
2. Get dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   - For mobile:
     ```bash
     flutter run
     ```
   - For web:
     ```bash
     flutter run -d chrome
     ```

---

## Features
- User authentication (JWT)
- Create, read, update, and delete blog posts
- Responsive UI for web and mobile

---

## License
This project is licensed under the MIT License. 