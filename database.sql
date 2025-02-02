-- Create tables

create table ENTRY(
dateAndTime datetime(0) primary key, -- ex: 2025-02-01 14:15:30 which is: Feburary 1 2025, 2:15:30pm
foreign key (moodID) references MOOD(moodID) on update cascade,
foreign key (emotionID) references EMOTION(emotionID) on update cascade,
journalEntry text,
foreign key (quoteID) references QUOTE(quoteID) on update cascade, -- is QUOTE a keyword
foreign key (promptID) references PROMPT(promptID) on update cascade,
promptEntry text
);

create table MOOD( -- ID is 1 to 5, most sad to most happy
moodID tinyint primary key,
name tinytext
);

create table EMOTION(
emotionID tinyint primary key,
name tinytext
);

create table QUOTE(
quoteID int primary key,
foreign key (moodID) references MOOD(moodID) on update cascade,
name text
);

create table PROMPT(
promptID int primary key,
foreign key (emotionID) references EMOTION(emotionID) on update cascade,
name text
);

-- Input data

insert into MOOD values
(1, 'very sad'),
(2, 'sad'),
(3, 'neutral'),
(4, 'happy'),
(5, 'very happy');

insert into EMOTION values
(01, 'angry'),
(02, 'anxious'),
(03, 'annoyed'),
(04, 'depressed'),
(05, 'excited'),
(06, 'happy'),
(07, 'lonely'),
(08, 'proud'),
(09, 'relaxed'),
(10, 'sad'),
(11, 'stressed'),
(12, 'tired');

insert into QUOTE values
(0001, 1, 'Sometimes, the darkest times can bring us to the brightest places.'),
(0002, 1, 'You have power over your mind—not outside events. Realize this, and you will find strength.'),
(0003, 1, 'Even the darkest night will end, and the sun will rise.'),
(0004, 1, 'It’s okay to feel sad. What’s not okay is to let it define you forever.'),
(0005, 1, 'You are stronger than you think, and this too shall pass.'),
(0006, 2, 'The way I see it, if you want the rainbow, you gotta put up with the rain.'),
(0007, 2, 'Tough times never last, but tough people do.'),
(0008, 2, 'Do not let what you cannot do interfere with what you can do.'),
(0009, 2, 'You were given this life because you are strong enough to live it.'),
(0010, 2, 'Even in the midst of winter, I found there was, within me, an invincible summer.'),
(0011, 3, 'Do what you can, with what you have, where you are.'),
(0012, 3, 'Every day is a new beginning. Take a deep breath, smile, and start again.'),
(0013, 3, 'Happiness is not something ready-made. It comes from your own actions.'),
(0014, 3, 'Small steps in the right direction can turn out to be the biggest steps of your life.'),
(0015, 3, 'Act as if what you do makes a difference. It does.'),
(0016, 4, 'The purpose of our lives is to be happy.'),
(0017, 4, 'Happiness is not by chance, but by choice.'),
(0018, 4, 'Enjoy the little things, for one day you may look back and realize they were the big things.'),
(0019, 4, 'Happiness is a journey, not a destination.'),
(0020, 4, 'The best way to cheer yourself up is to try to cheer someone else up.'),
(0021, 5, 'Do more of what makes you happy.'),
(0022, 5, 'The only way to do great work is to love what you do.'),
(0023, 5, 'Joy is not in things; it is in us.'),
(0024, 5, 'Happiness is contagious. Spread it everywhere you go.'),
(0025, 5, 'Live life to the fullest, and focus on the positive.');

insert into PROMPT values
(0001, 01, 'What triggered your anger today? How can you respond differently next time?'),
(0002, 01, 'Write a letter to the source of your anger, but don’t send it. What would you say if there were no consequences?'),
(0003, 02, 'What is one thing causing you anxiety right now? Is it within your control?'),
(0004, 02, 'Imagine your future self looking back at this moment. What advice would they give you?'),
(0005, 03, 'What happened today that frustrated you? Was it truly a big deal, or is there a deeper reason for your irritation?'),
(0006, 03, 'How can you turn today’s annoyance into an opportunity for patience and growth?'),
(0007, 04, 'What is one small act of kindness you can do for yourself today?'),
(0008, 04, 'If your sadness could speak, what would it say? How can you respond to it with compassion?'),
(0009, 05, 'What is making you excited today? How can you hold onto this feeling longer?'),
(0010, 05, 'Write about a time when you felt this excited before. What similarities do you notice?'),
(0011, 06, 'Describe the happiest moment of your day. What made it special?'),
(0012, 06, 'How can you share your happiness with someone else today?'),
(0013, 07, 'What are three ways you can connect with someone, even if you feel alone?'),
(0014, 07, 'If loneliness were a person, what would it look like? How would you talk to it?'),
(0015, 08, 'What is one accomplishment you are proud of? How did you achieve it?'),
(0016, 08, 'Write a letter to your past self, acknowledging how far you’ve come.'),
(0017, 09, 'Describe the sensations of relaxation in your body right now. What led you to feel this way?'),
(0018, 09, 'What are three things you can do to cultivate more relaxation in your daily life?'),
(0019, 10, 'If your sadness was a color, what would it be? Why?'),
(0020, 10, 'What is one comforting thing you can tell yourself right now?'),
(0021, 11, 'List everything on your mind. Now, categorize them into “within my control” and “outside my control.” What can you let go of?'),
(0022, 11, 'What is one thing you can do right now to take care of yourself?'),
(0023, 12, 'What is draining your energy the most? How can you recharge?'),
(0024, 12, 'Imagine yourself waking up tomorrow refreshed. What habits can you change to make that happen?');

insert into ENTRY values -- dateAndTime, moodID, emotionID, journalEntry, quoteID, promptID, promptEntry
('2025-02-01 18:30:15', 3, 6, 'Today I got to do a hackathon with my friends!', 1, 16, 'To my past self...');