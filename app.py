import sqlite3
from flask import Flask, request, jsonify
from flask_cors import CORS  # ✅ Import CORS

app = Flask(__name__)
CORS(app)  # ✅ Enable CORS for all routes

DATABASE = "mental_health.db"

# Function to connect to SQLite
def get_db_connection():
    conn = sqlite3.connect(DATABASE)
    conn.row_factory = sqlite3.Row
    return conn

# Load database.sql into SQLite
def initialize_database():
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("PRAGMA foreign_keys = ON;")  # ✅ Enable foreign key support in SQLite

    with open("database.sql", "r") as f:
        sql_script = f.read()

    try:
        cursor.executescript(sql_script)  # Execute SQL file
        conn.commit()
    except sqlite3.OperationalError as e:
        print("Error executing script:", e)

    conn.close()

# set up the database
initialize_database()

# test route to check if Flask is running
@app.route("/", methods=["GET"])
def home():
    return jsonify({"message": "Flask server is running!"})

# Fetch all moods
@app.route("/moods", methods=["GET"])
def get_moods():
    conn = get_db_connection()
    moods = conn.execute("SELECT * FROM MOOD").fetchall()
    conn.close()
    return jsonify([{"moodID": row["moodID"], "name": row["name"]} for row in moods])

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


# Start the Flask app
if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=5000)