
INSERT INTO public.status("id", "name") VALUES (1, 'Launching');
INSERT INTO public.status("id", "name") VALUES (2, 'Ready');
INSERT INTO public.status("id", "name") VALUES (3, 'Assigned');
INSERT INTO public.status("id", "name") VALUES (4, 'Complete');

SELECT id, name FROM public.status;