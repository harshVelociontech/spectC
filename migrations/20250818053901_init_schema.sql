-- Enable UUID generation
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ENUMS
CREATE TYPE risk_level_enum AS ENUM ('Low', 'Medium', 'High');
CREATE TYPE project_status_enum AS ENUM ('Planning', 'In Progress', 'Review', 'Completed');
CREATE TYPE task_status_enum AS ENUM ('Backlog', 'In Progress', 'Testing', 'Review', 'Completed');
CREATE TYPE task_priority_enum AS ENUM ('Low', 'Medium', 'High', 'Critical');
CREATE TYPE member_status_enum AS ENUM ('Active', 'Inactive');
CREATE TYPE assignee_status_enum AS ENUM ('Assigned', 'In Progress', 'Completed');
CREATE TYPE label_status_enum AS ENUM ('Active', 'Inactive');
CREATE TYPE release_status_enum AS ENUM ('Planning', 'In Development', 'Testing', 'Released');
CREATE TYPE subscription_plan_enum AS ENUM ('Monthly', 'Yearly');
CREATE TYPE payment_status_enum AS ENUM ('Pending', 'Completed', 'Failed');

-- ROLES
CREATE TABLE roles (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(50) UNIQUE NOT NULL,
  description TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- USERS
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

-- PROJECTS
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

-- PROJECT MEMBERS
CREATE TABLE project_members (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  project_id UUID REFERENCES projects(id),
  user_id UUID REFERENCES users(id),
  status member_status_enum DEFAULT 'Active',
  joined_at TIMESTAMP DEFAULT NOW()
);

-- TASKS
CREATE TABLE tasks (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  project_id UUID NOT NULL REFERENCES projects(id),
  title VARCHAR(200) NOT NULL,
  description TEXT,
  status task_status_enum DEFAULT 'Backlog',
  priority task_priority_enum DEFAULT 'Medium',
  progress_percentage INT DEFAULT 0,
  estimated_hours NUMERIC(6,2),
  estimated_days NUMERIC(5,2),
  start_date DATE,
  due_date DATE,
  completed_at DATE,
  created_by UUID NOT NULL REFERENCES users(id),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- WORKFLOWS
CREATE TABLE workflows (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(200) NOT NULL,
  stages VARCHAR[] NOT NULL,
  description TEXT,
  created_by UUID REFERENCES users(id),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- TASK ASSIGNEES
CREATE TABLE task_assignees (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  task_id UUID REFERENCES tasks(id),
  user_id UUID REFERENCES users(id),
  status assignee_status_enum DEFAULT 'Assigned',
  assigned_at TIMESTAMP DEFAULT NOW()
);

-- TASK LABELS
CREATE TABLE task_labels (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  task_id UUID REFERENCES tasks(id),
  name VARCHAR(50) NOT NULL,
  status label_status_enum DEFAULT 'Active',
  UNIQUE (task_id, name)
);

-- RELEASES
CREATE TABLE releases (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(50),
  description VARCHAR(300),
  project_id UUID REFERENCES projects(id),
  version VARCHAR(50) NOT NULL,
  features INT,
  risk_level risk_level_enum DEFAULT 'Low',
  status release_status_enum DEFAULT 'Planning',
  release_date DATE
);

-- TEMPLATES
CREATE TABLE templates (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(200) NOT NULL,
  phase_number INT,
  description TEXT,
  file VARCHAR(255),
  roles UUID[], -- array of role IDs
  ceremonies VARCHAR[], -- array of ceremony names
  created_by UUID REFERENCES users(id),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- USER SETTINGS
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

-- PAYMENT PLANS
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

-- SUBSCRIPTIONS
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

-- PAYMENTS
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
