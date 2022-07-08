FROM python:3.5-slim AS builder
WORKDIR /app
COPY requirements.txt ./
RUN python3 -m venv venv 
ENV PATH=/app/venv/bin/:$PATH
RUN pip install -r requirements.txt
COPY . ./

FROM gcr.io/distroless/python3
COPY --from=builder /app /app
WORKDIR /app/api
ENV ENVIRONMENT="production"
ENV PYTHONUNBUFFERED=1
ENV PORT="8080"
ENV PYTHONPATH=/app/venv/lib/python3.5/site-packages
ENV PATH=/app/venv/bin/:$PATH
CMD ["wsgi.py"]
