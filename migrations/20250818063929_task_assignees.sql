-- Enum type for assignee status
CREATE TYPE assignee_status_enum AS ENUM ('Assigned', 'In Progress', 'Completed');

-- Create task_assignees table
CREATE TABLE task_assignees (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  task_id UUID NOT NULL REFERENCES tasks(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES users(id),
  assigned_by UUID NOT NULL REFERENCES users(id),
  status assignee_status_enum DEFAULT 'Assigned',
  assigned_at TIMESTAMP DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE task_assignees ENABLE ROW LEVEL SECURITY;

-- SELECT: admin, task creator, or assignee
CREATE POLICY "Allow select for admin creator or assignee"
ON task_assignees
FOR SELECT
USING (
  is_admin() OR
  EXISTS (
    SELECT 1 FROM tasks t
    WHERE t.id = task_assignees.task_id
      AND (t.created_by = auth.uid() OR task_assignees.user_id = auth.uid())
  )
);

-- INSERT: admin, task creator
CREATE POLICY "Allow insert for admin or creator"
ON task_assignees
FOR INSERT
WITH CHECK (
  is_admin() OR
  EXISTS (
    SELECT 1 FROM tasks t
    WHERE t.id = task_assignees.task_id
      AND t.created_by = auth.uid()
  )
);

-- UPDATE: admin, task creator, or assignee themselves
CREATE POLICY "Allow update for admin creator or assignee"
ON task_assignees
FOR UPDATE
USING (
  is_admin() OR
  task_assignees.assigned_by = auth.uid() OR
  task_assignees.user_id = auth.uid()
);

-- DELETE: admin or task creator
CREATE POLICY "Allow delete for admin or creator"
ON task_assignees
FOR DELETE
USING (
  is_admin() OR
  EXISTS (
    SELECT 1 FROM tasks t
    WHERE t.id = task_assignees.task_id
      AND t.created_by = auth.uid()
  )
);
