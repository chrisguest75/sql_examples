-- find a launched task of 2 minutes and force it to be ready
WITH cte AS (
    SELECT *, NOW() - created_at AS time_elapsed FROM public.tasks
    WHERE status_id=1 AND pool_id=${POOL_ID} AND NOW() - created_at > INTERVAL '15 seconds'
    LIMIT 1
)
UPDATE public.tasks 
SET status_id=2 
WHERE id IN (SELECT id FROM cte);
