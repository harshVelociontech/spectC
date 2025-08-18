-- Create enum type
CREATE TYPE label_status_enum AS ENUM ('Active', 'Inactive');

-- Create task_labels table
CREATE TABLE task_labels (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  task_id UUID REFERENCES tasks(id),
  name VARCHAR(50) UNIQUE NOT NULL,
  status label_status_enum DEFAULT 'Active'
);

-- Enable RLS
ALTER TABLE task_labels ENABLE ROW LEVEL SECURITY;

-- SELECT: admin, task creator, or project member
CREATE POLICY "Allow select for admin creator or member"
ON task_labels
FOR SELECT
USING (
  is_admin() OR
  auth.uid() = (
    SELECT t.created_by
    FROM tasks t
    WHERE t.id = task_labels.task_id
  ) OR
  EXISTS (
    SELECT 1 
    FROM project_members pm
    JOIN tasks t ON t.project_id = pm.project_id
    WHERE t.id = task_labels.task_id
      AND pm.user_id = auth.uid()
  )
);

-- INSERT: admin, task creator, or project member
CREATE POLICY "Allow insert for admin creator or member"
ON task_labels
FOR INSERT
WITH CHECK (
  is_admin() OR
  auth.uid() = (
    SELECT t.created_by
    FROM tasks t
    WHERE t.id = task_id
  ) OR
  EXISTS (
    SELECT 1
    FROM project_members pm
    JOIN tasks t ON t.project_id = pm.project_id
    WHERE t.id = task_id
      AND pm.user_id = auth.uid()
  )
);

-- UPDATE: admin or task creator
CREATE POLICY "Allow update for admin or creator"
ON task_labels
FOR UPDATE
USING (
  is_admin() OR
  auth.uid() = (
    SELECT t.created_by
    FROM tasks t
    WHERE t.id = task_id
  )
);

-- DELETE: admin or task creator
CREATE POLICY "Allow delete for admin or creator"
ON task_labels
FOR DELETE
USING (
  is_admin() OR
  auth.uid() = (
    SELECT t.created_by
    FROM tasks t
    WHERE t.id = task_id
  )
);
