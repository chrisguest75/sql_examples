-- find an assigned task of 30 minutes and force it to be completed
WITH cte AS (
    SELECT *, NOW() - assigned_at AS time_elapsed FROM public.tasks
    WHERE status_id=3 AND pool_id=${POOL_ID} AND NOW() - assigned_at > INTERVAL '5 minutes'
    LIMIT 1
)
UPDATE public.tasks 
SET status_id=4, stopped_at=NOW() 
WHERE id IN (SELECT id FROM cte);