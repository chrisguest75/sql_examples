CREATE SEQUENCE IF NOT EXISTS tasks_id_seq START 1 INCREMENT 1;

CREATE TABLE IF NOT EXISTS public.tasks
(
    id integer NOT NULL DEFAULT nextval('tasks_id_seq'::regclass),
    pool_id integer NOT NULL,
    container_id text COLLATE pg_catalog."default" NOT NULL,
    unit_of_work_id text COLLATE pg_catalog."default" NULL,
    status_id integer NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    assigned_at TIMESTAMPTZ DEFAULT NULL,
    stopped_at TIMESTAMPTZ DEFAULT NULL,
    CONSTRAINT tasks_pkey PRIMARY KEY (id),
    CONSTRAINT unique_container_id UNIQUE (container_id),
    CONSTRAINT unique_unit_of_work_id UNIQUE (unit_of_work_id),
    CONSTRAINT fk_tasks_pool_id_to_pool_id FOREIGN KEY (pool_id)
    REFERENCES public.pool (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID,
    CONSTRAINT fk_tasks_status_id_to_status_id FOREIGN KEY (status_id)
    REFERENCES public.status (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID
)
