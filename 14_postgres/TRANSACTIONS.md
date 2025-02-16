# TRANSACTIONS

Test locking and isolation behaviour  

## Test Locking

### Session 1 (Step 1)

Open a held transaction.  

```sql
BEGIN;
LOCK TABLE public.tasks IN ACCESS EXCLUSIVE MODE;
```

### Session 2 (Step 1)

This query will block.  

```sql
SELECT tasks.id, pool.name, status.name, container_id, unit_of_work_id, created_at, assigned_at, stopped_at
FROM public.tasks AS tasks 
INNER JOIN public.pool AS pool ON pool.id = tasks.pool_id 
INNER JOIN public.status AS status ON status.id = tasks.status_id;
```

### Session 1 (Step 2)

Rolling back will allow query to complete.  

```sql
ROLLBACK;
```

## Resources

