-- Insert dummy data for Coco Backend
-- This script inserts 2 dummy users, some activity availabilities, bookings, and user_bookings

-- First, create a dummy group for the users
INSERT INTO "public"."groups" ("id", "name", "description", "session", "created_at", "updated_at")
VALUES 
    (1, 'General Users', 'Default group for regular users', 'session_2024', NOW(), NOW()),
    (2, 'Premium Users', 'Premium group with special privileges', 'session_2024', NOW(), NOW());

-- Insert 2 dummy users with UUID
INSERT INTO "public"."users" ("id", "group_id", "name", "email", "password_hash", "created_at", "updated_at")
VALUES 
    -- User 1: John Doe
    (gen_random_uuid(), 1, 'John Doe', 'john.doe@example.com', '$2b$10$eImiTXuWVxfm37uY4JANjOsMULkKYQwRvCgzFfYNYzCQEOH0SX7la', NOW(), NOW()),
    
    -- User 2: Jane Smith  
    (gen_random_uuid(), 2, 'Jane Smith', 'jane.smith@example.com', '$2b$10$eImiTXuWVxfm37uY4JANjOsMULkKYQwRvCgzFfYNYzCQEOH0SX7la', NOW(), NOW());

-- Insert some activity availabilities (referencing existing activity packages)
INSERT INTO "public"."activity_availabilities" ("id", "activity_package_id", "date", "start_time", "end_time", "available_slots", "created_at", "updated_at")
VALUES 
    (1, 1, '2024-08-25 00:00:00+00', '09:00:00', '16:00:00', 10, NOW(), NOW()),
    (2, 2, '2024-08-26 00:00:00+00', '09:00:00', '16:00:00', 4, NOW(), NOW()),
    (3, 3, '2024-08-27 00:00:00+00', '10:00:00', '15:00:00', 15, NOW(), NOW()),
    (4, 5, '2024-08-28 00:00:00+00', '08:30:00', '16:30:00', 12, NOW(), NOW());

-- Insert 2 bookings (we'll get the user IDs dynamically)
WITH user_ids AS (
    SELECT id, ROW_NUMBER() OVER (ORDER BY created_at) as rn 
    FROM users 
    WHERE email IN ('john.doe@example.com', 'jane.smith@example.com')
)
INSERT INTO "public"."bookings" ("id", "user_id", "availability_id", "participants", "total_price", "status", "created_at", "updated_at")
VALUES 
    -- Booking 1: John Doe books Raja Ampat Group Package
    (1, (SELECT id FROM user_ids WHERE rn = 1), 1, 6, 3900000.00, 'confirmed', NOW(), NOW()),
    
    -- Booking 2: Jane Smith books Gili Islands Public Trip
    (2, (SELECT id FROM user_ids WHERE rn = 2), 3, 2, 300000.00, 'pending', NOW(), NOW());

-- Insert user_bookings to establish the many-to-many relationship
WITH user_ids AS (
    SELECT id, ROW_NUMBER() OVER (ORDER BY created_at) as rn 
    FROM users 
    WHERE email IN ('john.doe@example.com', 'jane.smith@example.com')
)
INSERT INTO "public"."user_bookings" ("user_id", "booking_id", "created_at", "updated_at")
VALUES 
    -- Link John Doe to his booking
    ((SELECT id FROM user_ids WHERE rn = 1), 1, NOW(), NOW()),
    
    -- Link Jane Smith to her booking  
    ((SELECT id FROM user_ids WHERE rn = 2), 2, NOW(), NOW());

-- Display the inserted data
SELECT 'Users inserted:' as info;
SELECT id, name, email, group_id FROM users WHERE email IN ('john.doe@example.com', 'jane.smith@example.com');

SELECT 'Activity Availabilities inserted:' as info;
SELECT id, activity_package_id, date, available_slots FROM activity_availabilities WHERE id BETWEEN 1 AND 4;

SELECT 'Bookings inserted:' as info;
SELECT b.id, u.name as user_name, b.participants, b.total_price, b.status 
FROM bookings b 
JOIN users u ON b.user_id = u.id 
WHERE b.id IN (1, 2);

SELECT 'User Bookings relationships:' as info;
SELECT ub.id, u.name as user_name, b.id as booking_id 
FROM user_bookings ub 
JOIN users u ON ub.user_id = u.id 
JOIN bookings b ON ub.booking_id = b.id 
WHERE b.id IN (1, 2);