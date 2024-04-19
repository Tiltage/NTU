INSERT INTO mall (mmid, address, num_shops, num_restaurant) VALUES
(1, '1 Jurong West Central 2', 2, 2),
(1, '14 Scotts Road Far East Plaza', 4, 4),
(2, '68 Orchard Rd', 3, 6),
(2, '10 Bayfront Avenue', 6, 3),
(2, '1 Harbourfront Walk', 3, 4),
(2, '200 Victoria Street', 7, 7),
(1, '3 Temasek Boulevard', 5, 4),
(2, '2 Orchard Turn', 3, 6),
(2, '78 Airport Boulevard', 7, 1);

INSERT INTO mall_mgmt_company (name) VALUES
('Capitaland'),
('Singapore Press Holdings');

INSERT INTO related (UID1, UID2, type) VALUES
(44, 45, 'Family'),
(44, 46, 'Family'),
(45, 44, 'Family'),
(45, 46, 'Family'),
(46, 44, 'Family'),
(46, 45, 'Family');

INSERT INTO related (UID1, UID2, type) VALUES
(11, 12, 'Friends'),
(12, 11, 'Friends'),
(19, 20, 'Friends'),
(20, 19, 'Friends'),
(21, 41, 'Friends'),
(41, 21, 'Friends');

INSERT INTO dine (UID, OID, date_time_in, amount_spent, date_time_out) VALUES
(5, 15, '2024-03-18 12:30:00', 10.50, '2024-03-18 14:00:00'),
(6, 15, '2024-03-18 12:30:00', 10.50, '2024-03-18 14:00:00'),
(7, 15, '2024-03-18 12:30:00', 10.50, '2024-03-18 14:00:00'),
(8, 15, '2024-03-18 12:30:00', 10.50, '2024-03-18 14:00:00');

INSERT INTO dine (UID, OID, date_time_in, amount_spent, date_time_out) VALUES
(5, 20, '2024-03-20 12:30:00', 10.50, '2024-03-20 14:00:00'),
(6, 20, '2024-03-20 12:30:00', 10.50, '2024-03-20 14:00:00'),
(7, 20, '2024-03-20 12:30:00', 10.50, '2024-03-20 14:00:00'),
(8, 20, '2024-03-20 12:30:00', 10.50, '2024-03-20 14:00:00');

INSERT INTO dine (UID, OID, date_time_in, amount_spent, date_time_out) VALUES
(5, 7, '2024-02-01 12:30:00', 10.50, '2024-02-01 14:00:00'),
(6, 7, '2024-02-01 12:30:00', 10.50, '2024-02-01 14:00:00'),
(7, 7, '2024-02-01 12:30:00', 10.50, '2024-02-01 14:00:00'),
(8, 7, '2024-02-01 12:30:00', 10.50, '2024-02-01 14:00:00');

INSERT INTO dine (UID, OID, date_time_in, amount_spent, date_time_out) VALUES
(32, 11, '2024-03-17 09:45:00', 8.75, '2024-03-17 11:15:00'),
(33, 11, '2024-03-17 09:45:00', 8.75, '2024-03-17 11:15:00'),
(32, 9, '2024-03-16 15:20:00', 12.40, '2024-03-16 17:00:00'),
(33, 9, '2024-03-16 15:20:00', 12.40, '2024-03-16 17:00:00');

INSERT INTO day_package(DID, date_of_use, description, pack_vid) VALUES
(1, '2024-03-05 00:00:00', 'SG Zoo & Night Safari', 1),
(2, '2024-04-08 00:00:00', 'Gardens by the Bay & Marina Bay Sands Skypark', 4),
(3, '2024-05-11 00:00:00', 'Sentosa Island (S.I.) Adventure Cove Waterpark', 3),
(4, '2024-06-14 00:00:00', 'SG Flyer & SG River Safari', 7),
(5, '2024-07-17 00:00:00', 'Universal Studios Singapore (USS)', 5),
(6, '2024-08-20 00:00:00', 'S.I. S.E.A. Aquarium', 6),
(7, '2024-09-23 00:00:00', 'S.I. Skyline Luge & S.I. Cable Car', 2),
(8, '2024-10-26 00:00:00', 'SG Science Centre & SG ArtScience Museum', 8),
(9, '2024-11-29 00:00:00', 'Merlion Park & Singapore River Cruise', 16),
(10, '2024-12-02 00:00:00', 'Little India & Chinatown', 10),
(11, '2025-01-05 00:00:00', 'SG Botanic Gardens & National Orchid Garden', 20),
(12, '2025-02-08 00:00:00', 'Clarke Quay & Boat Quay', 11),
(13, '2024-03-11 00:00:00', 'Singapore Night Markets: Bugis Street & Chinatown', 12),
(14, '2024-04-14 00:00:00', 'Katong & Joo Chiat Heritage Trail', 17),
(15, '2024-05-17 00:00:00', 'Kampong Glam & Sultan Mosque', 5),
(16, '2024-06-20 00:00:00', 'Singapore River Night Cruise & Quayside Dining', 15),
(17, '2024-07-23 00:00:00', 'Haji Lane & Arab Street', 19),
(18, '2024-08-26 00:00:00', 'Peranakan Museum & Baba House', 9),
(19, '2024-09-29 00:00:00', 'Singapore Hawker Centers: Maxwell Food Centre & Lau Pa Sat', 18),
(20, '2024-10-02 00:00:00', 'Singapore Botanic Gardens Symphony Lake', 13),
(21, '2024-03-19 14:15:00.000', 'SG Botanic Gardens & National Orchid Garden', 3),
(22, '2024-03-23 12:30:00.000', 'Katong & Joo Chiat Heritage Trail', 4),
(23, '2024-03-18 20:00:00.000', 'S.I. Skyline Luge & S.I. Cable Car', 2);

INSERT INTO day_package_user (DID, UID) VALUES
(21, 2),
(21, 3),
(21, 4),
(21, 5),
(22, 2),
(22, 3),
(22, 4),
(22, 5),
(23, 40),
(23, 41);

INSERT INTO day_package_mall (DID, MID) VALUES
(21, 3),
(22, 5),
(23, 4);

INSERT INTO day_package(DID, date_of_use, description, pack_vid) VALUES
(24, '2024-03-16 15:20:00.000', 'Discount at KFC', 5),
(25, '2024-03-16 15:20:00.000', 'Buy 3 get 1 free', 2);

INSERT INTO day_package_user (DID, UID) VALUES
(24, 32),
(24, 33),
(25, 32),
(25, 33);

INSERT INTO day_package_mall (DID, MID) VALUES
(24, 2),
(25, 6);
