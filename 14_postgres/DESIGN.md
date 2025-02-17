# DESIGN

Simple DB for tracking pools of compute, tasks and allocations.  

TODO:

* A table to track processes that are sets of multiple tasks from different pools.
* Launch tasks to fill desired capacity
* Allocate tasks randomly
* Have pools active and deactivated
* Open transactions for assigning work.
  * Add lauching tasks without locking.
  * Assigning tasks with locking

## ACTIONS

Task Status:

* Launching
* Ready
* Assigned
* Complete

1. AddTask(PoolId, TaskId, "Ready")

   Register a task into a pool and mark as available.

2. AssignTask(PoolId, WorkloadId, "Assigned")

   Find a free task in the pool and assign it a workloadId

3. WorkloadComplete(WorkloaId, "Complete")

   Mark workload as complete.

4. PoolCapacity(PoolId)

   How many available tasks in a pool? Include the desired capacity.  

## SCHEMA

Generated using `mermerd` ref:[05_diagramming_ERD/README.md](../05_diagramming_ERD/README.md)  

```mermaid
erDiagram
    pool {
        integer desired_capacity 
        integer id PK 
        text name 
    }

    status {
        integer id PK 
        text name 
    }

    tasks {
        timestamp_with_time_zone assigned_at 
        text container_id UK 
        timestamp_with_time_zone created_at 
        integer id PK 
        integer pool_id FK 
        integer status_id FK 
        timestamp_with_time_zone stopped_at 
        text unit_of_work_id UK 
    }

    tasks }o--|| pool : "pool_id"
    tasks }o--|| status : "status_id"
```

## Resources

