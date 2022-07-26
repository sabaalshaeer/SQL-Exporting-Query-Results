-- Sales commission report
SELECT report.repid
	, TRIM(report.fname) + ' ' + report.lname AS repname
	, CAST(MAX(report.commrate) * 100 AS varchar) + ' %'  AS commrate
	, '$ ' + CONVERT(varchar, SUM(Sales.qty * Titles.slprice), 1)  AS total_sales
	, '$ ' + CONVERT(varchar, CONVERT(money, SUM(report.commrate * Sales.qty * Titles.slprice)), 1) AS commission 
	, MAX(DATEPART(YEAR, Sales.sldate)) AS Year
FROM Slspers as report
	INNER JOIN Sales ON report.repid = Sales.repid
	INNER JOIN Titles ON Sales.partnum = Titles.partnum 
WHERE DATEPART(YEAR, Sales.sldate) = 2017
GROUP BY report.repid
	, report.fname
	, report.lname
ORDER BY SUM(Sales.qty * Titles.slprice) desc, report.lname, report.fname
