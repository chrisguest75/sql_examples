
CREATE TABLE IF NOT EXISTS public.status
(
    id integer NOT NULL,
    name text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT status_pkey PRIMARY KEY (id)
)

