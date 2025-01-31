FROM python:3.12-slim

RUN mkdir /app

WORKDIR /app

COPY . .

RUN pip install -r requirements.txt

ENTRYPOINT python /app/main.py
