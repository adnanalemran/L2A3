-- =========================================================================
-- SYSTEM: Football Ticket Booking System Database Setup Template
-- DESCRIPTION: Pseudo-DDL Template for Table Creation & Data Insertion

-- =========================================================================
-- 1. CREATE USERS TABLE
-- =========================================================================
CREATE TABLE Users (
  user_id SERIAL PRIMARY KEY,
  full_name VARCHAR(100),
  email VARCHAR(50) UNIQUE,
  role VARCHAR(50) NOT NULL CHECK (role IN ('Ticket Manager', 'Football Fan')),
  phone_number VARCHAR(20) 
);

-- =========================================================================
-- 2. CREATE MATCHES TABLE
-- =========================================================================
CREATE TABLE Matches (
  match_id SERIAL PRIMARY KEY,
  fixture VARCHAR(150) NOT NULL,
  tournament_category VARCHAR(100) NOT NULL,
  base_ticket_price DECIMAL(10, 2) NOT NULL CHECK (base_ticket_price >= 0),
  match_status VARCHAR(50) NOT NULL CHECK (
    match_status IN (
      'Available',
      'Selling Fast',
      'Sold Out',
      'Postponed'
    )
  )
);

-- =========================================================================
-- 3. CREATE BOOKINGS TABLE
-- =========================================================================
CREATE TABLE Bookings (
  booking_id SERIAL PRIMARY KEY,
  user_id INT NOT NULL,
  match_id INT NOT NULL,
  seat_number VARCHAR(20),
  payment_status VARCHAR(50),
  CHECK (
    payment_status IN ('Pending', 'Confirmed', 'Cancelled', 'Refunded')
  ),
  total_cost DECIMAL(10, 2) NOT NULL,

  CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE,
  CONSTRAINT fk_match FOREIGN KEY (match_id) REFERENCES matches (match_id) ON DELETE CASCADE
 
);