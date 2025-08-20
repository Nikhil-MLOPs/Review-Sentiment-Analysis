FROM python:3.10-slim

WORKDIR /app

# Copy requirements first (best for caching)
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

# Download NLTK data (optional)
RUN python -m nltk.downloader stopwords wordnet

# Copy app code
COPY flask_app/ /app/
COPY models/vectorizer.pkl /app/models/vectorizer.pkl

EXPOSE 5000

# Local dev
# CMD ["python", "app.py"]

# Production
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--timeout", "120", "app:app"]
