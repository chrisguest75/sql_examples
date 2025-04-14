
CREATE SCHEMA public AUTHORIZATION postgres;

CREATE TABLE public.transcripts (
	id serial4 NOT NULL PRIMARY KEY,
	filename varchar NOT NULL,
	created_on timestamp DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE public.wordType (
	id serial2 not null PRIMARY KEY,
	"type" varchar NOT NULL
);

CREATE TABLE public.words (
	id serial4 not NULL PRIMARY KEY,
    -- foreign key to transcripts table 
	transcriptId serial4 references transcripts(id),
	word varchar NOT NULL,
	type serial2 references wordType(id),
    start_time float8 NOT NULL,
    end_time float8 NOT NULL,
    speaker int2 NOT NULL
);

INSERT INTO public.wordType ("type") VALUES ('punctuation');
INSERT INTO public.wordType ("type") VALUES ('word');
INSERT INTO public.wordType ("type") VALUES ('silence');