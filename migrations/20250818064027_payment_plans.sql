CREATE TYPE subscription_plan_enum AS ENUM ('Monthly', 'Yearly');

-- migrations/0015_create_payment_plans_table.sql

-- Create payment_plans table
CREATE TABLE payment_plans (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(100) NOT NULL,
  description TEXT,
  plan_type subscription_plan_enum NOT NULL,
  price NUMERIC(12,2) NOT NULL,
  currency VARCHAR(10) DEFAULT 'USD',
  duration_in_days INT NOT NULL,
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE payment_plans ENABLE ROW LEVEL SECURITY;

-- Policies for payment_plans (assuming admin only for management)
-- SELECT: authenticated
CREATE POLICY "Allow select for authenticated" ON payment_plans FOR SELECT USING (auth.uid() IS NOT NULL);

-- INSERT: admin
CREATE POLICY "Allow insert for admin" ON payment_plans FOR INSERT WITH CHECK (is_admin());

-- UPDATE: admin
CREATE POLICY "Allow update for admin" ON payment_plans FOR UPDATE USING (is_admin());

-- DELETE: admin
CREATE POLICY "Allow delete for admin" ON payment_plans FOR DELETE USING (is_admin());