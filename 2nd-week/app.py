from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello():
    return {"message": "Hello, Flask!...you can actually do this."}

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=5500)