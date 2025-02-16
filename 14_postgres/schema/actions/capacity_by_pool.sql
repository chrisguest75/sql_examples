-- find current capacity by pool and also return desired capacity
SELECT pool.name, COALESCE(capacity, 0) AS capacity, desired_capacity, COALESCE(capacity, 0) - desired_capacity AS delta
FROM 
(SELECT pool.id, COUNT(pool.name) AS capacity
FROM public.tasks AS tasks 
INNER JOIN public.pool AS pool ON pool.id = tasks.pool_id 
INNER JOIN public.status AS status ON status.id = tasks.status_id
WHERE status.name = 'Launching' OR status.name = 'Ready'
GROUP BY pool.id) AS capacity_by_pool 
RIGHT OUTER JOIN public.pool AS pool ON pool.id = capacity_by_pool.id