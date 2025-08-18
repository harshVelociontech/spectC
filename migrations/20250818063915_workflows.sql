-- migrations/0009_create_workflows_table.sql

-- Create workflows table
CREATE TABLE workflows (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(200) NOT NULL,
  stages VARCHAR[] NOT NULL,
  description TEXT,
  created_by UUID REFERENCES users(id),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE workflows ENABLE ROW LEVEL SECURITY;

-- Policies for workflows (assuming global, but owned by creator)
-- SELECT: admin or creator
CREATE POLICY "Allow select for admin or creator" ON workflows FOR SELECT USING (
  is_admin() OR created_by = auth.uid()
);

-- INSERT: authenticated
CREATE POLICY "Allow insert for authenticated" ON workflows FOR INSERT WITH CHECK (
  auth.uid() IS NOT NULL AND created_by = auth.uid()
);

-- UPDATE: admin or creator
CREATE POLICY "Allow update for admin or creator" ON workflows FOR UPDATE USING (
  is_admin() OR created_by = auth.uid()
);

-- DELETE: admin or creator
CREATE POLICY "Allow delete for admin or creator" ON workflows FOR DELETE USING (
  is_admin() OR created_by = auth.uid()
);