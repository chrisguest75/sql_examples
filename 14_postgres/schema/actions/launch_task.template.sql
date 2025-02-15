-- launch_task
INSERT INTO public.tasks("pool_id","container_id","status_id") 
VALUES (${POOL_ID}, '${CONTAINER_ID}', ${STATUS_ID});