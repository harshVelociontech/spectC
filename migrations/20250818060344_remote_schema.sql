drop extension if exists "pg_net";

revoke delete on table "public"."payment_plans" from "anon";

revoke insert on table "public"."payment_plans" from "anon";

revoke references on table "public"."payment_plans" from "anon";

revoke select on table "public"."payment_plans" from "anon";

revoke trigger on table "public"."payment_plans" from "anon";

revoke truncate on table "public"."payment_plans" from "anon";

revoke update on table "public"."payment_plans" from "anon";

revoke delete on table "public"."payment_plans" from "authenticated";

revoke insert on table "public"."payment_plans" from "authenticated";

revoke references on table "public"."payment_plans" from "authenticated";

revoke select on table "public"."payment_plans" from "authenticated";

revoke trigger on table "public"."payment_plans" from "authenticated";

revoke truncate on table "public"."payment_plans" from "authenticated";

revoke update on table "public"."payment_plans" from "authenticated";

revoke delete on table "public"."payment_plans" from "service_role";

revoke insert on table "public"."payment_plans" from "service_role";

revoke references on table "public"."payment_plans" from "service_role";

revoke select on table "public"."payment_plans" from "service_role";

revoke trigger on table "public"."payment_plans" from "service_role";

revoke truncate on table "public"."payment_plans" from "service_role";

revoke update on table "public"."payment_plans" from "service_role";

revoke delete on table "public"."payments" from "anon";

revoke insert on table "public"."payments" from "anon";

revoke references on table "public"."payments" from "anon";

revoke select on table "public"."payments" from "anon";

revoke trigger on table "public"."payments" from "anon";

revoke truncate on table "public"."payments" from "anon";

revoke update on table "public"."payments" from "anon";

revoke delete on table "public"."payments" from "authenticated";

revoke insert on table "public"."payments" from "authenticated";

revoke references on table "public"."payments" from "authenticated";

revoke select on table "public"."payments" from "authenticated";

revoke trigger on table "public"."payments" from "authenticated";

revoke truncate on table "public"."payments" from "authenticated";

revoke update on table "public"."payments" from "authenticated";

revoke delete on table "public"."payments" from "service_role";

revoke insert on table "public"."payments" from "service_role";

revoke references on table "public"."payments" from "service_role";

revoke select on table "public"."payments" from "service_role";

revoke trigger on table "public"."payments" from "service_role";

revoke truncate on table "public"."payments" from "service_role";

revoke update on table "public"."payments" from "service_role";

revoke delete on table "public"."project_members" from "anon";

revoke insert on table "public"."project_members" from "anon";

revoke references on table "public"."project_members" from "anon";

revoke select on table "public"."project_members" from "anon";

revoke trigger on table "public"."project_members" from "anon";

revoke truncate on table "public"."project_members" from "anon";

revoke update on table "public"."project_members" from "anon";

revoke delete on table "public"."project_members" from "authenticated";

revoke insert on table "public"."project_members" from "authenticated";

revoke references on table "public"."project_members" from "authenticated";

revoke select on table "public"."project_members" from "authenticated";

revoke trigger on table "public"."project_members" from "authenticated";

revoke truncate on table "public"."project_members" from "authenticated";

revoke update on table "public"."project_members" from "authenticated";

revoke delete on table "public"."project_members" from "service_role";

revoke insert on table "public"."project_members" from "service_role";

revoke references on table "public"."project_members" from "service_role";

revoke select on table "public"."project_members" from "service_role";

revoke trigger on table "public"."project_members" from "service_role";

revoke truncate on table "public"."project_members" from "service_role";

revoke update on table "public"."project_members" from "service_role";

revoke delete on table "public"."projects" from "anon";

revoke insert on table "public"."projects" from "anon";

revoke references on table "public"."projects" from "anon";

revoke select on table "public"."projects" from "anon";

revoke trigger on table "public"."projects" from "anon";

revoke truncate on table "public"."projects" from "anon";

revoke update on table "public"."projects" from "anon";

revoke delete on table "public"."projects" from "authenticated";

revoke insert on table "public"."projects" from "authenticated";

