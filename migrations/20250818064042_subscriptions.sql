-- migrations/0016_create_subscriptions_table.sql

-- Create subscriptions table
CREATE TABLE subscriptions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id),
  plan_id UUID NOT NULL REFERENCES payment_plans(id),
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  auto_renew BOOLEAN DEFAULT TRUE,
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE subscriptions ENABLE ROW LEVEL SECURITY;

-- Policies for subscriptions
-- SELECT: own or admin
CREATE POLICY "Allow select own or admin" ON subscriptions FOR SELECT USING (
  user_id = auth.uid() OR is_admin()
);

-- INSERT: own or admin
CREATE POLICY "Allow insert own or admin" ON subscriptions FOR INSERT WITH CHECK (
  new.user_id = auth.uid() OR is_admin()
);

-- UPDATE: own or admin
CREATE POLICY "Allow update own or admin" ON subscriptions FOR UPDATE USING (
  user_id = auth.uid() OR is_admin()
);

-- DELETE: admin
CREATE POLICY "Allow delete for admin" ON subscriptions FOR DELETE USING (is_admin());
