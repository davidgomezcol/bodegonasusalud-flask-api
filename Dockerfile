FROM python:3.10.3-slim-buster

ENV PYTHONUNBUFFERED=1

ENV PATH="/usr/local/pgsql/bin:${PATH}"

WORKDIR /usr/src/flask_api

COPY requirements.txt requirements.txt

RUN pip install --upgrade pip

RUN apt-get upgrade -y && apt-get update -y && apt-get install gcc -y

RUN apt-get install python3-dev libpq-dev wget make -y

RUN apt-get update && apt-get install -y build-essential libreadline-dev zlib1g-dev

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 9000
EXPOSE 5678