revoke references on table "public"."projects" from "authenticated";

revoke select on table "public"."projects" from "authenticated";

revoke trigger on table "public"."projects" from "authenticated";

revoke truncate on table "public"."projects" from "authenticated";

revoke update on table "public"."projects" from "authenticated";

revoke delete on table "public"."projects" from "service_role";

revoke insert on table "public"."projects" from "service_role";

revoke references on table "public"."projects" from "service_role";

revoke select on table "public"."projects" from "service_role";

revoke trigger on table "public"."projects" from "service_role";

revoke truncate on table "public"."projects" from "service_role";

revoke update on table "public"."projects" from "service_role";

revoke delete on table "public"."releases" from "anon";

revoke insert on table "public"."releases" from "anon";

revoke references on table "public"."releases" from "anon";

revoke select on table "public"."releases" from "anon";

revoke trigger on table "public"."releases" from "anon";

revoke truncate on table "public"."releases" from "anon";

revoke update on table "public"."releases" from "anon";

revoke delete on table "public"."releases" from "authenticated";

revoke insert on table "public"."releases" from "authenticated";

revoke references on table "public"."releases" from "authenticated";

revoke select on table "public"."releases" from "authenticated";

revoke trigger on table "public"."releases" from "authenticated";

revoke truncate on table "public"."releases" from "authenticated";

revoke update on table "public"."releases" from "authenticated";

revoke delete on table "public"."releases" from "service_role";

revoke insert on table "public"."releases" from "service_role";

revoke references on table "public"."releases" from "service_role";

revoke select on table "public"."releases" from "service_role";

revoke trigger on table "public"."releases" from "service_role";

revoke truncate on table "public"."releases" from "service_role";

revoke update on table "public"."releases" from "service_role";

revoke delete on table "public"."roles" from "anon";

revoke insert on table "public"."roles" from "anon";

revoke references on table "public"."roles" from "anon";

revoke select on table "public"."roles" from "anon";

revoke trigger on table "public"."roles" from "anon";

revoke truncate on table "public"."roles" from "anon";

revoke update on table "public"."roles" from "anon";

revoke delete on table "public"."roles" from "authenticated";

revoke insert on table "public"."roles" from "authenticated";

revoke references on table "public"."roles" from "authenticated";

revoke select on table "public"."roles" from "authenticated";

revoke trigger on table "public"."roles" from "authenticated";

revoke truncate on table "public"."roles" from "authenticated";

revoke update on table "public"."roles" from "authenticated";

revoke delete on table "public"."roles" from "service_role";

revoke insert on table "public"."roles" from "service_role";

revoke references on table "public"."roles" from "service_role";

revoke select on table "public"."roles" from "service_role";

revoke trigger on table "public"."roles" from "service_role";

revoke truncate on table "public"."roles" from "service_role";

revoke update on table "public"."roles" from "service_role";

revoke delete on table "public"."subscriptions" from "anon";

revoke insert on table "public"."subscriptions" from "anon";

revoke references on table "public"."subscriptions" from "anon";

revoke select on table "public"."subscriptions" from "anon";

revoke trigger on table "public"."subscriptions" from "anon";

revoke truncate on table "public"."subscriptions" from "anon";

revoke update on table "public"."subscriptions" from "anon";

revoke delete on table "public"."subscriptions" from "authenticated";

revoke insert on table "public"."subscriptions" from "authenticated";

revoke references on table "public"."subscriptions" from "authenticated";

revoke select on table "public"."subscriptions" from "authenticated";

revoke trigger on table "public"."subscriptions" from "authenticated";

revoke truncate on table "public"."subscriptions" from "authenticated";

revoke update on table "public"."subscriptions" from "authenticated";

revoke delete on table "public"."subscriptions" from "service_role";

revoke insert on table "public"."subscriptions" from "service_role";

revoke references on table "public"."subscriptions" from "service_role";

revoke select on table "public"."subscriptions" from "service_role";

revoke trigger on table "public"."subscriptions" from "service_role";

revoke truncate on table "public"."subscriptions" from "service_role";

revoke update on table "public"."subscriptions" from "service_role";

revoke delete on table "public"."task_assignees" from "anon";

