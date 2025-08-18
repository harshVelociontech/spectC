-- Create roles table
CREATE TABLE roles (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(50) UNIQUE NOT NULL,
  description TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE roles ENABLE ROW LEVEL SECURITY;

-- Policies for roles
-- SELECT: authenticated users
CREATE POLICY "Allow select for authenticated users" ON roles FOR SELECT USING (auth.uid() IS NOT NULL);

-- INSERT: authenticated users
CREATE POLICY "Allow insert for authenticated users" ON roles FOR INSERT WITH CHECK (auth.uid() IS NOT NULL);

-- UPDATE: authenticated users
CREATE POLICY "Allow update for authenticated users" ON roles FOR UPDATE USING (auth.uid() IS NOT NULL);

-- DELETE: authenticated users
CREATE POLICY "Allow delete for authenticated users" ON roles FOR DELETE USING (auth.uid() IS NOT NULL);

-- Insert default roles: USER, MANAGER, ADMIN
INSERT INTO roles (name, description) VALUES
  ('USER', 'Standard user with basic access'),
  ('MANAGER', 'Manager with elevated project and team permissions'),
  ('ADMIN', 'Administrator with full system access')
ON CONFLICT (name) DO NOTHING;