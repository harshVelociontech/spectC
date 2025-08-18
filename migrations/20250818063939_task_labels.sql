CREATE TYPE label_status_enum AS ENUM ('Active', 'Inactive');

-- migrations/0011_create_task_labels_table.sql

-- Create task_labels table
CREATE TABLE task_labels (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  task_id UUID REFERENCES tasks(id),
  name VARCHAR(50) UNIQUE NOT NULL,
  status label_status_enum DEFAULT 'Active'
);

-- Enable RLS
ALTER TABLE task_labels ENABLE ROW LEVEL SECURITY;

-- Policies for task_labels
-- SELECT: admin, project creator, or project member
CREATE POLICY "Allow select for admin creator or member" ON task_labels FOR SELECT USING (
  is_admin() OR
  (SELECT created_by FROM projects p JOIN tasks t ON t.project_id = p.id WHERE t.id = task_labels.task_id) = auth.uid() OR
  EXISTS (SELECT 1 FROM project_members pm JOIN tasks t ON t.project_id = pm.project_id WHERE t.id = task_labels.task_id AND pm.user_id = auth.uid())
);

-- INSERT: admin, task creator, or project member
CREATE POLICY "Allow insert for admin creator or member" ON task_labels FOR INSERT WITH CHECK (
  is_admin() OR
  (SELECT created_by FROM tasks WHERE id = new.task_id) = auth.uid() OR
  EXISTS (SELECT 1 FROM project_members pm JOIN tasks t ON t.project_id = pm.project_id WHERE t.id = new.task_id AND pm.user_id = auth.uid())
);

-- UPDATE: admin or task creator
CREATE POLICY "Allow update for admin or creator" ON task_labels FOR UPDATE USING (
  is_admin() OR
  (SELECT created_by FROM tasks WHERE id = task_labels.task_id) = auth.uid()
);

-- DELETE: admin or task creator
CREATE POLICY "Allow delete for admin or creator" ON task_labels FOR DELETE USING (
  is_admin() OR
  (SELECT created_by FROM tasks WHERE id = task_labels.task_id) = auth.uid()
);