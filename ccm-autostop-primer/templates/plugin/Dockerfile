FROM python:3.12-slim

RUN mkdir /app

WORKDIR /app

COPY . .

RUN pip install --no-cache-dir -r requirements.txt

RUN groupadd -r appuser && useradd -r -g appuser -m -s /bin/bash appuser
USER appuser

ENTRYPOINT ["python", "/app/main.py"]
