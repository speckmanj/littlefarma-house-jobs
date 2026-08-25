FROM python:3.11-slim

WORKDIR /mnt/apps/websites/

COPY house_jobs/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY house_jobs/ ./house_jobs/
COPY jobs_data.json ./jobs_data.json

# Create data volume for persistence
VOLUME ["/mnt/apps/websites/data"]

EXPOSE 26001

ENV FLASK_ENV=production

CMD ["gunicorn", "--bind", "0.0.0.0:26001", "--chdir", "house_jobs", "app:app"]