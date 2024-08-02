# Verwende ein offizielles Python-Image als Grundimage
FROM python:3.9-slim

# Installiere Build-Tools und Bibliotheken für die Kompilierung von C-Erweiterungen
RUN apt-get update && apt-get install -y \
    gcc \
    libffi-dev \
    libpq-dev \
    netcat-openbsd \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Setze das Arbeitsverzeichnis im Container
WORKDIR /app

# Füge die Python-Abhängigkeiten hinzu und installiere sie
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Kopiere den Rest der Anwendung in das Arbeitsverzeichnis
COPY . /app

# Führe das Entrypoint-Skript aus
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Expose den Port, der von der Anwendung verwendet wird
EXPOSE 8020
