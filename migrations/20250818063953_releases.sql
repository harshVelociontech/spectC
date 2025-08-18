CREATE TYPE release_status_enum AS ENUM ('Planning', 'In Development', 'Testing', 'Released');

-- migrations/0012_create_releases_table.sql

-- Create releases table
CREATE TABLE releases (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(50),
  description VARCHAR(300),
  project_id UUID REFERENCES projects(id),
  version VARCHAR(50) NOT NULL,
  features NUMERIC,  -- Note: schema says Number(), assuming NUMERIC for features count or something
  risk_level risk_level_enum DEFAULT 'Low',
  status release_status_enum DEFAULT 'Planning',
  release_date DATE
);

-- Enable RLS
ALTER TABLE releases ENABLE ROW LEVEL SECURITY;

-- Policies for releases
-- SELECT: admin, project creator, or member
CREATE POLICY "Allow select for admin creator or member" ON releases FOR SELECT USING (
  is_admin() OR
  (SELECT created_by FROM projects WHERE id = releases.project_id) = auth.uid() OR
  EXISTS (SELECT 1 FROM project_members WHERE project_id = releases.project_id AND user_id = auth.uid())
);

-- INSERT: admin or project creator
CREATE POLICY "Allow insert for admin or creator" ON releases FOR INSERT WITH CHECK (
  is_admin() OR
  (SELECT created_by FROM projects WHERE id = new.project_id) = auth.uid()
);

-- UPDATE: admin or project creator
CREATE POLICY "Allow update for admin or creator" ON releases FOR UPDATE USING (
  is_admin() OR
  (SELECT created_by FROM projects WHERE id = releases.project_id) = auth.uid()
);

-- DELETE: admin or project creator
CREATE POLICY "Allow delete for admin or creator" ON releases FOR DELETE USING (
  is_admin() OR
  (SELECT created_by FROM projects WHERE id = releases.project_id) = auth.uid()
);