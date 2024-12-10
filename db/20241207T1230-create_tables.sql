create table if not exists users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username VARCHAR(60) NOT NULL, 
    password VARCHAR(60) NOT NULL,
    api_key VARCHAR(40)
); 

create table if not exists channels (
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    name VARCHAR(100) NOT NULL
); 

create table if not exists messages (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    channel_id INTEGER NOT NULL,
    body TEXT NOT NULL,
    reply_to INTEGER,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(channel_id) REFERENCES channels(id),
    FOREIGN KEY(reply_to) REFERENCES messages(id)
);

create table if not exists reactions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    emoji TEXT NOT NULL,
    message_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    FOREIGN KEY(message_id) REFERENCES messages(id), 
    FOREIGN KEY(user_id) REFERENCES users(id) 
); 

create table if not exists user_message_read (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    message_id INTEGER NOT NULL, 
    read_at DATETIME DEFAULT CURRENT_TIMESTAMP, 
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(message_id) REFERENCES messages(id)
); 