from flask import Flask

app = Flask(__name__)

@app.route("/products")
def products():
    return {
        "service": "Product Service",
        "message": "Product details retrieved successfully!"
    }

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5002)

