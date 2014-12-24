CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(20) NOT NULL,
  lname VARCHAR(20) NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255),
  body TEXT,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_followers (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  questions_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (questions_id) REFERENCES questions(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  reply TEXT,
  questions_id INTEGER NOT NULL,
  parent_reply_id INTEGER,
  replier_id INTEGER NOT NULL,

  FOREIGN KEY (questions_id) REFERENCES questions(id),
  FOREIGN KEY (parent_reply_id) REFERENCES replies(id),
  FOREIGN KEY (replier_id) REFERENCES users(id)
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  questions_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (questions_id) REFERENCES questions(id)
);


INSERT INTO
  users (fname, lname)
VALUES
  ('John', 'Doe'),
  ('Velina', 'Veleva'),
  ('Dana', 'Yakoobinsky');

INSERT INTO
  questions (title, body, user_id)
VALUES
  ('Sup?', 'Hows it going?', (SELECT id FROM users WHERE id = 2)),
  ('Yo!', 'Hows it?', (SELECT id FROM users WHERE id = 2)),
  ('Question2?', 'Meh', (SELECT id FROM users WHERE id = 1));

INSERT INTO
  question_followers (user_id, questions_id)
VALUES
  (1, 2),
  (3, 1),
  (2,2);

INSERT INTO
  replies (reply, questions_id, parent_reply_id, replier_id)
VALUES
  ('awesome', 1, null, 3),
  ('blahblah', 1, 1, 2),
  ('awesome', 2, null, 1);

INSERT INTO
  question_likes (user_id, questions_id)
VALUES
  (1,2),
  (3,1),
  (2,1);
