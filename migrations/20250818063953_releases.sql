CREATE TYPE release_status_enum AS ENUM ('Planning', 'In Development', 'Testing', 'Released');

-- Create releases table
CREATE TABLE releases (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(50),
  description VARCHAR(300),
  project_id UUID REFERENCES projects(id),
  version VARCHAR(50) NOT NULL,
  features NUMERIC,
  risk_level risk_level_enum DEFAULT 'Low',
  status release_status_enum DEFAULT 'Planning',
  release_date DATE
);

-- Enable RLS
ALTER TABLE releases ENABLE ROW LEVEL SECURITY;

-- SELECT: admin, project creator, or member
CREATE POLICY "Allow select for admin creator or member"
ON releases
FOR SELECT
USING (
  is_admin() OR
  auth.uid() = (SELECT created_by FROM projects WHERE id = project_id) OR
  EXISTS (
    SELECT 1 
    FROM project_members pm 
    WHERE pm.project_id = project_id AND pm.user_id = auth.uid()
  )
);

-- INSERT: admin or project creator
CREATE POLICY "Allow insert for admin or creator"
ON releases
FOR INSERT
WITH CHECK (
  is_admin() OR
  auth.uid() = (SELECT created_by FROM projects WHERE id = project_id)
);

-- UPDATE: admin or project creator
CREATE POLICY "Allow update for admin or creator"
ON releases
FOR UPDATE
USING (
  is_admin() OR
  auth.uid() = (SELECT created_by FROM projects WHERE id = project_id)
);

-- DELETE: admin or project creator
CREATE POLICY "Allow delete for admin or creator"
ON releases
FOR DELETE
USING (
  is_admin() OR
  auth.uid() = (SELECT created_by FROM projects WHERE id = project_id)
);
