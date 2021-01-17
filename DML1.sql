Use Tourplandb
Go
INSERT INTO travelagents (agent_id, agent_name) VALUES 
(1, 'Travelzoo Ltd'),(2, 'Galaxy travel'),
(3, 'Victory Travel'),(4, 'Dynamic Travel'), 
(5, 'Tour Pedia travel') 
Go
INSERT INTO tourpackages (package_id, package_category, package_name, cost_per_person, tour_time) 
VALUES 
(1, 'Inbound', 'Coxsbazar',10000,'3 days'),
(2, 'Outbound', 'Singapore',50000,'7 days'),
(3, 'Inbound', 'Saint Martin',18000,'4 days'),
(4, 'Outbound', 'India city',25000,'6 days'),
(5, 'Inbound', 'Sajek Valley',15000,'3 days'),	   
(6, 'Outbound', 'Saudi Arab',300000,'1 month'),
(7, 'Inbound', 'Khulna city',20000,'5 days'),
(8, 'Outbound', 'Bhutan',35000,'4 days'),
(9, 'Outnbound', 'Sweden',120000,'10 days'),
(10, 'Inbound', 'Banderban',25000,'5 days'),
(11, 'Inbound', 'Rangamati',20000,'3 days'),
(12, 'Outbound', 'Canada',100000,'7 days'),
(13, 'Inbound', 'Sundarban',18000,'3 days'),
(14, 'Outbound', 'Thailand',87000,'7 days'),
(15, 'Outbound', 'Bankok',78000,'3 days')
Go
Insert INTO tourists (tourist_id, tourist_name, tourist_status, tourist_occupation, package_id) 
VALUES (1, 'A', 'New', 'Businessman', 12), 
(2, 'B', 'Regular', 'Student', 3),
(3, 'C', 'Irregular', 'Banker', 15),
(4, 'D', 'New', 'Others', 10),
(5, 'E', 'Regular', 'Businessman', 5),
(6, 'F', 'Irregular', 'Banker', 11),
(7, 'G', 'New', 'Student', 1),
(8, 'H', 'Regular', 'Others', 14),
(9, 'I', 'Irregular', 'Businessman', 12),
(10, 'J', 'New', 'Banker', 7),
(11, 'K', 'Regular', 'Others', 8),
(12, 'L', 'Irregular', 'Businessman', 6),
(13, 'M', 'New', 'Others', 13),
(14, 'N', 'Regular', 'Student', 4),
(15, 'O', 'Irregular', 'Banker', 9),
(16, 'P', 'New', 'Businessman', 2),
(17, 'Q', 'Irregular', 'Others', 14)
Go
INSERT INTO package_features 
(feature_id, transport_mode, hotel_booking, package_id) 
VALUES 
(1, 'By Air', '5 star', 15),
(2, 'By Air', '4 star', 14),
(3, 'By Train', '3 star', 13),
(4, 'By Air', '5 star', 12),
(5, 'By Bus', '3 star', 11),
(6, 'By Bus', '3 star', 10),
(7, 'By Air', '4 star', 9),
(8, 'By Air', '4 star', 8),
(9, 'By Train', '4 star', 7),
(10, 'By Train', '5 star', 6),
(11, 'By Air', '4 star', 5),
(12, 'By Bus', '4 star', 4),
(13, 'By Air', '5 star', 3),
(14, 'By Water', '5 star', 2),
(15, 'By Bus', '5 star', 1)
Go
INSERT INTO agent_tourpackages (agent_id, package_id)
VALUES 
(1, 15), (1, 3), (1, 5),(1, 13),(1,4),
(2, 4), (2, 8), (2,11),(2, 7),(2, 12),
(3, 9), (3, 13), (3, 7), (3,1), (3,8),
(4, 10), (4, 2), (4, 1), (4, 11),(4, 3),
(5, 6), (5, 14), (5, 12), (5, 2), (5, 11)
Go
SELECT *
FROM travelagents
Go
SELECT *
FROM tourpackages
Go
SELECT *
FROM tourists
Go
SELECT *
FROM package_features
Go
SELECT  *
FROM agent_tourpackages
Go
--test trigger
EXEC spInsert_travelagents 'Outing Vista'
GO
SELECT  * 
FROM travelagents
Go
EXEC spUpdate_travelagents 7, 'Dhaka Tour Agency'
GO
SELECT  * 
FROM travelagents
Go
exec spDelete_travelagents 7
go
SELECT  * 
FROM travelagents
Go
--index
EXEC sp_helpindex 'tourpackages'
GO
------Sub Query (Counting the number of of tourists who takes different tour packages from Travelzoo Agency)
SELECT tourist_name, package_category ,agent_id, tourist_occupation, count(tourist_id) 'Tourists_Travelzoo_Ltd'
FROM tourists t
INNER JOIN tourpackages tp
ON t.package_id=tp.package_id
INNER JOIN agent_tourpackages atp
ON tp.package_id= atp.package_id
GROUP BY tourist_name, tourist_occupation, package_category,agent_id
HAVING atp.agent_id = 1
Go
--test view
SELECT * 
FROM v_tour_Info
GO
SELECT * FROM fnTable(3)
GO
--test trigger
INSERT INTO agent_tourpackages
VALUES (2,15)
Go