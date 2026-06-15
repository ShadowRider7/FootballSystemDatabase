
-- DROP TABLES IF THEY ALREADY EXIST TO PREVENT CONFLICTS
DROP TABLE IF EXISTS Bookings;
DROP TABLE IF EXISTS Matches;
DROP TABLE IF EXISTS Users;

-- =========================================================================
-- 1. CREATE USERS TABLE
-- =========================================================================
CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    role VARCHAR(50) NO NULL,
    phone_number VARCHAR(20),
    
   CONSTRAINT chk_users_role CHECK (role IN ('Ticket Manager', 'Football Fan'))
);

-- =========================================================================
-- 2. CREATE MATCHES TABLE
-- =========================================================================
CREATE TABLE Matches (
    match_id INT PRIMARY KEY,
    fixture VARCHAR(150) NOT NULL,
    tournament_category VARCHAR(100) NOT NULL ,
    base_ticket_price dECIMAL(10,2) NOT NULL CHECK (base_ticket_price >= 0),
    match_status VARCHAR(50) NOT NULL ,

   CONSTRAINT chk_match_status CHECK (match_status IN ('Available', 'Selling Fast', 'Sold Out', 'Postponed'))
);

-- =========================================================================
-- 3. CREATE BOOKINGS TABLE
-- =========================================================================
CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY,
    user_id INT NOT NULL REFERENCES Users(user_id),
    match_id INT NOT NULL REFERENCES Matches(match_id),
    seat_number VARCHAR(20),
    payment_status VARCHAR(50),
    total_cost dECIMAL(10,2) NOT NULL CHECK (total_cost >= 0),
    
    CONSTRAINT chk_payment_status CHECK (payment_status IN ('Pending', 'Confirmed', 'Cancelled', 'Refunded'))
);

INSERT INTO Users (user_id, full_name, email, role, phone_number) VALUES
(1, 'Tanvir Rahman', 'tanvir@mail.com', 'Football Fan', '+8801711111111'),
(2, 'Asif Haque', 'asif@mail.com', 'Football Fan', '+8801722222222'),
(3, 'Sajjad Rahman', 'sajjad@mail.com', 'Ticket Manager', '+8801733333333'),
(4, 'Jannat Ara', 'jannat@mail.com', 'Football Fan', NULL),
(5, 'John Doe', 'john@mail.com', 'Football Fan', '+15550100'),
(6, 'Jane Smith', 'jane@mail.com', 'Football Fan', '+15550200'),
(7, 'Carlos Gomez', 'carlos@mail.com', 'Football Fan', '+34600111'),
(8, 'Fatima Al-Sayed', 'fatima@mail.com', 'Football Fan', '+97150111'),
(9, 'Koji Tanaka', 'koji@mail.com', 'Ticket Manager', '+81901111'),
(10, 'Marie Dubois', 'marie@mail.com', 'Football Fan', '+3361111'),
(11, 'Luca Rossi', 'luca@mail.com', 'Football Fan', '+39021111'),
(12, 'Yuri Smirnov', 'yuri@mail.com', 'Football Fan', '+79011111'),
(13, 'Amara Okafor', 'amara@mail.com', 'Football Fan', '+23480111'),
(14, 'Liam Neeson', 'liam@mail.com', 'Football Fan', '+44201111'),
(15, 'Sofia Rodriguez', 'sofia@mail.com', 'Ticket Manager', '+52551111'),
(16, 'Ali Yilmaz', 'ali@mail.com', 'Football Fan', '+90532111'),
(17, 'Min-Jun Kim', 'minjun@mail.com', 'Football Fan', '+82101111'),
(18, 'Emma Watson', 'emma@mail.com', 'Football Fan', '+44791111'),
(19, 'David Beckham', 'david@mail.com', 'Football Fan', '+44781111'),
(20, 'Zinedine Zidane', 'zinedine@mail.com', 'Ticket Manager', '+3362222');

