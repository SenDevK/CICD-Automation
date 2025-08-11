from flask import Flask, jsonify
from flask_cors import CORS

app = Flask(__name__)
# Enable Cross-Origin Resource Sharing (CORS) to allow the frontend to call the API
CORS(app)

@app.route('/api/message')
def get_message():
    message = {"text": "Hello from the Python Backend API!"}
    return jsonify(message)

if __name__ == '__main__':
    # Run the app on host 0.0.0.0 to make it accessible from outside the container
    app.run(host='0.0.0.0', port=5000)
