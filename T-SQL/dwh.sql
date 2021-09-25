

SELECT amount, date FROM FactFinance f
INNER JOIN DimOrganization o ON f.OrganizationKey=o.OrganizationKey
INNER JOIN DimCurrency c ON c.CurrencyKey=o.CurrencyKey
INNER JOIN DimDate d on d.DateKey=f.DateKey
WHERE CurrencyAlternateKey='USD'
--AND d.CalendarYear=2010