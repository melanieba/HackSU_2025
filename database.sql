-- Create tableshyvyggvyugyvygv

create table ENTRY(
dateAndTime datetime(0) primary key, -- ex: 2025-02-01 14:15:30 which is: Feburary 1 2025, 2:15:30pm
foreign key (moodID) references MOOD(moodID) on update cascade,
foreign key (emotionID) references EMOTION(emotionID) on update cascade,
journalEntry text,
foreign key (quoteID) references QUOTE(quoteID) on update cascade, -- is QUOTE a keyword
foreign key (promptID) references PROMPT(promptID) on update cascade,
promptEntry text
);

create table MOOD( -- 1 to 5, most sad to most happy
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
(0002, 1, ''),
(0003, 1, ''),
(0004, 1, ''),
(0005, 1, ''),
(0006, 2, ''),
(0007, 2, ''),
(0008, 2, ''),
(0009, 2, ''),
(0010, 2, ''),
(0011, 3, ''),
(0012, 3, ''),
(0013, 3, ''),
(0014, 3, ''),
(0015, 3, ''),
(0016, 4, ''),
(0017, 4, ''),
(0018, 4, ''),
(0019, 4, ''),
(0020, 4, ''),
(0021, 5, ''),
(0022, 5, ''),
(0023, 5, ''),
(0024, 5, ''),
(0025, 5, '');