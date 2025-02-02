PRAGMA foreign_keys = ON;

-- Drop existing tables if they exist
DROP TABLE IF EXISTS ENTRY;
DROP TABLE IF EXISTS QUOTE;
DROP TABLE IF EXISTS PROMPT;
DROP TABLE IF EXISTS EMOTION;
DROP TABLE IF EXISTS MOOD;

-- Create Tables
CREATE TABLE ENTRY (
    dateAndTime TEXT PRIMARY KEY, -- Use TEXT instead of DATETIME
    moodID INTEGER,
    emotionID INTEGER,
    journalEntry TEXT,
    quoteID INTEGER,
    promptID INTEGER,
    promptEntry TEXT,
    FOREIGN KEY (moodID) REFERENCES MOOD(moodID) ON UPDATE CASCADE,
    FOREIGN KEY (emotionID) REFERENCES EMOTION(emotionID) ON UPDATE CASCADE,
    FOREIGN KEY (quoteID) REFERENCES QUOTE(quoteID) ON UPDATE CASCADE,
    FOREIGN KEY (promptID) REFERENCES PROMPT(promptID) ON UPDATE CASCADE
);

CREATE TABLE MOOD (
    moodID INTEGER PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE EMOTION (
    emotionID INTEGER PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE QUOTE (
    quoteID INTEGER PRIMARY KEY,
    moodID INTEGER,
    name TEXT NOT NULL,
    FOREIGN KEY (moodID) REFERENCES MOOD(moodID) ON UPDATE CASCADE
);

CREATE TABLE PROMPT (
    promptID INTEGER PRIMARY KEY,
    emotionID INTEGER,
    name TEXT NOT NULL,
    FOREIGN KEY (emotionID) REFERENCES EMOTION(emotionID) ON UPDATE CASCADE
);

-- Insert Data
INSERT INTO MOOD VALUES
(1, 'very sad'),
(2, 'sad'),
(3, 'neutral'),
(4, 'happy'),
(5, 'very happy');

INSERT INTO EMOTION VALUES
(1, 'angry'),
(2, 'anxious'),
(3, 'annoyed'),
(4, 'depressed'),
(5, 'excited'),
(6, 'happy'),
(7, 'lonely'),
(8, 'proud'),
(9, 'relaxed'),
(10, 'sad'),
(11, 'stressed'),
(12, 'tired');

INSERT INTO QUOTE VALUES
(1, 1, 'Sometimes, the darkest times can bring us to the brightest places.'),
(2, 1, 'You have power over your mind—not outside events. Realize this, and you will find strength.'),
(3, 1, 'Even the darkest night will end, and the sun will rise.'),
(4, 1, 'It’s okay to feel sad. What’s not okay is to let it define you forever.'),
(5, 1, 'You are stronger than you think, and this too shall pass.'),
(6, 2, 'The way I see it, if you want the rainbow, you gotta put up with the rain.'),
(7, 2, 'Tough times never last, but tough people do.'),
(8, 2, 'Do not let what you cannot do interfere with what you can do.'),
(9, 2, 'You were given this life because you are strong enough to live it.'),
(10, 2, 'Even in the midst of winter, I found there was, within me, an invincible summer.'),
(11, 3, 'Do what you can, with what you have, where you are.'),
(12, 3, 'Every day is a new beginning. Take a deep breath, smile, and start again.'),
(13, 3, 'Happiness is not something ready-made. It comes from your own actions.'),
(14, 3, 'Small steps in the right direction can turn out to be the biggest steps of your life.'),
(15, 3, 'Act as if what you do makes a difference. It does.'),
(16, 4, 'The purpose of our lives is to be happy.'),
(17, 4, 'Happiness is not by chance, but by choice.'),
(18, 4, 'Enjoy the little things, for one day you may look back and realize they were the big things.'),
(19, 4, 'Happiness is a journey, not a destination.'),
(20, 4, 'The best way to cheer yourself up is to try to cheer someone else up.'),
(21, 5, 'Do more of what makes you happy.'),
(22, 5, 'The only way to do great work is to love what you do.'),
(23, 5, 'Joy is not in things; it is in us.'),
(24, 5, 'Happiness is contagious. Spread it everywhere you go.'),
(25, 5, 'Live life to the fullest, and focus on the positive.');

INSERT INTO PROMPT VALUES
(1, 1, 'What triggered your anger today? How can you respond differently next time?'),
(2, 1, 'Write a letter to the source of your anger, but don’t send it. What would you say if there were no consequences?'),
(3, 2, 'What is one thing causing you anxiety right now? Is it within your control?'),
(4, 2, 'Imagine your future self looking back at this moment. What advice would they give you?'),
(5, 3, 'What happened today that frustrated you? Was it truly a big deal, or is there a deeper reason for your irritation?'),
(6, 3, 'How can you turn today’s annoyance into an opportunity for patience and growth?'),
(7, 4, 'What is one small act of kindness you can do for yourself today?'),
(8, 4, 'If your sadness could speak, what would it say? How can you respond to it with compassion?'),
(9, 5, 'What is making you excited today? How can you hold onto this feeling longer?'),
(10, 5, 'Write about a time when you felt this excited before. What similarities do you notice?'),
(11, 6, 'Describe the happiest moment of your day. What made it special?'),
(12, 6, 'How can you share your happiness with someone else today?'),
(13, 7, 'What are three ways you can connect with someone, even if you feel alone?'),
(14, 7, 'If loneliness were a person, what would it look like? How would you talk to it?'),
(15, 8, 'What is one accomplishment you are proud of? How did you achieve it?'),
(16, 8, 'Write a letter to your past self, acknowledging how far you have come.'),
(17, 9, 'Describe the sensations of relaxation in your body right now. What led you to feel this way?'),
(18, 9, 'What are three things you can do to cultivate more relaxation in your daily life?'),
(19, 10, 'If your sadness was a color, what would it be? Why?'),
(20, 10, 'What is one comforting thing you can tell yourself right now?'),
(21, 11, 'List everything on your mind. Now, categorize them into “within my control” and “outside my control.” What can you let go of?'),
(22, 11, 'What is one thing you can do right now to take care of yourself?'),
(23, 12, 'What is draining your energy the most? How can you recharge?'),
(24, 12, 'Imagine yourself waking up tomorrow refreshed. What habits can you change to make that happen?');

INSERT INTO ENTRY (dateAndTime, moodID, emotionID, journalEntry, quoteID, promptID, promptEntry)
VALUES ('2025-02-01 18:30:15', 3, 6, 'This is an example entry', 1, 16, 'To my past self...');