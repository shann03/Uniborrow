/*
  # Create Admin User
  
  1. Creates admin@gmail.com user with password admin123
  2. Sets up admin role in app metadata
  
  NOTE: This migration uses the Supabase admin API to create the user
*/

-- Create the admin user in auth.users table
-- Note: In production, use the Admin API to create users with passwords
INSERT INTO auth.users (
  id,
  instance_id,
  email,
  encrypted_password,
  email_confirmed_at,
  raw_app_meta_data,
  raw_user_meta_data,
  created_at,
  updated_at,
  confirmation_token,
  recovery_token,
  email_change_token_new
)
SELECT
  gen_random_uuid(),
  '00000000-0000-0000-0000-000000000000',
  'admin@gmail.com',
  crypt('admin123', gen_salt('bf')),
  now(),
  jsonb_build_object('role', 'admin'),
  jsonb_build_object('full_name', 'Admin User'),
  now(),
  now(),
  '',
  '',
  ''
WHERE NOT EXISTS (
  SELECT 1 FROM auth.users WHERE email = 'admin@gmail.com'
);