revoke insert on table "public"."task_assignees" from "anon";

revoke references on table "public"."task_assignees" from "anon";

revoke select on table "public"."task_assignees" from "anon";

revoke trigger on table "public"."task_assignees" from "anon";

revoke truncate on table "public"."task_assignees" from "anon";

revoke update on table "public"."task_assignees" from "anon";

revoke delete on table "public"."task_assignees" from "authenticated";

revoke insert on table "public"."task_assignees" from "authenticated";

revoke references on table "public"."task_assignees" from "authenticated";

revoke select on table "public"."task_assignees" from "authenticated";

revoke trigger on table "public"."task_assignees" from "authenticated";

revoke truncate on table "public"."task_assignees" from "authenticated";

revoke update on table "public"."task_assignees" from "authenticated";

revoke delete on table "public"."task_assignees" from "service_role";

revoke insert on table "public"."task_assignees" from "service_role";

revoke references on table "public"."task_assignees" from "service_role";

revoke select on table "public"."task_assignees" from "service_role";

revoke trigger on table "public"."task_assignees" from "service_role";

revoke truncate on table "public"."task_assignees" from "service_role";

revoke update on table "public"."task_assignees" from "service_role";

revoke delete on table "public"."task_labels" from "anon";

revoke insert on table "public"."task_labels" from "anon";

revoke references on table "public"."task_labels" from "anon";

revoke select on table "public"."task_labels" from "anon";

revoke trigger on table "public"."task_labels" from "anon";

revoke truncate on table "public"."task_labels" from "anon";

revoke update on table "public"."task_labels" from "anon";

revoke delete on table "public"."task_labels" from "authenticated";

revoke insert on table "public"."task_labels" from "authenticated";

revoke references on table "public"."task_labels" from "authenticated";

revoke select on table "public"."task_labels" from "authenticated";

revoke trigger on table "public"."task_labels" from "authenticated";

revoke truncate on table "public"."task_labels" from "authenticated";

revoke update on table "public"."task_labels" from "authenticated";

revoke delete on table "public"."task_labels" from "service_role";

revoke insert on table "public"."task_labels" from "service_role";

revoke references on table "public"."task_labels" from "service_role";

revoke select on table "public"."task_labels" from "service_role";

revoke trigger on table "public"."task_labels" from "service_role";

revoke truncate on table "public"."task_labels" from "service_role";

revoke update on table "public"."task_labels" from "service_role";

revoke delete on table "public"."tasks" from "anon";

revoke insert on table "public"."tasks" from "anon";

revoke references on table "public"."tasks" from "anon";

revoke select on table "public"."tasks" from "anon";

revoke trigger on table "public"."tasks" from "anon";

revoke truncate on table "public"."tasks" from "anon";

revoke update on table "public"."tasks" from "anon";

revoke delete on table "public"."tasks" from "authenticated";

revoke insert on table "public"."tasks" from "authenticated";

revoke references on table "public"."tasks" from "authenticated";

revoke select on table "public"."tasks" from "authenticated";

revoke trigger on table "public"."tasks" from "authenticated";

revoke truncate on table "public"."tasks" from "authenticated";

revoke update on table "public"."tasks" from "authenticated";

revoke delete on table "public"."tasks" from "service_role";

revoke insert on table "public"."tasks" from "service_role";

revoke references on table "public"."tasks" from "service_role";

revoke select on table "public"."tasks" from "service_role";

revoke trigger on table "public"."tasks" from "service_role";

revoke truncate on table "public"."tasks" from "service_role";

revoke update on table "public"."tasks" from "service_role";

revoke delete on table "public"."templates" from "anon";

revoke insert on table "public"."templates" from "anon";

revoke references on table "public"."templates" from "anon";

revoke select on table "public"."templates" from "anon";

revoke trigger on table "public"."templates" from "anon";

revoke truncate on table "public"."templates" from "anon";

revoke update on table "public"."templates" from "anon";

revoke delete on table "public"."templates" from "authenticated";

revoke insert on table "public"."templates" from "authenticated";

revoke references on table "public"."templates" from "authenticated";

