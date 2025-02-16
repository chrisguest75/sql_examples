-- find a ready task and assign a workload to it
WITH cte AS (
    SELECT * FROM public.tasks 
    WHERE status_id=2 AND pool_id=${POOL_ID}
    ORDER BY id ASC
    LIMIT 1
)
UPDATE public.tasks 
SET unit_of_work_id='${WORK_ID}', status_id=3, assigned_at=NOW() 
WHERE id IN (SELECT id FROM cte);