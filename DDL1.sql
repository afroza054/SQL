--DROP DATABASE Tourplandb
--Go
--------Database Create

--CREATE DATABASE Tourplandb
--GO

Use Tourplandb
Go
----------Table Creation
CREATE TABLE travelagents
(
     agent_id INT PRIMARY KEY,
	 agent_name NVARCHAR(50) NOT NULL
)
GO
CREATE TABLE tourpackages
(
      package_id INT PRIMARY KEY,
	  package_category NVARCHAR(50) NOT NULL,
	  package_name NVARCHAR(50) NOT NULL,
	  cost_per_person MONEY NOT NULL,
	  tour_time NVARCHAR(50) NOT NULL
)
Go

CREATE TABLE tourists
(
       tourist_id INT PRIMARY KEY,
	   tourist_name NVARCHAR(50) NOT NULL,
	   tourist_status NVARCHAR(50) NOT NULL,
	   tourist_occupation NVARCHAR(50) NOT NULL,
	   package_id INT NOT NULL REFERENCES tourpackages (package_id)
)
Go

CREATE TABLE package_features
(
      feature_id INT PRIMARY KEY,
	  transport_mode NVARCHAR(50) NOT NULL,
	  hotel_booking NVARCHAR(50) NOT NULL,
	  package_id INT NOT NULL REFERENCES tourpackages (package_id)
)	  
Go

	  
CREATE TABLE agent_tourpackages
(
     agent_id INT NOT NULL REFERENCES travelagents (agent_id),
	 package_id INT NOT NULL REFERENCES tourpackages(package_id),
	 PRIMARY KEY(agent_id,package_id)
)
Go

------------------Store procedure 
----------Insert
CREATE PROC spInsert_travelagents @n NVARCHAR(50)
AS
DECLARE @id INT
SELECT @id = ISNULL(MAX(agent_id), 0)+1 FROM travelagents
BEGIN TRY
	INSERT INTO travelagents(agent_id, agent_name)
	VALUES (@id, @n)
	RETURN @id
END TRY
BEGIN CATCH
	;
	THROW 50001, 'Error encountered', 1
	RETURN 0
END CATCH
GO

------Update
CREATE PROC spUpdate_travelagents @id INT,@n NVARCHAR(50)
AS
BEGIN TRY
	UPDATE travelagents
	SET agent_name = @n
	WHERE agent_id = @id
END TRY
BEGIN CATCH
	;
	THROW 50001, 'Error encountered', 1
	RETURN 0
END CATCH
GO

-----------Delete
CREATE PROC spDelete_travelagents @id INT
AS
BEGIN TRY
	DELETE travelagents
	WHERE agent_id = @id
END TRY
BEGIN CATCH
	;
	THROW 50001, 'Error encountered', 1
	RETURN 0
END CATCH
GO
---------------nonclustered
CREATE NONCLUSTERED INDEX ixpackagename 
ON tourpackages(package_id)
GO

----View
CREATE VIEW v_tour_Info
AS
SELECT tourist_name, package_category ,agent_id, tourist_occupation
FROM tourists t
INNER JOIN tourpackages tp
ON t.package_id=tp.package_id
INNER JOIN agent_tourpackages atp
ON tp.package_id= atp.package_id
Go

--------A table valued function
CREATE FUNCTION fnTable(@agent_id INT) RETURNS TABLE
AS
RETURN
(
SELECT tourist_name, package_category ,agent_id, tourist_occupation
FROM tourists t
INNER JOIN tourpackages tp
ON t.package_id=tp.package_id
INNER JOIN agent_tourpackages atp
ON tp.package_id= atp.package_id
WHERE agent_id=@agent_id
)
Go
--------------------------------TRIGGERRRRRRRRRRRR
CREATE TRIGGER tragent_packages
ON agent_tourpackages for insert 
AS 
BEGIN
DECLARE @agentid int
SELECT @agentid=agent_id FROM inserted
	IF exists
		(
			SELECT count(*), agent_id FROM agent_tourpackages
			WHERE agent_id =2
			GROUP BY agent_id
			HAVING count(*) >4
		)
		BEGIN
			ROLLBACK TRANSACTION
			; 
			THROW 50001,'Galaxy agency has already had five packages',1
		END
END
GO 



