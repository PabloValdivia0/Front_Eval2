FROM python:3.9-slim AS builder

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

FROM python:3.9-slim

WORKDIR /app

RUN useradd -m -u 1000 appuser

COPY --from=builder /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin

COPY . .

RUN chown -R appuser:appuser /app
USER appuser

EXPOSE 5000

ENV PYTHONUNBUFFERED=1 \
    FLASK_ENV=production

