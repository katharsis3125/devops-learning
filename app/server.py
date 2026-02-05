import os
from flask import Flask, jsonify

app = Flask(__name__)

@app.get("/")
def root():
    return "ok\n"

@app.get("/health")
def health():
    return jsonify(status="ok"), 200

@app.get("/version")
def version():
    return jsonify(version=os.getenv("APP_VERSION", "dev")), 200

if __name__ == "__main__":
    port = int(os.getenv("PORT", "8080"))
    app.run(host="0.0.0.0", port=port)

