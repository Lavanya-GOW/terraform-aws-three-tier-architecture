from flask import Flask, Response
import os
import redis
import time
from prometheus_client import ( # pyright: ignore[reportMissingImports]
    Counter,
    Histogram,
    Gauge,
    generate_latest,
    CONTENT_TYPE_LATEST,
)

app = Flask(__name__)

# Prometheus Metrics
REQUEST_COUNT = Counter(
    "http_requests_total",
    "Total HTTP Requests",
    ["method", "endpoint", "http_status"],
)

REQUEST_LATENCY = Histogram(
    "http_request_duration_seconds",
    "HTTP Request Latency",
    ["method", "endpoint"],
)

ACTIVE_REQUESTS = Gauge(
    "active_requests",
    "Number of Active Requests",
)

# Redis Connection
redis_client = redis.Redis(
    host=os.getenv("REDIS_HOST", "localhost"),
    port=int(os.getenv("APP_REDIS_PORT", 6379)),
    decode_responses=True,
)


@app.route("/")
def home():
    ACTIVE_REQUESTS.inc()
    start_time = time.time()

    try:
        count = redis_client.incr("visitor_count")

        REQUEST_COUNT.labels(
            method="GET",
            endpoint="/",
            http_status="200"
        ).inc()

        return f"""
        <h1>AWS Production Flask App!</h1>
        <p>Visitor count: {count}</p>
        <p>Frontend App is running on port 5000</p>
        """

    except Exception as e:
        REQUEST_COUNT.labels(
            method="GET",
            endpoint="/",
            http_status="500"
        ).inc()

        return f"Error occurred: {str(e)}", 500

    finally:
        latency = time.time() - start_time

        REQUEST_LATENCY.labels(
            method="GET",
            endpoint="/"
        ).observe(latency)

        ACTIVE_REQUESTS.dec()


@app.route("/health")
def health():
    try:
        redis_client.ping()
        return "Application Healthy", 200
    except Exception as e:
        return f"Application Unhealthy: {str(e)}", 500


@app.route("/about")
def about():
    return "Built by Harshu during Cloud Engineering Journey"


@app.route("/metrics")
def metrics():
    return Response(
        generate_latest(),
        mimetype=CONTENT_TYPE_LATEST,
    )


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)