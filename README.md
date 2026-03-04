# Task Management System (TMS)

A learning project built with Django, Django REST Framework, Celery, Redis, and PostgreSQL. This app provides a basic task manager with authentication, task scheduling, caching, and background jobs (email summaries, scheduled task activation).

**Why this exists**
This is a personal learning project to understand Django, Celery, Flower, caching, and scheduling.

## Features
- User authentication (register, login, logout)
- Task CRUD from the UI
- Task scheduling (scheduled tasks become ongoing when time arrives)
- Task status toggle (ongoing/completed)
- Redis-backed session storage and caching
- Celery worker + Celery Beat for background tasks
- Email summaries for users
- Simple JSON API endpoint

## Tech Stack
- Django 5.1
- Django REST Framework
- Celery + Celery Beat
- Redis (broker, cache, sessions)
- PostgreSQL
- Flower (optional monitoring)

## Project Layout
- `core/` Django project settings, URLs, Celery config
- `task/` Task app (models, views, celery tasks, templates)
- `task/templates/` HTML templates
- `task/static/` Static assets
- `OutputsImages/` Screenshots

## Prerequisites
- Python 3.12
- PostgreSQL
- Redis

## Configuration
Update these settings in `core/settings.py` for your local environment:
- Database connection: `DATABASES`
- Redis URL: `CELERY_BROKER_URL`, `CELERY_RESULT_BACKEND`, and `CACHES`
- Email settings: `EMAIL_HOST_USER`, `EMAIL_HOST_PASSWORD`

Security note: secrets are currently hard-coded in `core/settings.py`. Move them to environment variables before any real deployment.

## Local Setup
1. Create and activate a virtual environment.
2. Install dependencies:

```bash
pip install Django==5.1.4 djangorestframework celery django-celery-beat django-celery-results django-crontab django-redis redis psycopg2-binary flower
```

3. Run migrations:

```bash
python manage.py migrate
```

4. Create an admin user (optional):

```bash
python manage.py createsuperuser
```

5. Start the Django server:

```bash
python manage.py runserver
```

6. Start Redis in another terminal:

```bash
redis-server
```

7. Start Celery worker:

```bash
celery -A core worker -l info
```

8. Start Celery Beat:

```bash
celery -A core beat -l info
```

9. (Optional) Start Flower:

```bash
celery -A core flower -l info
```

## Routes
- `GET /home/` Main task list + create form
- `GET /login/` Login page
- `POST /login/` Login action
- `GET /register/` Register page
- `POST /register/` Register action
- `GET /logout/` Logout
- `GET /get/` Return tasks as JSON
- `POST /home/` Create task
- `GET /update/<id>/` Update form
- `POST /update/<id>/` Save updates
- `GET /delete/<id>/` Delete task
- `GET /update_status/<id>/` Toggle task status
- `GET /trigger-task/` Trigger Celery test task
- `GET /sent_mail` Trigger email job
- `GET /view_session/` Inspect session data
- `GET /admin/` Django admin

## Background Jobs
Celery Beat schedules are defined in `core/settings.py` and `core/celery.py`. They currently run every 1-5 minutes for testing. Adjust to real weekly schedules before production use.

## Docker
A basic `Dockerfile` is included. It builds the Django app but expects PostgreSQL and Redis to be reachable from the container. Because the current settings use `localhost`, you must update `core/settings.py` or run the container with appropriate networking.

Build:

```bash
docker build -t tms-app .
```

Run (example):

```bash
docker run --rm -p 8000:8000 tms-app
```

For a full Docker setup, add a `docker-compose.yml` with PostgreSQL and Redis and update `core/settings.py` to use those service hosts.

## Notes
- `django-crontab` is installed but not configured.
- `db.sqlite3` exists but the app is configured for PostgreSQL.

## Screenshots
See `OutputsImages/` for UI and API screenshots.
