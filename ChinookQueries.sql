--1. Top-Selling Products
select top 10
 t.Name AS TrackName ,
 SUM(i.Quantity) AS TotalSold ,
 ROUND(SUM(i.UnitPrice * i.Quantity), 2) AS TotalRevenue  
from InvoiceLine i , Track t
WHERE i.TrackId=t.TrackId
group by t.name
ORDER BY TotalRevenue DESC;


--2. Revenue per Country
select c.Country ,
COUNT(DISTINCT c.CustomerId) AS unique_buyers,
COUNT(i.InvoiceId) AS number_of_invoices,
SUM(i.Total) As TotalRevenue 
from Customer c , invoice i
where c.CustomerId=i.CustomerId
group by c.Country
ORDER BY TotalRevenue DESC;


--3. Monthly Performance(Trend)
SELECT 
    FORMAT(InvoiceDate, 'MMMM') AS Months,
    SUM(Total) AS Monthly_Revenue,
	COUNT(InvoiceId) AS total_orders
FROM Invoice
Group By FORMAT(InvoiceDate, 'MMMM')
ORDER BY Monthly_Revenue DESC


--4. Top 5 Customers by Total Spending
select top 10
c.FirstName+' '+c.LastName as Customer_Fullname ,
sum(i.Total) as TotalSpent ,
 RANK() OVER (ORDER BY SUM(i.total) DESC) AS rank
from Customer c , Invoice i
where c.CustomerId=i.CustomerId
group by c.FirstName , c.LastName
ORDER BY rank


--5. Top Genres by Revenue
Select top 10
    g.name AS genre_name,
	SUM(il.UnitPrice * il.quantity) AS revenue
From 
	genre g
JOIN
	track t ON g.GenreId = t.GenreId
JOIN 
	InvoiceLine il ON t.TrackId = il.TrackId
Group BY g.name
Order By revenue DESC
