-- Seed test user: username "admin", password "password123"
-- Using bcrypt salt embedded in hash
INSERT INTO users (username, salt, hashed_password)
SELECT 'admin', '$2a$10$RZVmN.BJ.9GYayHfO4.Sqe', '$2a$10$RZVmN.BJ.9GYayHfO4.SqeemA6pB39mZr2bGV2vqPiGxW7asQ40lu'
WHERE NOT EXISTS (SELECT 1 FROM users WHERE username = 'admin');