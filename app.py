from flask import Flask
import os
import redis

redis_client = redis.Redis(
    host=os.getenv("REDIS_HOST", "localhost"),
    port=int(os.getenv("REDIS_PORT", 6379)),
    decode_responses=True
)
app = Flask(__name__)

@app.route("/")
def home():
    count = redis_client.incr("visitor_count")
    return f"""
    <h1>AWS Production Flask App!</h1>
    <p>Visitor count: {count}</p>
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
