CREATE TABLE IF NOT EXISTS public.pool
(
    id integer NOT NULL,
    name text COLLATE pg_catalog."default" NOT NULL,
    desired_capacity integer NOT NULL,
    CONSTRAINT pool_pkey PRIMARY KEY ("id")
)

