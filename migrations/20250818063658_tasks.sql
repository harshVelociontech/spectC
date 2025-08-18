-- Create enum types
CREATE TYPE task_status_enum AS ENUM ('Backlog', 'In Progress', 'Testing', 'Review', 'Completed');
CREATE TYPE task_priority_enum AS ENUM ('Low', 'Medium', 'High', 'Critical');

-- Create tasks table
CREATE TABLE tasks (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  project_id UUID NOT NULL REFERENCES projects(id),
  title VARCHAR(200) NOT NULL,
  description TEXT,
  status task_status_enum DEFAULT 'Backlog',
  priority task_priority_enum DEFAULT 'Medium',
  progress_percentage INT DEFAULT 0,
  estimated_hours NUMERIC(6,2),
  estimated_days NUMERIC(5,2),
  start_date DATE,
  due_date DATE,
  completed_at DATE,
  created_by UUID NOT NULL REFERENCES users(id),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE tasks ENABLE ROW LEVEL SECURITY;

-- SELECT: admin, project creator, or project member
CREATE POLICY "Allow select for admin creator or member"
ON tasks
FOR SELECT
USING (
  is_admin() OR
  auth.uid() = (SELECT created_by FROM projects WHERE id = project_id) OR
  EXISTS (
    SELECT 1 FROM project_members pm
    WHERE pm.project_id = tasks.project_id
      AND pm.user_id = auth.uid()
  )
);

-- INSERT: admin, project creator, or project member
CREATE POLICY "Allow insert for admin creator or member"
ON tasks
FOR INSERT
WITH CHECK (
  is_admin() OR
  auth.uid() = (SELECT created_by FROM projects WHERE id = project_id) OR
  EXISTS (
    SELECT 1 FROM project_members pm
    WHERE pm.project_id = project_id
      AND pm.user_id = auth.uid()
  )
);

-- UPDATE: admin, task creator, or assignee
CREATE POLICY "Allow update for admin creator or assignee"
ON tasks
FOR UPDATE
USING (
  is_admin() OR
  created_by = auth.uid() OR
  EXISTS (
    SELECT 1 FROM task_assignees ta
    WHERE ta.task_id = tasks.id
      AND ta.user_id = auth.uid()
  )
);

-- DELETE: admin or project creator
CREATE POLICY "Allow delete for admin or creator"
ON tasks
FOR DELETE
USING (
  is_admin() OR
  auth.uid() = (SELECT created_by FROM projects WHERE id = project_id)
);
