import os 
import sqlite3
from flask import Flask, request, g 
    # ks note to self: g is a special global variable used to sustain db connection

app = Flask(__name__)

DATABASE = os.path.join(os.path.dirname(__file__), 'db', 'belay.sqlite3') 

def get_db():     #https://flask.palletsprojects.com/en/stable/patterns/sqlite3/
    db = getattr(g, '_database', None)
    if db is None: 
        db = g._database = sqlite3.connect(DATABASE)
    db.row_factory = sqlite3.Row 
    return db


@app.route("/")
def home():
    return "Welcome to Belay!"

# -------------------------------- DB ---------------------------------------- 
@app.route("/setup")
def setup(): 
    db = get_db()
    sql_file_path = os.path.join(os.path.dirname(__file__), 'db', '20241207T1230-create_tables.sql')
    with open(sql_file_path) as f: 
        db.executescript(f.read())
    db.commit()
    return "Database setup complete!"

@app.teardown_appcontext    #https://flask.palletsprojects.com/en/stable/patterns/sqlite3/
def close_connection(exception): 
    db = getattr(g, '_database', None)
    if db is not None: 
        db.close() 


# -------------------------------- HTML PATHS -------------------------------- 

@app.route("/addchannel", methods=['POST'])
def add_channel(): 
    db = get_db 
    channel_name = request.form['name']
    try: 
        db.execute("INSERT INTO channels (name) VALUES (?)", (channel_name))
        db.commit() 
    except sqlite3.IntegrityError: 
        return "Channel name must be unique", 400
    return "Channel added!", 201

# -------------------------------- API ROUTES --------------------------------

if __name__ == "__main__": 
    app.run(debug=True)