CREATE TYPE project_status_enum AS ENUM ('Planning', 'In Progress', 'Review', 'Completed');
CREATE TYPE risk_level_enum AS ENUM ('Low', 'Medium', 'High');

-- migrations/0006_create_projects_table.sql

-- Create projects table
CREATE TABLE projects (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(200) NOT NULL,
  description TEXT,
  status project_status_enum DEFAULT 'Planning',
  progress_percentage INT DEFAULT 0,
  budget NUMERIC(12,2),
  team_size INT,
  risk_level risk_level_enum DEFAULT 'Low',
  start_date DATE,
  end_date DATE,
  created_by UUID NOT NULL REFERENCES users(id),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE projects ENABLE ROW LEVEL SECURITY;

-- Policies for projects
-- SELECT: admin, creator, or member
CREATE POLICY "Allow select for admin creator or member" ON projects FOR SELECT USING (
  is_admin() OR
  created_by = auth.uid() OR
  EXISTS (SELECT 1 FROM project_members WHERE project_id = projects.id AND user_id = auth.uid())
);

-- INSERT: authenticated users (any can create projects)
CREATE POLICY "Allow insert for authenticated" ON projects FOR INSERT WITH CHECK (
  auth.uid() IS NOT NULL AND created_by = auth.uid()
);

-- UPDATE: admin or creator
CREATE POLICY "Allow update for admin or creator" ON projects FOR UPDATE USING (
  is_admin() OR created_by = auth.uid()
);

-- DELETE: admin or creator
CREATE POLICY "Allow delete for admin or creator" ON projects FOR DELETE USING (
  is_admin() OR created_by = auth.uid()
);