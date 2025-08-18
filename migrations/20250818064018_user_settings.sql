-- Create user_settings table
CREATE TABLE user_settings (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id),
  color_primary VARCHAR(7) DEFAULT '#FFFFFF',
  color_secondary VARCHAR(7) DEFAULT '#000000',
  color_accent VARCHAR(7) DEFAULT '#007BFF',
  application_name VARCHAR(200) DEFAULT 'MyApp',
  timezone VARCHAR(50) DEFAULT 'UTC-5',
  support_email VARCHAR(255) DEFAULT 'support@example.com',
  dark_mode BOOLEAN DEFAULT FALSE,
  notification BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE user_settings ENABLE ROW LEVEL SECURITY;

-- SELECT: own or admin
CREATE POLICY "Allow select own or admin"
ON user_settings
FOR SELECT
USING (
  user_id = auth.uid() OR is_admin()
);

-- INSERT: own or admin
CREATE POLICY "Allow insert own or admin"
ON user_settings
FOR INSERT
WITH CHECK (
  user_id = auth.uid() OR is_admin()
);

-- UPDATE: own or admin
CREATE POLICY "Allow update own or admin"
ON user_settings
FOR UPDATE
USING (
  user_id = auth.uid() OR is_admin()
);

-- DELETE: own or admin
CREATE POLICY "Allow delete own or admin"
ON user_settings
FOR DELETE
USING (
  user_id = auth.uid() OR is_admin()
);
