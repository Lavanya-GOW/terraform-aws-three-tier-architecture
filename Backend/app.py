from flask import Flask, Response
import os
import redis
from prometheus_client import Counter, Histogram, generate_latest, Gauge, CONTENT_TYPE_LATEST  # type: ignore[import]
import time

REQUEST_COUNT = Counter("http_requests_total", "Total HTTP Requests", ["method", "endpoint", "http_status"])
REQUEST_LATENCY = Histogram("http_request_duration_seconds", "HTTP Request Latency", ["method", "endpoint"])
ACTIVE_REQUESTS = Gauge("active_requests", "Number of Active Requests")

redis_client = redis.Redis(
    host=os.getenv("REDIS_HOST", "localhost"),
    port=int(os.getenv("APP_REDIS_PORT", 6379)),
    decode_responses=True
)
app = Flask(__name__)

@app.route("/")
def home():
    ACTIVE_REQUESTS.inc()
    start_time = time.time()

    try:
        REQUEST_COUNT.labels(method="GET", endpoint="/", http_status=200).inc()
        count = redis_client.incr("visitor_count")
    except Exception as e:
        return f"Error occurred: {str(e)}"

    finally:
        latency = time.time() - start_time
        REQUEST_LATENCY.observe(latency)
        ACTIVE_REQUESTS.dec()
    return f"""
    <h1>AWS Production Flask App!</h1>
    <p>Visitor count: {count}</p>
    <p>Backend App is running on port 5000</p>
    """

@app.route("/health")
def health():
    try:
        redis_client.ping()
        return "Application Healthy"
    except Exception as e:
        return f"Application Unhealthy: {str(e)}"

@app.route("/about")
def about():
    return "Built by Harshu during Cloud Engineering Journey"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)

@app.route("/metrics")
def metrics():
    return Response(generate_latest(), 200, {"Content-Type": CONTENT_TYPE_LATEST})