revoke select on table "public"."templates" from "authenticated";

revoke trigger on table "public"."templates" from "authenticated";

revoke truncate on table "public"."templates" from "authenticated";

revoke update on table "public"."templates" from "authenticated";

revoke delete on table "public"."templates" from "service_role";

revoke insert on table "public"."templates" from "service_role";

revoke references on table "public"."templates" from "service_role";

revoke select on table "public"."templates" from "service_role";

revoke trigger on table "public"."templates" from "service_role";

revoke truncate on table "public"."templates" from "service_role";

revoke update on table "public"."templates" from "service_role";

revoke delete on table "public"."user_settings" from "anon";

revoke insert on table "public"."user_settings" from "anon";

revoke references on table "public"."user_settings" from "anon";

revoke select on table "public"."user_settings" from "anon";

revoke trigger on table "public"."user_settings" from "anon";

revoke truncate on table "public"."user_settings" from "anon";

revoke update on table "public"."user_settings" from "anon";

revoke delete on table "public"."user_settings" from "authenticated";

revoke insert on table "public"."user_settings" from "authenticated";

revoke references on table "public"."user_settings" from "authenticated";

revoke select on table "public"."user_settings" from "authenticated";

revoke trigger on table "public"."user_settings" from "authenticated";

revoke truncate on table "public"."user_settings" from "authenticated";

revoke update on table "public"."user_settings" from "authenticated";

revoke delete on table "public"."user_settings" from "service_role";

revoke insert on table "public"."user_settings" from "service_role";

revoke references on table "public"."user_settings" from "service_role";

revoke select on table "public"."user_settings" from "service_role";

revoke trigger on table "public"."user_settings" from "service_role";

revoke truncate on table "public"."user_settings" from "service_role";

revoke update on table "public"."user_settings" from "service_role";

revoke delete on table "public"."users" from "anon";

revoke insert on table "public"."users" from "anon";

revoke references on table "public"."users" from "anon";

revoke select on table "public"."users" from "anon";

revoke trigger on table "public"."users" from "anon";

revoke truncate on table "public"."users" from "anon";

revoke update on table "public"."users" from "anon";

revoke delete on table "public"."users" from "authenticated";

revoke insert on table "public"."users" from "authenticated";

revoke references on table "public"."users" from "authenticated";

revoke select on table "public"."users" from "authenticated";

revoke trigger on table "public"."users" from "authenticated";

revoke truncate on table "public"."users" from "authenticated";

revoke update on table "public"."users" from "authenticated";

revoke delete on table "public"."users" from "service_role";

revoke insert on table "public"."users" from "service_role";

revoke references on table "public"."users" from "service_role";

revoke select on table "public"."users" from "service_role";

revoke trigger on table "public"."users" from "service_role";

revoke truncate on table "public"."users" from "service_role";

revoke update on table "public"."users" from "service_role";

revoke delete on table "public"."workflows" from "anon";

revoke insert on table "public"."workflows" from "anon";

revoke references on table "public"."workflows" from "anon";

revoke select on table "public"."workflows" from "anon";

revoke trigger on table "public"."workflows" from "anon";

revoke truncate on table "public"."workflows" from "anon";

revoke update on table "public"."workflows" from "anon";

revoke delete on table "public"."workflows" from "authenticated";

revoke insert on table "public"."workflows" from "authenticated";

revoke references on table "public"."workflows" from "authenticated";

revoke select on table "public"."workflows" from "authenticated";

revoke trigger on table "public"."workflows" from "authenticated";

revoke truncate on table "public"."workflows" from "authenticated";

revoke update on table "public"."workflows" from "authenticated";

revoke delete on table "public"."workflows" from "service_role";

revoke insert on table "public"."workflows" from "service_role";

revoke references on table "public"."workflows" from "service_role";

revoke select on table "public"."workflows" from "service_role";

revoke trigger on table "public"."workflows" from "service_role";

revoke truncate on table "public"."workflows" from "service_role";

revoke update on table "public"."workflows" from "service_role";

alter table "public"."payments" drop constraint "payments_subscription_id_fkey";

alter table "public"."payments" drop constraint "payments_transaction_id_key";

