CREATE TYPE payment_status_enum AS ENUM ('Pending', 'Completed', 'Failed');

-- migrations/0017_create_payments_table.sql

-- Create payments table
CREATE TABLE payments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  subscription_id UUID NOT NULL REFERENCES subscriptions(id),
  user_id UUID NOT NULL REFERENCES users(id),
  amount NUMERIC(12,2) NOT NULL,
  currency VARCHAR(10) DEFAULT 'USD',
  status payment_status_enum DEFAULT 'Pending',
  payment_method VARCHAR(50),
  transaction_id VARCHAR(255) UNIQUE,
  paid_at TIMESTAMP,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE payments ENABLE ROW LEVEL SECURITY;

-- Policies for payments
-- SELECT: own (via user_id) or admin
CREATE POLICY "Allow select own or admin" ON payments FOR SELECT USING (
  user_id = auth.uid() OR is_admin()
);

-- INSERT: own or admin
CREATE POLICY "Allow insert own or admin" ON payments FOR INSERT WITH CHECK (
  new.user_id = auth.uid() OR is_admin()
);

-- UPDATE: own or admin
CREATE POLICY "Allow update own or admin" ON payments FOR UPDATE USING (
  user_id = auth.uid() OR is_admin()
);

-- DELETE: admin
CREATE POLICY "Allow delete for admin" ON payments FOR DELETE USING (is_admin());