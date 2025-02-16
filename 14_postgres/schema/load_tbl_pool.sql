
INSERT INTO public.pool("id", "name", "desired_capacity") VALUES (1, 'pool1', 3);
INSERT INTO public.pool("id", "name", "desired_capacity") VALUES (2, 'pool2', 8);
INSERT INTO public.pool("id", "name", "desired_capacity") VALUES (3, 'pool3', 0);
INSERT INTO public.pool("id", "name", "desired_capacity") VALUES (4, 'pool4', 1);


SELECT id, name, desired_capacity FROM public.pool;