INSERT INTO Matches (match_id, fixture, tournament_category, base_ticket_price, match_status) VALUES
(101, 'Real Madrid vs Barcelona', 'Champions League', 150.00, 'Available'),
(102, 'Man City vs Liverpool', 'Premier League', 120.00, 'Selling Fast'),
(103, 'Bayern Munich vs PSG', 'Champions League', 130.00, 'Available'),
(104, 'AC Milan vs Inter Milan', 'Serie A', 90.00, 'Sold Out'),
(105, 'Juventus vs Roma', 'Serie A', 80.00, 'Available'),
(106, 'Arsenal vs Chelsea', 'Premier League', 110.00, 'Available'),
(107, 'Dortmund vs Bayern Munich', 'Bundesliga', 100.00, 'Selling Fast'),
(108, 'Atletico Madrid vs Real Madrid', 'La Liga', 115.00, 'Available'),
(109, 'PSG vs Marseille', 'Ligue 1', 95.00, 'Available'),
(110, 'Ajax vs Feyenoord', 'Eredivisie', 75.00, 'Sold Out'),
(111, 'FC Porto vs Benfica', 'Primeira Liga', 70.00, 'Available'),
(112, 'Napoli vs AC Milan', 'Serie A', 85.00, 'Selling Fast'),
(113, 'Spurs vs Arsenal', 'Premier League', 105.00, 'Available'),
(114, 'Man United vs Man City', 'Premier League', 125.00, 'Sold Out'),
(115, 'Barcelona vs Atletico Madrid', 'La Liga', 110.00, 'Available'),
(116, 'Boca Juniors vs River Plate', 'Primera Division', 85.00, 'Postponed'),
(117, 'Celtic vs Rangers', 'Premiership', 65.00, 'Selling Fast'),
(118, 'Galatasaray vs Fenerbahce', 'Süper Lig', 70.00, 'Available'),
(119, 'Inter Milan vs Juventus', 'Serie A', 95.00, 'Available'),
(120, 'Liverpool vs Real Madrid', 'Champions League', 160.00, 'Selling Fast');

INSERT INTO Bookings (booking_id, user_id, match_id, seat_number, payment_status, total_cost) VALUES
(501, 1, 101, 'A-12', 'Confirmed', 150.00),
(502, 1, 102, 'B-04', 'Confirmed', 120.00),
(503, 2, 101, 'A-13', 'Confirmed', 150.00),
(504, 2, 101, NULL, NULL, 150.00),
(505, 3, 102, 'C-20', 'Pending', 120.00),
(506, 5, 106, 'D-10', 'Confirmed', 110.00),
(507, 6, 107, 'E-15', 'Confirmed', 100.00),
(508, 7, 108, 'F-02', 'Pending', 115.00),
(509, 8, 109, 'G-08', 'Confirmed', 95.00),
(510, 10, 111, 'H-14', 'Cancelled', 70.00),
(511, 11, 112, 'I-19', 'Confirmed', 85.00),
(512, 12, 113, 'J-03', 'Confirmed', 105.00),
(513, 13, 115, 'K-22', 'Confirmed', 110.00),
(514, 14, 117, 'L-05', 'Pending', 65.00),
(515, 16, 118, 'M-11', 'Confirmed', 70.00),
(516, 17, 119, 'N-07', 'Confirmed', 95.00),
(517, 18, 120, 'O-09', 'Confirmed', 160.00),
(518, 19, 120, 'O-10', 'Confirmed', 160.00),
(519, 5, 103, 'P-01', 'Refunded', 130.00),
(520, 6, 105, 'Q-18', 'Confirmed', 80.00);


-- Query 1: Retrieve all upcoming football matches belonging to the 'Champions League' where the match status is 'Available'.

SELECT * FROM Matches WHERE tournament_category = 'Champions League' AND match_status='Available';

-- Query 2: Search for all users whose full names start with 'Tanvir' or contain the phrase 'Haque' (case-insensitive).

SELECT * FROM Users WHERE full_name ILIKE 'Tanvir%' OR full_name ILIKE '%Haque%';

-- Query 3: Retrieve all booking records where the payment status is missing (NULL), replacing the empty result with 'Action Required'.

SELECT booking_id,user_id,match_id, COALESCE(payment_status,'Action Required') AS Systematic_Status  FROM Bookings WHERE payment_status IS NULL;