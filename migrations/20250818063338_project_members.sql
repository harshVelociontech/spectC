CREATE TYPE member_status_enum AS ENUM ('Active', 'Inactive');

-- migrations/0007_create_project_members_table.sql

-- Create project_members table
CREATE TABLE project_members (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  project_id UUID REFERENCES projects(id),
  user_id UUID REFERENCES users(id),
  status member_status_enum DEFAULT 'Active',
  joined_at TIMESTAMP DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE project_members ENABLE ROW LEVEL SECURITY;

-- Policies for project_members
-- SELECT: admin, project creator, or member
-- Policies for project_members
-- SELECT: admin, project creator, or member
-- Policies for project_members
-- SELECT: admin, project creator, or member
CREATE POLICY "Allow select for admin creator or member" ON project_members FOR SELECT USING (
  is_admin() OR
  (SELECT created_by FROM projects WHERE id = project_members.project_id) = auth.uid() OR
  EXISTS (SELECT 1 FROM project_members pm WHERE pm.project_id = project_members.project_id AND pm.user_id = auth.uid())
);

-- INSERT: admin or project creator
CREATE POLICY "Allow insert for admin or creator" ON project_members FOR INSERT WITH CHECK (
  is_admin() OR
  EXISTS (SELECT 1 FROM projects WHERE id = NEW.project_id AND created_by = auth.uid())
);

-- UPDATE: admin or project creator
CREATE POLICY "Allow update for admin or creator" ON project_members FOR UPDATE USING (
  is_admin() OR
  (SELECT created_by FROM projects WHERE id = project_members.project_id) = auth.uid()
);

-- DELETE: admin or project creator
CREATE POLICY "Allow delete for admin or creator" ON project_members FOR DELETE USING (
  is_admin() OR
  (SELECT created_by FROM projects WHERE id = project_members.project_id) = auth.uid()
);