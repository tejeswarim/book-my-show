DROP DATABASE IF EXISTS book_my_show;

CREATE database book_my_show;

USE book_my_show;

CREATE TABLE address (
    address_id VARCHAR(10) PRIMARY KEY,
    city VARCHAR(20) NOT NULL,
    pincode VARCHAR(6) NOT NULL,
    address_line VARCHAR(50),
    landmark VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE theatre (
    theatre_id VARCHAR(10) PRIMARY KEY,
    theatre_name VARCHAR(50) NOT NULL,
    address_id VARCHAR(10),
    FOREIGN KEY (address_id)
        REFERENCES address(address_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE movie (
    movie_id VARCHAR(10) PRIMARY KEY,
    movie_name VARCHAR(50) NOT NULL,
    movie_language VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE screen (
    screen_id VARCHAR(10) PRIMARY KEY,
    screen_type VARCHAR(2) NOT NULL,
    movie_id VARCHAR(10),
    theatre_id VARCHAR(10),
    FOREIGN KEY (movie_id)
        REFERENCES movie (movie_id),
    FOREIGN KEY (theatre_id)
        REFERENCES theatre (theatre_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE movie_show (
    show_id VARCHAR(10) PRIMARY KEY,
    show_date DATE NOT NULL,
    show_time TIME NOT NULL,
    screen_id VARCHAR(10),
    FOREIGN KEY (screen_id)
        REFERENCES screen (screen_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


INSERT INTO address (address_id, city, pincode, address_line, landmark)
VALUES
('A1', 'Bangalore', '560017', 'BTM', 'Koramangala'),
('A2', 'Bangalore', '560018', 'BTM', 'Jayanagar');


INSERT INTO theatre (theatre_id, theatre_name, address_id)
VALUES
('T1', 'PVR-NEXUS', 'A1'),
('T2', 'PVR-INOX', 'A2');


INSERT INTO movie (movie_id, movie_name, movie_language)
VALUES
('M1', 'Dasara', 'Telugu'),
('M2', 'Hanuman', 'Telugu'),
('M3', 'Salaar', 'Telugu');


INSERT INTO screen (screen_id, screen_type, movie_id, theatre_id)
VALUES
('SC1', '2D', 'M1', 'T1'),
('SC2', '3D', 'M2', 'T2'),
('SC3', '2D', 'M3', 'T1');


INSERT INTO movie_show (show_id, show_date, show_time, screen_id)
VALUES
('S1', '2025-09-22', '12:15:00', 'SC1'),
('S2', '2025-09-22', '12:15:00', 'SC2'),
('S3', '2025-09-22', '12:15:00', 'SC3'),
('S4', '2025-09-22', '01:30:00', 'SC1'),
('S5', '2025-09-22', '01:30:00', 'SC2'),
('S6', '2025-09-22', '01:30:00', 'SC3'),
('S7', '2025-09-22', '04:00:00', 'SC1'),
('S8', '2025-09-22', '04:00:00', 'SC2'),
('S9', '2025-09-22', '04:00:00', 'SC3'),
('S10', '2025-09-23', '12:15:00', 'SC1'),
('S11', '2025-09-23', '12:15:00', 'SC2'),
('S12', '2025-09-23', '12:15:00', 'SC3'),
('S13', '2025-09-25', '01:30:00', 'SC1'),
('S14', '2025-09-24', '01:30:00', 'SC2'),
('S15', '2025-09-26', '01:30:00', 'SC3'),
('S16', '2025-09-28', '04:00:00', 'SC1'),
('S17', '2025-09-29', '04:00:00', 'SC2'),
('S18', '2025-09-30', '04:00:00', 'SC3');


SELECT 
    ms.show_id, ms.show_date, ms.show_time, sc.screen_id, sc.screen_type, t.theatre_name, m.movie_name, m.movie_language
FROM
    movie_show AS ms
        LEFT JOIN
    screen AS sc ON ms.screen_id = sc.screen_id
        LEFT JOIN
    theatre AS t ON sc.theatre_id = t.theatre_id
		LEFT JOIN
	movie as m ON sc.movie_id = m.movie_id
WHERE
    ms.show_date = '2025-09-22'
        AND theatre_name = 'PVR-NEXUS';

