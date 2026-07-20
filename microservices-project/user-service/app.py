from flask import Flask

app = Flask(__name__)

@app.route("/users")
def users():
    return {
        "service": "User Service",
        "message": "User details retrieved successfully!"
    }

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5001)
