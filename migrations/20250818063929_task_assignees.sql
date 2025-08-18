CREATE TYPE assignee_status_enum AS ENUM ('Assigned', 'In Progress', 'Completed');
-- migrations/0010_create_task_assignees_table.sql

-- Create task_assignees table
CREATE TABLE task_assignees (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  task_id UUID REFERENCES tasks(id),
  user_id UUID REFERENCES users(id),
  status assignee_status_enum DEFAULT 'Assigned',
  assigned_at TIMESTAMP DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE task_assignees ENABLE ROW LEVEL SECURITY;

-- Policies for task_assignees
-- SELECT: admin, project creator, or project member (via task's project)
CREATE POLICY "Allow select for admin creator or member" ON task_assignees FOR SELECT USING (
  is_admin() OR
  (SELECT created_by FROM projects p JOIN tasks t ON t.project_id = p.id WHERE t.id = task_assignees.task_id) = auth.uid() OR
  EXISTS (SELECT 1 FROM project_members pm JOIN tasks t ON t.project_id = pm.project_id WHERE t.id = task_assignees.task_id AND pm.user_id = auth.uid())
);

-- INSERT: admin, task creator, or project creator
CREATE POLICY "Allow insert for admin task or project creator" ON task_assignees FOR INSERT WITH CHECK (
  is_admin() OR
  (SELECT created_by FROM tasks WHERE id = new.task_id) = auth.uid() OR
  (SELECT created_by FROM projects p JOIN tasks t ON t.project_id = p.id WHERE t.id = new.task_id) = auth.uid()
);

-- UPDATE: admin, task creator, or assignee
CREATE POLICY "Allow update for admin creator or assignee" ON task_assignees FOR UPDATE USING (
  is_admin() OR
  (SELECT created_by FROM tasks WHERE id = task_assignees.task_id) = auth.uid() OR
  user_id = auth.uid()
);

-- DELETE: admin or task creator
CREATE POLICY "Allow delete for admin or creator" ON task_assignees FOR DELETE USING (
  is_admin() OR
  (SELECT created_by FROM tasks WHERE id = task_assignees.task_id) = auth.uid()
);