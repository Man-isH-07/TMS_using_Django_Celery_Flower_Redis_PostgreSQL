FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        libpq-dev \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir \
    Django==5.1.4 \
    djangorestframework \
    celery \
    django-celery-beat \
    django-celery-results \
    django-crontab \
    django-redis \
    redis \
    psycopg2-binary \
    flower

COPY . /app

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