alter table "public"."payments" drop constraint "payments_user_id_fkey";

alter table "public"."project_members" drop constraint "project_members_project_id_fkey";

alter table "public"."project_members" drop constraint "project_members_user_id_fkey";

alter table "public"."projects" drop constraint "projects_created_by_fkey";

alter table "public"."releases" drop constraint "releases_project_id_fkey";

alter table "public"."roles" drop constraint "roles_name_key";

alter table "public"."subscriptions" drop constraint "subscriptions_plan_id_fkey";

alter table "public"."subscriptions" drop constraint "subscriptions_user_id_fkey";

alter table "public"."task_assignees" drop constraint "task_assignees_task_id_fkey";

alter table "public"."task_assignees" drop constraint "task_assignees_user_id_fkey";

alter table "public"."task_labels" drop constraint "task_labels_task_id_fkey";

alter table "public"."task_labels" drop constraint "task_labels_task_id_name_key";

alter table "public"."tasks" drop constraint "tasks_created_by_fkey";

alter table "public"."tasks" drop constraint "tasks_project_id_fkey";

alter table "public"."templates" drop constraint "templates_created_by_fkey";

alter table "public"."user_settings" drop constraint "user_settings_user_id_fkey";

alter table "public"."users" drop constraint "users_email_key";

alter table "public"."users" drop constraint "users_parent_id_fkey";

alter table "public"."users" drop constraint "users_role_id_fkey";

alter table "public"."workflows" drop constraint "workflows_created_by_fkey";

alter table "public"."payment_plans" drop constraint "payment_plans_pkey";

alter table "public"."payments" drop constraint "payments_pkey";

alter table "public"."project_members" drop constraint "project_members_pkey";

alter table "public"."projects" drop constraint "projects_pkey";

alter table "public"."releases" drop constraint "releases_pkey";

alter table "public"."roles" drop constraint "roles_pkey";

alter table "public"."subscriptions" drop constraint "subscriptions_pkey";

alter table "public"."task_assignees" drop constraint "task_assignees_pkey";

alter table "public"."task_labels" drop constraint "task_labels_pkey";

alter table "public"."tasks" drop constraint "tasks_pkey";

alter table "public"."templates" drop constraint "templates_pkey";

alter table "public"."user_settings" drop constraint "user_settings_pkey";

alter table "public"."users" drop constraint "users_pkey";

alter table "public"."workflows" drop constraint "workflows_pkey";

drop index if exists "public"."payment_plans_pkey";

drop index if exists "public"."payments_pkey";

drop index if exists "public"."payments_transaction_id_key";

drop index if exists "public"."project_members_pkey";

drop index if exists "public"."projects_pkey";

drop index if exists "public"."releases_pkey";

drop index if exists "public"."roles_name_key";

drop index if exists "public"."roles_pkey";

drop index if exists "public"."subscriptions_pkey";

drop index if exists "public"."task_assignees_pkey";

drop index if exists "public"."task_labels_pkey";

drop index if exists "public"."task_labels_task_id_name_key";

drop index if exists "public"."tasks_pkey";

drop index if exists "public"."templates_pkey";

drop index if exists "public"."user_settings_pkey";

drop index if exists "public"."users_email_key";

drop index if exists "public"."users_pkey";

drop index if exists "public"."workflows_pkey";

drop table "public"."payment_plans";

drop table "public"."payments";

drop table "public"."project_members";

drop table "public"."projects";

drop table "public"."releases";

drop table "public"."roles";

drop table "public"."subscriptions";

drop table "public"."task_assignees";

drop table "public"."task_labels";

drop table "public"."tasks";

drop table "public"."templates";

drop table "public"."user_settings";

drop table "public"."users";

drop table "public"."workflows";

drop type "public"."assignee_status_enum";

drop type "public"."label_status_enum";

drop type "public"."member_status_enum";

drop type "public"."payment_status_enum";

drop type "public"."project_status_enum";

drop type "public"."release_status_enum";

drop type "public"."risk_level_enum";

drop type "public"."subscription_plan_enum";

drop type "public"."task_priority_enum";

drop type "public"."task_status_enum";


