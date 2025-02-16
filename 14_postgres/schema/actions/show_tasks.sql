SELECT tasks.id, pool.name, status.name, container_id, unit_of_work_id, created_at, assigned_at, stopped_at
FROM public.tasks AS tasks 
INNER JOIN public.pool AS pool ON pool.id = tasks.pool_id 
INNER JOIN public.status AS status ON status.id = tasks.status_id;

