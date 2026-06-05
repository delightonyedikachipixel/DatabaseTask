
DROP DATABASE IF EXISTS CapeCoddLagos;
CREATE DATABASE CapeCoddLagos;
USE CapeCoddLagos;


CREATE TABLE InventoryLagos (
  SKU VARCHAR(20),
  SKU_Description VARCHAR(100),
  WarehouseID INT,
  QuantityOnHand INT,
  QuantityOnOrder INT
);

CREATE TABLE WarehouseLagos (
  WarehouseID INT PRIMARY KEY,
  WarehouseCity VARCHAR(50),
  WarehouseState VARCHAR(50),
  Manager VARCHAR(50),
  SquareFeet INT
);


INSERT INTO InventoryLagos VALUES
('SKU001', 'Racket', 1, 5, 2),
('SKU002', 'Baseball', 1, 0, 4),
('SKU003', 'Boots', 2, 10, 0),
('SKU004', 'Tennis', 3, 0, 0);


INSERT INTO WarehouseLagos VALUES
(1, 'Lagos Island', 'Lagos', 'Modupe Daniels', 5000),
(2, 'Lagos Mainland', 'Lagos', 'Adeola Smith', 3000),
(3, 'Lekki', 'Lagos', 'Chinedu Okafor', 4000);



SELECT SKU, SKU_Description FROM InventoryLagos; 
SELECT SKU_Description, SKU FROM InventoryLagos; 
SELECT WarehouseID FROM InventoryLagos; 
SELECT DISTINCT WarehouseID FROM InventoryLagos; 
SELECT SKU, SKU_Description, WarehouseID, QuantityOnHand, QuantityOnOrder FROM InventoryLagos; 
SELECT * FROM InventoryLagos; 
SELECT * FROM InventoryLagos WHERE QuantityOnHand > 0; 
SELECT SKU, SKU_Description FROM InventoryLagos WHERE QuantityOnHand = 0; 
SELECT SKU, SKU_Description, WarehouseID FROM InventoryLagos WHERE QuantityOnHand = 0 ORDER BY WarehouseID ASC; 
SELECT SKU, SKU_Description, WarehouseID FROM InventoryLagos WHERE QuantityOnHand > 0 ORDER BY WarehouseID DESC, SKU ASC; 
SELECT SKU, SKU_Description, WarehouseID FROM InventoryLagos WHERE QuantityOnHand = 0 AND QuantityOnOrder > 0 ORDER BY WarehouseID DESC, SKU ASC; 
SELECT SKU, SKU_Description, WarehouseID FROM InventoryLagos WHERE QuantityOnHand = 0 OR QuantityOnOrder = 0 ORDER BY WarehouseID DESC, SKU ASC; 
SELECT SKU, SKU_Description, WarehouseID, QuantityOnHand FROM InventoryLagos WHERE QuantityOnHand > 1 AND QuantityOnHand < 10; 
SELECT SKU, SKU_Description, WarehouseID, QuantityOnHand FROM InventoryLagos WHERE QuantityOnHand BETWEEN 2 AND 9; -- 2.30
SELECT DISTINCT SKU, SKU_Description FROM InventoryLagos WHERE SKU_Description LIKE 'Racket%'; 
SELECT DISTINCT SKU, SKU_Description FROM InventoryLagos WHERE SKU_Description LIKE '%Climb%'; 
SELECT DISTINCT SKU, SKU_Description FROM InventoryLagos WHERE SKU_Description LIKE '__d%'; 
SELECT SUM(QuantityOnHand) AS Total, COUNT(QuantityOnHand) AS CountItems, MIN(QuantityOnHand) AS MinQty, MAX(QuantityOnHand) AS MaxQty, AVG(QuantityOnHand) AS AvgQty FROM InventoryLagos; 
SELECT WarehouseID, SUM(QuantityOnHand) AS TotalItemsOnHand FROM InventoryLagos GROUP BY WarehouseID ORDER BY TotalItemsOnHand DESC; 
SELECT WarehouseID, SUM(QuantityOnHand) AS TotalItemsOnHandLT3 FROM InventoryLagos WHERE QuantityOnHand < 3 GROUP BY WarehouseID ORDER BY TotalItemsOnHandLT3 DESC; 
SELECT WarehouseID, SUM(QuantityOnHand) AS TotalItemsOnHandLT3 FROM InventoryLagos WHERE QuantityOnHand < 3 GROUP BY WarehouseID HAVING COUNT(SKU) < 2 ORDER BY TotalItemsOnHandLT3 DESC; 




