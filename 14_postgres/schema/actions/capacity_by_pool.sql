SELECT pool.name, COUNT(pool.name)
FROM public.tasks AS tasks 
INNER JOIN public.pool AS pool ON pool.id = tasks.pool_id 
INNER JOIN public.status AS status ON status.id = tasks.status_id
WHERE status.name = 'Launching' OR status.name = 'Ready'
GROUP BY pool.name
