-- migrations/0004_create_users_table.sql

-- Create users table
CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  full_name VARCHAR(150) NOT NULL,
  email VARCHAR(150) UNIQUE NOT NULL,
  password_hash TEXT NOT NULL,
  role_id UUID REFERENCES roles(id),
  parent_id UUID REFERENCES users(id),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  status BOOLEAN
);

-- Enable RLS
ALTER TABLE users ENABLE ROW LEVEL SECURITY;

-- Policies for users
-- SELECT: own row or admin
CREATE POLICY "Allow select own or admin" ON users FOR SELECT USING (
  id = auth.uid() OR
  (SELECT name FROM roles WHERE id = (SELECT role_id FROM users WHERE id = auth.uid())) = 'admin'
);

-- INSERT: admins only (assuming custom signup handles insertion separately if needed)
CREATE POLICY "Allow insert for admins" ON users FOR INSERT WITH CHECK (
  (SELECT name FROM roles WHERE id = (SELECT role_id FROM users WHERE id = auth.uid())) = 'admin'
);

-- UPDATE: own or admin
CREATE POLICY "Allow update own or admin" ON users FOR UPDATE USING (
  id = auth.uid() OR
  (SELECT name FROM roles WHERE id = (SELECT role_id FROM users WHERE id = auth.uid())) = 'admin'
);

-- DELETE: admins only
CREATE POLICY "Allow delete for admins" ON users FOR DELETE USING (
  (SELECT name FROM roles WHERE id = (SELECT role_id FROM users WHERE id = auth.uid())) = 'admin'
);