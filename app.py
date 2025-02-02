import sqlite3
import random
from flask import Flask, request, jsonify
from flask_cors import CORS
import os
import time  # Importing the time module to use time.time()

app = Flask(__name__)
CORS(app)  # This should be enough, but add headers manually if needed

@app.after_request
def add_cors_headers(response):
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Access-Control-Allow-Methods"] = "GET, POST, PUT, DELETE, OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "Content-Type, Authorization"
    return response

DATABASE = "mental_health.db"

# Function to connect to SQLite
def get_db_connection():
    conn = sqlite3.connect(DATABASE)
    conn.row_factory = sqlite3.Row
    return conn

# Load database.sql into SQLite
def initialize_database():
    # Check if the database exists first
    if not os.path.exists(DATABASE):
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("PRAGMA foreign_keys = ON;")  #Enable foreign key support in SQLite

        with open("database.sql", "r") as f:
            sql_script = f.read()

        try:
            cursor.executescript(sql_script)  # Execute SQL file
            conn.commit()
        except sqlite3.OperationalError as e:
            print("Error executing script:", e)

        conn.close()

# Set up the database only if not already initialized
initialize_database()

# Test route to check if Flask is running
@app.route("/", methods=["GET"])
def home():
    return jsonify({"message": "Flask server is running!"})

# Fetch all moods
@app.route('/get-mood-name', methods=['GET'])
def get_mood_name():
    mood_id = request.args.get('moodID')  # Get moodID from request parameters

    if not mood_id:
        return jsonify({"error": "moodID is required"}), 400  # Error if no moodID is provided

    conn = get_db_connection()
    cursor = conn.cursor()

    # Fetch the mood name for the given moodID
    cursor.execute("SELECT name FROM MOOD WHERE moodID = ?", (mood_id,))
    mood = cursor.fetchone()  # Fetch one result
    conn.close()

    if not mood:
        return jsonify({"error": "Mood not found"}), 404  # If no mood is found, return error

    return jsonify({"name": mood["name"]})  # Return the mood name

@app.route('/entries', methods=['GET'])
def get_past_entries():
    conn = get_db_connection()
    cursor = conn.cursor()
    query = """
    SELECT dateAndTime, moodID, journalEntry FROM ENTRY ORDER BY dateAndTime DESC
    """
    cursor.execute(query)
    entries = cursor.fetchall()
    conn.close()

    return jsonify([
        {"dateAndTime": row["dateAndTime"], "moodID": row["moodID"], "journalEntry": row["journalEntry"]}
        for row in entries
    ])

# Get a random quote based on moodID
@app.route("/random-quote", methods=["GET"])
def get_random_quote():
    mood_id = request.args.get("moodID")  # Get moodID from request parameters

    if not mood_id:
        return jsonify({"error": "moodID is required"}), 400  # Error if no moodID is provided

    conn = get_db_connection()
    cursor = conn.cursor()

    # Fetch all quotes for the given mood
    cursor.execute("SELECT name FROM QUOTE WHERE moodID = ?", (mood_id,))
    quotes = cursor.fetchall()
    conn.close()

    if not quotes:
        return jsonify({"error": "No quotes found for this mood"}), 404  # Return error if no quotes exist

    # Pick a random quote
    random_quote = random.choice(quotes)["name"]

    return jsonify({"quote": random_quote})  # Return the selected quote

# Fetch a random journal prompt based on emotionID
@app.route("/random-prompt", methods=["GET"])
def get_random_prompt():
    emotion_id = request.args.get("emotionID")  # Get emotionID from request parameters

    if not emotion_id:
        return jsonify({"error": "emotionID is required"}), 400  # Error if no emotionID is provided

    conn = get_db_connection()
    cursor = conn.cursor()

    # Fetch all prompts for the given emotion
    cursor.execute("SELECT name FROM PROMPT WHERE emotionID = ?", (emotion_id,))
    prompts = cursor.fetchall()
    conn.close()

    if not prompts:
        return jsonify({"error": "No prompts found for this emotion"}), 404  # Return error if no prompts exist

    # Pick a random prompt
    random_prompt = random.choice(prompts)["name"]

    return jsonify({"prompt": random_prompt})  # Return the selected prompt


@app.route("/submit-entry", methods=["POST"])
def submit_entry():
    try:
        data = request.get_json()
        mood_id = data.get("moodID")
        emotion_id = data.get("emotionID")
        journal_entry = data.get("journalEntry")

        if not mood_id or not emotion_id or not journal_entry:
            return jsonify({"error": "Missing data: moodID, emotionID, and journalEntry are required."}), 400

        conn = get_db_connection()
        cursor = conn.cursor()

        # Insert the journal entry into the database, including the current timestamp
        cursor.execute(
            "INSERT INTO ENTRY (moodID, emotionID, journalEntry, dateAndTime) VALUES (?, ?, ?, ?)",
            (mood_id, emotion_id, journal_entry, int(time.time()))  # Save current timestamp
        )
        conn.commit()
        conn.close()

        return jsonify({"message": "Journal entry successfully submitted."}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500

# Start the Flask app
if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=5002)
