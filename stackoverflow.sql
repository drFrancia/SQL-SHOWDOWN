--Primer ejercicio
SELECT TOP (200) DisplayName, Location, Reputation
FROM Users
ORDER BY Reputation DESC

--Segundo Ejercicio
SELECT TOP (200) p.Title, u.DisplayName
FROM dbo.Posts p
JOIN dbo.Users u ON p.OwnerUserId = u.Id
WHERE p.Title IS NOT NULL
AND u.DisplayName IS NOT NULL;

-- Tercer Ejercicio
SELECT TOP (200) u.DisplayName, AVG(CAST(p.Score AS FLOAT)) AS AverageScore
FROM Users u
INNER JOIN Posts p ON u.Id = p.OwnerUserId
WHERE p.OwnerUserId IS NOT NULL
GROUP BY u.id, u.Displayname
ORDER BY AverageScore DESC

--Cuarto Ejercicio
SELECT TOP (200) u.DisplayName
FROM Users u
WHERE u.id IN (
	SELECT UserId
		FROM Comments
		GROUP BY UserId
		HAVING COUNT(*) > 100
)

-- Quinto Ejercicio
UPDATE Users
SET Location = 'unknown'
WHERE Location IS NULL OR TRIM(Location) = ''

PRINT 'La actualizacion se realizo correctamente. Se actualizaron' + CAST(@@ROWCOUNT AS VARCHAR(10)) + 'filas.'

-- Para visualizar los users con locaciones dessconocidas
SELECT TOP (200) Displayname, Location 
FROM Users
ORDER BY DisplayName

--Sexto Ejercicio
DELETE Comments
FROM Comments
JOIN Users On Comments.UserId = Users.Id
WHERE Users.Reputation < 100;

DECLARE @DeletedCount INT;
SET @DeletedCount = @@ROWCOUNT;
PRINT CAST(@DeletedCount AS VARCHAR) + ' comentarios fueron eliminados.';

--Septimo Ejercicio
SELECT OwnerUserId, COUNT(*) AS TotalPosts
FROM Posts
GROUP BY OwnerUserId;

SELECT UserId, COUNT(*) AS TotalComments
FROM Comments
GROUP BY UserId;

SELECT UserId, COUNT(*) AS TotalBadges
FROM Badges
GROUP BY UserId;

SELECT u.DisplayName AS DisplayName,
    COALESCE(tp.TotalPosts, 0) AS TotalPosts,
    COALESCE(tc.TotalComments, 0) AS TotalComments,
    COALESCE(tb.TotalBadges, 0) AS TotalBadges
FROM Users u
LEFT JOIN (
    SELECT OwnerUserId, COUNT(*) AS TotalPosts
    FROM Posts
    GROUP BY OwnerUserId
) tp ON u.Id = tp.OwnerUserId
LEFT JOIN (
    SELECT UserId, COUNT(*) AS TotalComments
    FROM Comments
    GROUP BY UserId
) tc ON u.Id = tc.UserId
LEFT JOIN (
    SELECT UserId, COUNT(*) AS TotalBadges
    FROM Badges
    GROUP BY UserId
) tb ON u.Id = tb.UserId
ORDER BY u.DisplayName;

--Octavo Ejercicio
SELECT TOP 10
    Title, 
    Score 
FROM 
    Posts
ORDER BY 
    Score DESC;

-- Noveno Ejercicio

SELECT TOP 5
    Text, 
    CreationDate 
FROM 
    Comments
ORDER BY 
    CreationDate DESC;

