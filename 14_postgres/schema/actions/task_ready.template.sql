-- find a launched task of 2 minutes and force it to be ready
WITH cte AS (
    SELECT *, NOW() - created_at AS time_elapsed FROM public.tasks
    WHERE status_id=1 AND NOW() - created_at > INTERVAL '2 minutes'
    LIMIT 1
)
UPDATE public.tasks 
SET status_id=2, stopped_at=NOW() 
WHERE id IN (SELECT id FROM cte);