SELECT I.SKU, I.SKU_Description, I.WarehouseID, W.WarehouseCity, W.WarehouseState
FROM InventoryLagos I, WarehouseLagos W
WHERE I.WarehouseID = W.WarehouseID
  AND (W.WarehouseCity = 'Lagos Island' OR W.WarehouseCity = 'Lagos Mainland' OR W.WarehouseCity = 'Lekki'); 

SELECT I.SKU, I.SKU_Description, I.WarehouseID, W.WarehouseCity, W.WarehouseState
FROM InventoryLagos I JOIN WarehouseLagos W ON I.WarehouseID = W.WarehouseID
WHERE W.WarehouseCity IN ('Lagos Island','Lagos Mainland','Lekki'); 

SELECT I.SKU, I.SKU_Description, I.WarehouseID, W.WarehouseCity, W.WarehouseState
FROM InventoryLagos I JOIN WarehouseLagos W ON I.WarehouseID = W.WarehouseID
WHERE W.WarehouseCity <> 'Lagos Island' AND W.WarehouseCity <> 'Lagos Mainland' AND W.WarehouseCity <> 'Lekki'; 

SELECT I.SKU, I.SKU_Description, I.WarehouseID, W.WarehouseCity, W.WarehouseState
FROM InventoryLagos I JOIN WarehouseLagos W ON I.WarehouseID = W.WarehouseID
WHERE W.WarehouseCity NOT IN ('Lagos Island','Lagos Mainland','Lekki'); 

SELECT CONCAT(I.SKU_Description, ' is located in ', W.WarehouseCity) AS ItemLocation
FROM InventoryLagos I JOIN WarehouseLagos W ON I.WarehouseID = W.WarehouseID; 

SELECT SKU, SKU_Description, WarehouseID
FROM InventoryLagos
WHERE WarehouseID IN (SELECT WarehouseID FROM WarehouseLagos WHERE Manager='Modupe Daniels'); 

SELECT I.SKU, I.SKU_Description, I.WarehouseID
FROM InventoryLagos I, WarehouseLagos W
WHERE I.WarehouseID = W.WarehouseID AND W.Manager='Modupe Daniels'; 

SELECT I.SKU, I.SKU_Description, I.WarehouseID
FROM InventoryLagos I JOIN WarehouseLagos W ON I.WarehouseID = W.WarehouseID
WHERE W.Manager='Modupe Daniels'; 

SELECT W.WarehouseID, AVG(I.QuantityOnHand) AS AvgQty
FROM InventoryLagos I JOIN WarehouseLagos W ON I.WarehouseID = W.WarehouseID
WHERE W.Manager='Modupe Daniels'
GROUP BY W.WarehouseID; 

SELECT W.WarehouseID, W.WarehouseCity, W.WarehouseState, W.Manager,
       I.SKU, I.SKU_Description, I.QuantityOnHand
FROM InventoryLagos I JOIN WarehouseLagos W ON I.WarehouseID = W.WarehouseID
WHERE W.Manager='Modupe Daniels'; 

SELECT WarehouseID, SUM(QuantityOnOrder) AS TotalItemsOnOrder, SUM(QuantityOnHand) AS TotalItemsOnHand
FROM InventoryLagos
GROUP BY WarehouseID, QuantityOnOrder; 



SELECT W.WarehouseID, W.WarehouseCity, W.WarehouseState, W.Manager, W.SquareFeet,
       I.SKU, I.SKU_Description, I.WarehouseID, I.QuantityOnHand, I.QuantityOnOrder
FROM WarehouseLagos W
LEFT JOIN InventoryLagos I ON W.WarehouseID = I.WarehouseID;
