-- migrations/0013_create_templates_table.sql

-- Create templates table
CREATE TABLE templates (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(200) NOT NULL,
  phase_number INT,
  description TEXT,
  file VARCHAR(255),
  roles UUID[],  -- array of role IDs
  ceremonies VARCHAR[],  -- array of ceremony names
  created_by UUID REFERENCES users(id),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE templates ENABLE ROW LEVEL SECURITY;

-- Policies for templates (assuming owned by creator)
-- SELECT: admin or creator
CREATE POLICY "Allow select for admin or creator" ON templates FOR SELECT USING (
  is_admin() OR created_by = auth.uid()
);

-- INSERT: authenticated
CREATE POLICY "Allow insert for authenticated" ON templates FOR INSERT WITH CHECK (
  auth.uid() IS NOT NULL AND created_by = auth.uid()
);

-- UPDATE: admin or creator
CREATE POLICY "Allow update for admin or creator" ON templates FOR UPDATE USING (
  is_admin() OR created_by = auth.uid()
);

-- DELETE: admin or creator
CREATE POLICY "Allow delete for admin or creator" ON templates FOR DELETE USING (
  is_admin() OR created_by = auth.uid()
);