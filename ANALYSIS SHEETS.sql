SELECT * FROM [FB].[Accounts]
SELECT * FROM [FB].[Branches]
SELECT * FROM [FB].[Credit_cards]
SELECT * FROM [FB].[Customers]
SELECT * FROM [FB].[Employees]
SELECT * FROM [FB].[Investments]
SELECT * FROM [FB].[Loans]
SELECT * FROM [FB].[Payments]
SELECT * FROM [FB].[Transactions]

/*
1. Business Scenario Q1
		Customer Account Balances Overview
		The bank management wants to have a comprehensive view of all customers along 
		with their account details and current balances. This information is crucial for 
		identifying high-value customers, understanding the distribution of account balances, 
		and planning targeted marketing campaigns.
*/

SELECT C.CustomerID,CONCAT(C.FirstName,' ',C.LastName) As Fullname,a.AccountType,Round(Sum(isnull(a.Balance,0)),2) as current_balance
,DATEDIFF(YY,A.OpenDate,GETDATE()) as Years_of_account
FROM FB.Customers C
JOIN FB.Accounts A ON A.CustomerID = C.CustomerID
GROUP BY C.CustomerID,C.FirstName,C.LastName,a.AccountType,DATEDIFF(YY,A.OpenDate,GETDATE())
ORDER BY Fullname

/*
2. Business Scenario Q2
		High-Value Customers Identification
		The bank management wants to identify all customers who have a balance greater 
		than $5,000 in their accounts. This information is critical for understanding the highvalue customer segment, 
		offering them tailored financial products, and providing them 
		with premium customer services.
*/

SELECT C.CustomerID,CONCAT(C.FirstName,' ',C.LastName) As Fullname,A.AccountID,a.AccountType,Round(Sum(isnull(a.Balance,0)),2) as current_balance
,DATEDIFF(YY,A.OpenDate,GETDATE()) as Years_of_account
FROM FB.Customers C
JOIN FB.Accounts A ON A.CustomerID = C.CustomerID
GROUP BY C.CustomerID,C.FirstName,C.LastName,A.AccountID,a.AccountType,DATEDIFF(YY,A.OpenDate,GETDATE())
HAVING Round(Sum(isnull(a.Balance,0)),2) > 5000
ORDER BY Fullname


/*
3. Business Scenario Q3
	Transactions in 2022
	The bank management wants to analyse all transactions made in the year 2022 to 
	understand customer behaviour, transaction volumes, and financial flows during that 
	period. This analysis will help in identifying trends, detecting anomalies, and planning 
	future strategies.
*/

SELECT TransactionID,a.AccountID,CONCAT(C.FirstName,' ',C.LastName) As Fullname, T.TransactionType, Round(isnull(T.Amount,0),2) As Transaction_Amount,
		TransactionDate
FROM [FB].[Transactions] T JOIN FB.Accounts A ON T.AccountID = A.AccountID
JOIN FB.Customers C on c.CustomerID = A.CustomerID
WHERE Year(TransactionDate) = '2022'
ORDER BY MONTH(TransactionDate) 


/*
4. Business Scenario Q4
		Monthly Deposit Summary
		The bank management wants to calculate the total amount deposited in all accounts 
		for the month of May 2022. This information is essential for monitoring cash inflows, 
		assessing the bank's liquidity position, and planning for future financial needs.
*/

SELECT Round(Sum(isnull(Amount,0)),2) As _total_deposit_may
FROM FB.Transactions 
WHERE Year(TransactionDate)= '2022' and Month(TransactionDate) = 5 and TransactionType = 'Deposit'



/*
5. Business Scenario Q5
		Customer Loan Details
		The bank management wants to retrieve the details of all loans taken by a customer
		with ID “C0768”. This information is crucial for understanding the customer's borrowing 
		behaviour, managing their credit risk, and providing them with tailored loan products.
*/

SELECT l.LoanID,L.CustomerID, CONCAT(C.FirstName,' ',C.LastName) As Fullname, L.LoanType,ROUND(LoanAmount,2) as loanAmount
		, Round(InterestRate,2) InterestRate, LoanDate
FROM [FB].[Loans] L JOIN FB.Customers C on L.CustomerID = c.CustomerID 
WHERE l.CustomerID = 'C0768'

/*
6. Business Scenario Q6
		Branch-Specific Employee List
		The bank management wants to retrieve a list of all employees working in a branch
		having an ID “B0851”. This information is useful for branch managers to understand 
		their team composition, manage human resources effectively, and plan for staffing 
		needs
*/

SELECT E.* FROM FB.Branches B JOIN [FB].[Employees] E on E.BranchID = b.BranchID
WHERE b.BranchID = 'B0851'

SELECT * FROM FB.Employees 
WHERE BranchID = 'B0851'

/*
7. Business Scenario Q7
	Total Credit Cards Issued
	The bank management wants to determine the total number of credit cards issued by 
	the bank. This information is important for understanding the bank's reach in the credit 
	card market, evaluating the success of their credit card products, and planning future 
	marketing campaigns.
*/

SELECT Count(*) as Total_Number_Of_card FROM [FB].[Credit_cards]

/*
8. Business Scenario Q8
		Average Interest Rate for Loans
		The bank management wants to calculate the average interest rate for all loans. This 
		information is essential for assessing the overall cost of borrowing for customers, 
		comparing it with industry benchmarks, and making decisions about future loan 
		product offerings and interest rate adjustments.
*/

SELECT Round(Avg(isnull(InterestRate,0)),2) As Avg_interest_rate FROM FB.Loans

/*
9. Business Scenario Q9
Active Customers in 2020
		The bank management wants to identify and retrieve the details of all customers who 
		have made at least one transaction in the year 2020. This information is valuable for 
		understanding customer activity, identifying engaged customers, and planning 
		targeted marketing and customer retention strategies.
*/

SELECT * FROM FB.Transactions
SELECT * FROM FB.Accounts
SELECT * FROM FB.Customers

SELECT CONCAT(c.FirstName,' ', C.LastName) aS FullName,A.AccountID, Count(t.TransactionID) as Transaction_CNT, TransactionType
,Round(SUM(isnull(t.Amount,0)),2) as Transaction_Amount
, TransactionDate
FROM FB.Transactions T JOIN FB.Accounts A on a.AccountID = T.AccountID
join fb.Customers c ON c.CustomerID = a.CustomerID
WHERE TransactionDate BETWEEN '2020-01-01' AND '2020-12-31'
GROUP BY CONCAT(c.FirstName,' ', C.LastName),A.AccountID, TransactionDate,TransactionType
HAVING Count(t.TransactionID) >= 0

/*
10.Business Scenario Q10
		Inactive Accounts Between 2019 and 2023
		The bank management wants to identify all accounts that have had no transactions 
		between the years 2019 and 2023. This information is important for understanding 
		long-term account inactivity, identifying dormant accounts, and planning strategies to 
		reactivate these accounts.
*/
SELECT * FROM FB.Accounts
SELECT * FROM FB.Transactions

SELECT * 
FROM FB.Transactions FBT JOIN FB.ACCOUNTS FBA on FBT.AccountID = FBA.AccountID
WHERE  FBT.TransactionDate BETWEEN '2019-01-01' AND '2023-12-31'


SELECT * FROM FB.Accounts
WHERE AccountID NOT IN 
(SELECT ACCOUNTID FROM FB.Transactions WHERE TransactionDate BETWEEN '2019-01-01' AND '2024-01-01')

/*
11. Business Scenario Q11
	Total Loan Payments in 2015
	The bank management wants to calculate the total amount of payments made towards 
	loans in the year 2015. This information is essential for understanding the cash flow 
	related to loan repayments, assessing the bank's financial performance for that year, 
	and making strategic decisions based on loan repayment trends.
*/

SELECT * FROM FB.Loans

SELECT PaymentMethod,Month(Paymentdate) as [month] , Round(sum(isnull(Amount,0)),2) as payment FROM FB.Payments
WHERE YEAR(Paymentdate) = '2015'
GROUP BY PaymentMethod,Month(Paymentdate)
ORDER BY [month]

/*
12. Business Scenario Q12
		Customer Investments in Mutual Funds
		The bank management wants to retrieve the details of all investments made by 
		customers in mutual funds. This information is valuable for understanding the 
		investment preferences of customers, assessing the performance of mutual fund 
		products, and planning targeted investment offerings.
*/

SELECT * FROM FB.Customers
SELECT * FROM FB.Accounts
SELECT * FROM FB.Investments

SELECT C.CustomerID, CONCAT(C.FirstName,' ', C.LastName) As FULLNAME, Email
FROM FB.Investments I JOIN FB.Customers C on I.CustomerID = C.CustomerID
WHERE InvestmentType = 'Mutual Funds'


/*
13. Business Scenario Q13
		Transaction Count by Account Type
		The bank management wants to find the total number of transactions for each account 
		type (Checking, Savings, Credit). This information is important for understanding the 
		transaction activity across different types of accounts, identifying popular account 
		types, and making strategic decisions related to product offerings and customer 
		engagement
*/

SELECT * FROM FB.Accounts
SELECT * FROM FB.Transactions

SELECT A.AccountType , Count(T.TransactionID) As Trasaction_number
FROM FB.Accounts A  JOIN FB.Transactions T on A.AccountID = T.AccountID
Group by A.AccountType

/*
14.Business Scenario Q14
		Employee Count by Branch
		The bank management wants to list all branches along with the number of employees 
		working in each branch. This information is essential for understanding branch staffing 
		levels, identifying branches that may need additional staffing, and optimising human 
		resource allocation.
*/

SELECT * FROM FB.Employees
SELECT * FROM FB.Branches


SELECT B.BranchID,b.BranchName,Count(E.EmployeeID) as Employee_cnt
FROM FB.Branches B JOIN FB.Employees E on B.BranchID = E.BranchID
GROUP BY B.BranchID,b.BranchName

/*
15. Business Scenario Q15
	Total Outstanding Loan Amount by Customer
	The bank management wants to calculate the total outstanding loan amount for each 
	customer. This information is crucial for assessing individual customer debt levels, 
	managing credit risk, and making informed decisions about loan approvals and 
	customer credit limits.
*/

SELECT c.CustomerID, CONCAT(c.FirstName,' ',c.LastName) As FullName, C.Email, Round(SUM(isnull(l.LoanAmount,0)),2) As Loan_amount
FROM FB.Loans L JOIN FB.Customers C on l.CustomerID = c.CustomerID 
GROUP BY c.CustomerID, c.FirstName,c.LastName, C.Email


/*
16.Business Scenario Q16
		Customers with Multiple Account Types
		The bank management wants to retrieve the details of all customers who have more 
		than one type of account. This information is important for understanding customer 
		engagement, identifying cross-selling opportunities, and analysing the diversity of 
		customer portfolios.
*/

SELECT * FROM FB.Customers
SELECT * FROM FB.Accounts

SELECT * FROM Fb.Customers
WHERE CustomerID IN
			(SELECT CustomerID FROM FB.Accounts
			 GROUP BY CustomerID
			 Having Count(Distinct AccountType) >1
			 )


/*
17. Business Scenario Q17
			Total Number of Loans Approved in 2017
			The bank management wants to find the total number of loans approved in the year 
			2017. This information is essential for assessing the bank's lending activity for that 
			year, understanding market demand, and planning future loan offerings and strategies		
*/

SELECT Count(loanID) As total_Loan_approve_2017 
FROM FB.Loans 
WHERE YEAR(LoanDate) = '2017'

/*
18. Business Scenario Q18
		Average Balance of Savings Accounts
		The bank management wants to calculate the average balance of all savings accounts. 
		This information is important for understanding the typical balance held by customers 
		in savings accounts, assessing the bank's liquidity, and making informed decisions 
		about interest rates and savings account products.
*/

SELECT Round(AVG(isnull(Balance,0)),2) As Avg_saving_bal
FROM FB.Accounts
WHERE AccountType = 'Savings'

/*
19.Business Scenario Q19
		Customers with Stock Investments
		The bank management wants to retrieve the details of all customers who have 
		investments in stocks. This information is valuable for understanding customer 
		investment behaviour, identifying customers interested in equity markets, and planning 
		targeted marketing campaigns for stock-related financial products.
*/

SELECT C.CustomerID, CONCAT(c.FirstName,' ',c.LastName) as Fullname, c.Email
FROM FB.Investments I JOIN FB.Customers C on I.CustomerID = c.CustomerID
WHERE InvestmentType = 'Stocks'

/*
20. Business Scenario Q20
		Total Interest Earned on Loans in 2012
		The bank management wants to calculate the total interest earned on all loans in the 
		year 2012. This information is crucial for understanding the revenue generated from
		loan interest during that period, evaluating the profitability of the bank's lending 
		activities, and making informed financial planning and strategic decisions.
*/
SELECT ROUND(SUM(ISNULL(InterestRate,0)),2) As Total_interest_2012
FROM FB.Loans
Where LoanDate BETWEEN '2012-01-01' AND '2012-12-31'


SELECT ROUND(SUM(ISNULL(InterestRate,0)),2) As Total_interest_2012
FROM FB.Loans
Where YEAR(LoanDate) = '2012' 


/*
21. Business Scenario Q21
		Total Number of Deposits in a Specific Branch
		The bank management wants to calculate the total number of deposit transactions 
		made in a branch with ID “B0036”. This information is essential for understanding the 
		deposit activity within a branch, assessing branch performance, and planning resource 
		allocation.
*/

SELECT * FROM FB.Branches
SELECT * FROM FB.Accounts
SELECT * FROM FB.Transactions
SELECT * FROM FB.Employees
SELECT * FROM FB.Customers
SELECT * FROM FB.Loans
SELECT * FROM FB.Payments
SELECT * FROM FB.Credit_cards


/*
22. Business Scenario Q22
		Employees Hired in 2018
		The bank management wants to retrieve the details of all employees who were hired 
		in the year 2018. This information is important for understanding hiring trends, 
		analysing employee retention, and planning future hiring strategies.
*/
SELECT * FROM FB.Employees
WHERE YEAR(HireDate) = '2018'
Order by HireDate


/*
23.Business Scenario Q23
		Total Amount of Investments Made by All Customers
		The bank management wants to calculate the total amount of investments made by all 
		customers. This information is crucial for understanding the overall investment activity, 
		evaluating the bank's investment product performance, and making strategic decisions 
		regarding investment offerings.
*/

SELECT Round(Sum(Isnull(Amount,0)),2) Total_Amount_Investment FROM FB.Investments


/*
24. Business Scenario Q24
		Customers with Multiple Loans
		The bank management wants to retrieve the details of all customers who have more 
		than one loan. This information is important for understanding customer borrowing 
		behaviour, identifying high-risk customers, and providing targeted financial services.
*/

SELECT * FROM FB.Customers
WHERE CustomerID in 
		(SELECT CustomerID FROM FB.Loans
		GROUP BY CustomerID
		HAVING Count(distinct(LoanType))>1
		)

/*
25. Business Scenario Q25
		Accounts with Low Balances
		The bank management wants to list all accounts that have a balance less than $500. 
		This information is important for identifying accounts that may require attention, such 
		as those at risk of becoming inactive or needing additional financial products and 
		services to encourage higher balances.
*/

SELECT * FROM FB.Customers
WHERE CustomerID IN
		(SELECT distinct CustomerID FROM FB.Accounts
		Where Balance < 500
		)

/*
26. Business Scenario Q26
		Total Amount of Withdrawals in January 2013
		The bank management wants to calculate the total amount of withdrawals made in 
		January 2013. This information is essential for understanding cash outflows, assessing 
		liquidity needs, and planning for financial management and customer service 
		strategies.
*/

SELECT Round(Sum(isnull(Amount,0)),2) As Total_withdrawal_Transact FROM FB.Transactions
WHERE TransactionType = 'Withdrawal' and TransactionDate BETWEEN '2013-01-01' AND '2013-01-31'


/*
27.Business Scenario Q27
		Customers Making Payments Using Bank Transfers
		The bank management wants to retrieve the details of all customers who have made 
		payments using bank transfers. This information is important for understanding
		customer payment preferences, identifying trends in payment methods, and planning 
		targeted services and promotions for bank transfer users.
*/

SELECT * FROM FB.Customers 
WHERE CustomerID IN
		(SELECT Distinct CustomerID FROM FB.Payments P JOIN FB.Loans L  ON L.LoanID = P.LoanID
		WHERE PaymentMethod = 'Bank Transfer'
		)


/*
28. Business Scenario Q28
		Total Number of Credit Card Transactions in 2022
		The bank management wants to find the total number of credit card transactions made 
		in the year 2022. This information is important for understanding the usage and 
		popularity of credit cards among customers, assessing transaction volumes, and 
		planning marketing strategies for credit card products.
*/

SELECT Count(PaymentID) As Credit_Card_transact_2022 FROM FB.Payments
WHERE PaymentMethod = 'Credit Card' AND YEAR(PaymentDate) = '2022'


/*
29. Business Scenario Q29
		Average Credit Limit of Credit Cards
		The bank management wants to calculate the average credit limit of all credit cards. 
		This information is essential for understanding the distribution of credit limits among 
		customers, assessing the bank's credit exposure, and making informed decisions 
		about credit card policies and offerings.
*/

SELECT Round(Avg(ISnull(amount,0)),2) as Avg_CreditLimit FROM FB.Payments
WHERE PaymentMethod = 'Credit Card'

/*
30. Business Scenario Q30
		Customers with Bond Investments
		The bank management wants to retrieve the details of all customers who have 
		investments in bonds. This information is valuable for understanding customer 
		investment preferences, identifying potential opportunities for targeted marketing of 
		bond-related financial products, and analysing the popularity of bonds among 
		customers.
*/

SELECT * FROM FB.Customers 
WHERE CustomerID IN
		(SELECT Distinct CustomerID FROM FB.Investments
		WHERE InvestmentType = 'Bonds')

/*
31. Business Scenario Q31
		Total Number of Loans Approved by Loan Type
		The bank management wants to calculate the total number of loans approved for each 
		loan type (Personal, Mortgage, Auto, Student). This information is crucial for 
		understanding the distribution of loan approvals across different types, evaluating the 
		demand for various loan products, and making informed decisions about future loan 
		offerings.
*/

SELECT LoanType,Count(loanID) As Total_Number_ofLoan FROM FB.Loans
Group by LoanType

/*
32.Business Scenario Q32
		List of Employees Working as Loan Officers
		The bank management wants to list all employees who work as loan officers. This 
		information is essential for understanding the workforce composition, managing 
		human resources, and planning targeted training and development programs for loan 
		officers.
*/

SELECT E.EmployeeID, CONCAT(FirstName, ' ', LastName) as fullname, BranchName, HireDate FROM FB.Employees E, FB.Branches B
WHERE Position = 'Teller' and E.BranchID = b.BranchID

/*
33.Business Scenario Q33
		Total Number of Accounts Opened in 2014
		The bank management wants to find the total number of accounts that were opened 
		in the year 2014. This information is important for understanding the growth in the 
		customer base during that year, evaluating the success of marketing campaigns, and 
		making informed decisions about future strategies to attract new customers.
*/
SELECT Count(*) As CNT_Account_opened_2014 FROM FB.Accounts
WHERE YEAR(openDate) = '2014'

/*
34. Business Scenario Q34
		Average Transaction Amount by Transaction Type
		The bank management wants to calculate the average transaction amount for each 
		transaction type. This information is essential for understanding customer behaviour, 
		identifying transaction trends, and making informed decisions about fee structures and 
		service offerings.
*/

SELECT TransactionType, Round(AVG(Isnull(Amount,0)),2) AVg_transaction_amount FROM FB.Transactions
GROUP BY TransactionType;

/*
35.Business Scenario Q35
		Identify High-Value Customers
		The bank management wants to identify high-value customers, defined as the top 10% 
		of customers based on their total account balances and investments. This information 
		is crucial for targeted marketing, offering premium services, and personalised financial 
		products to these valuable customers.
*/


WITH CustomerACCBAL_Investment
AS 
	(
		SELECT TOP 10 A.CustomerID, Round(Sum(isnull(A.Balance,0)),2) AccBal, Round(Sum(isnull(I.Amount,0)),2) Investment,
		Round(Sum((isnull(A.Balance,0) + isnull(I.Amount,0))),2) TotalAmount
		FROM FB.Accounts A JOIN FB.Investments I ON I.CustomerID = A.CustomerID
		GROUP BY A.CustomerID
		
	)
	SELECT CAL.customerID, Concat(C.firstname, ' ', C.lastname) As Fullname, AccBal, Investment, TotalAmount 
	FROM CustomerACCBAL_Investment CAL JOIN FB.Customers C ON C.CustomerID= CAL.customerID
	Order By TotalAmount DESC

/*
36. Business Scenario Q36
		Customer Segmentation
		The bank management wants to categorise customers into segments (e.g., low, 
		medium, high value) based on their account balances, transaction frequency, and 
		investment amounts. This information is crucial for targeted marketing, personalised 
		service offerings, and enhancing customer satisfaction.
*/

--SELECT * FROM FB.Accounts
--SELECT * FROM FB.Transactions
--SELECT * FROM FB.Investments

WITH CustomerSegment 
AS (
		SELECT  A.CustomerID,Round(Sum(isnull(A.Balance,0)),2) AccBal, Round(Sum(isnull(I.Amount,0)),2) Investment, Count(TransactionID) As Transaction_frequency
		FROM FB.Accounts A JOIN FB.Investments I ON I.CustomerID = A.CustomerID JOIN FB.Transactions T ON t.AccountID = A.AccountID
		GROUP BY A.CustomerID
	)
	SELECT CS.customerID,Concat(C.firstname, ' ', C.lastname) As Fullname,CS.Accbal, Cs.Investment, CS.Transaction_Frequency,
	CASE
			WHEN CS.Accbal >= 100000 OR Cs.Investment >= 50000 THEN
			'High Value'
			WHEN CS.Accbal >= 50000 OR Cs.Investment>= 25000 THEN
			'Medium Value'
			ELSE 'Low Value' 
			END AS CustomerSegment

	FROM CustomerSegment CS JOIN FB.Customers C ON C.CustomerID = CS.customerID


/*
37.Business Scenario Q37
		Account Activity Summary
		The bank management wants to retrieve a summary of account activity for each 
		customer. This summary should include the total deposits, total withdrawals, and the 
		current balance for each customer's accounts. This information is crucial for 
		understanding customer behaviour, monitoring account health, and providing 
		personalised financial advice.
*/

WITH TOTAL_DEPOSITCTE 
AS 
	(
		SELECT * FROM FB.Transactions
		WHERE TransactionType = 'Deposit'
	),
	TOTAL_WITHDRAWALCTE AS
	(
		SELECT * FROM FB.Transactions
		WHERE TransactionType = 'Withdrawal'	
	)
	SELECT A.AccountID, a.CustomerID, CONCAT(c.FirstName, ' ',c.LastName) As FullName,Round(Sum(Isnull(A.Balance,0)),2) Opening_Balance, Round(Sum(isnull(D.Amount,0)),2) AS Total_Deposit,
	Round(Sum(Isnull(W.Amount,0)),2) AS Total_withdrawal,		(Round(Sum(Isnull(A.Balance,0)),2) - Round(Sum(Isnull(W.Amount,0)),2) + Round(Sum(isnull(D.Amount,0)),2)) As Current_balance
	FROM TOTAL_DEPOSITCTE D JOIN TOTAL_WITHDRAWALCTE W ON W.AccountID = D.AccountID
	JOIN FB.Accounts A ON D.AccountID = A.AccountID and W.AccountID = A.AccountID
	JOIN FB.Customers C on A.CustomerID = C.CustomerID
	GROUP BY A.AccountID, a.CustomerID,c.FirstName, c.LastName

/*
38.Business Scenario Q38
		Customer Investment Profile
		The bank management wants to list customers along with their total investment 
		amounts and the types of investments they hold. This information is crucial for 
		understanding customer investment behaviour, identifying potential high-value clients, 
		and tailoring investment products to meet customer needs.
*/

SELECT distinct InvestmentType FROM FB.Investments;

WITH ETFsCTE 
As	
	(
		SELECT CustomerID,Count(InvestmentID) As Investment_CNT,Sum(ISnull(Amount,0)) As total_investment
		FROM FB.Investments 
		WHERE InvestmentType = 'ETFs'
		GROUP BY CustomerID
	), STOCKSCTE AS
	(
		SELECT CustomerID,Count(InvestmentID) As Investment_CNT,Sum(ISnull(Amount,0)) As total_investment
		FROM FB.Investments 
		WHERE InvestmentType = 'Stocks'
		GROUP BY CustomerID
	), Mutual_FundsCTE AS
	(
		SELECT CustomerID,Count(InvestmentID) As Investment_CNT,Sum(ISnull(Amount,0)) As total_investment
		FROM FB.Investments 
		WHERE InvestmentType = 'Mutual Funds'
		GROUP BY CustomerID
	), BondsCTE AS
	(
		SELECT CustomerID,Count(InvestmentID) As Investment_CNT,Sum(ISnull(Amount,0)) As total_investment
		FROM FB.Investments 
		WHERE InvestmentType = 'Bonds'
		GROUP BY CustomerID
	)
	SELECT C.CustomerID, CONCAT(c.FirstName, ' ',c.LastName) As FullName, Isnull(e.Investment_CNT,0) As EFTs_investment_CNT, Round(isnull(E.total_investment,0),2) As TotalEFTs_investment,
	ISnull(S.Investment_CNT,0) As Stocks_investment_CNT, Round(Isnull(S.total_investment,0),2) As TotalStocks_investment, Isnull(M.Investment_CNT,0) As Mutual_fund_Investment_CNT
	, Round(Isnull(M.total_investment,0),2) As Total_Mutual_fund_Investment,	ISNULL(B.Investment_CNT,0) As Bond_investment_CNT,Round(isnull( B.total_investment,0),2) As TotalBonds_Investment
	,(IsNULL(e.Investment_CNT,0)+ISNULL(M.Investment_CNT,0)+ISnull(S.Investment_CNT,0)+isnull(B.Investment_CNT,0)) As Investment_Count,
	(Isnull(E.total_investment,0)+isnull(M.total_investment,0)+isnull(B.total_investment,0)+isnull(S.total_investment,0)) As Total_Investment_Amount
	FROM FB.Customers C LEFT JOIN ETFsCTE E ON C.CustomerID = E.CustomerID
	LEFT JOIN Mutual_FundsCTE M ON C.CustomerID = M.CustomerID LEFT JOIN STOCKSCTE S ON C.CustomerID = S.CustomerID
	JOIN BondsCTE B ON B.CustomerID = C.CustomerID


/*
39. Business Scenario Q39
			Monthly Transaction Volume
			The bank management wants to calculate the total transaction volume for each month 
			from 2011 to 2023, broken down by transaction type. This information is essential for 
			understanding transaction patterns, planning for resource allocation, and identifying 
			peak transaction periods.
*/

SELECT Year(TransactionDate) As Transaction_Year, MONTH(TransactionDate) AS Transaction_Month, TransactionType, Count(TransactionID) as CNT_Transaction
, Round(Sum(isnull(Amount,0)),2) As Transactuon_Amount
FROM FB.Transactions
WHERE TransactionDate BETWEEN '2011-01-01' AND '2023-12-31'
GROUP BY Year(TransactionDate) ,  MONTH(TransactionDate), TransactionType
ORDER BY  Year(TransactionDate) , MONTH(TransactionDate);


/*
40. Business Scenario Q40
		Loan Repayment Status
		The bank management wants to list all loans along with their repayment status. This 
		should include the total amount repaid and the outstanding balance for each loan. This 
		information is crucial for monitoring loan performance, identifying potential defaults, 
		and managing credit risk.
*/

WITH LOANCTE 
AS
	(
		SELECT LoanID,LoanAmount= Round(Sum(isnull(LoanAmount,0)),2),InterestRate = Round(Sum(isnull(InterestRate,0)),2),
		Total_Expected_Loan_Payment = Round(Sum(isnull(LoanAmount,0)* (1 + (isnull(InterestRate,0)/100))),2), LoanDate
		FROM FB.Loans
		GROUP BY LoanID,LoanDate
	)
		SELECT LC.LoanID,LoanAmount = sum(LoanAmount),InterestRate = sum(InterestRate),Total_Expected_Loan_Payment=Sum(Total_Expected_Loan_Payment), Loan_Payment = Round(Sum(isnull(P.Amount,0)),2)
		,Outstanding_payment = Sum(Total_Expected_Loan_Payment) -Round(Sum(isnull(P.Amount,0)),2), Payment_Indicator = CASE WHEN Round(Sum(isnull(P.Amount,0)),2) = 0 THEN 'Fully paid' 
		ELSE 'Partly paid' end
		, LoanDate = CAST(LoanDate AS DATE)
		FROM LOANCTE LC LEFT JOIN FB.Payments P ON LC.LoanID = p.LoanID
		GROUP BY LC.LoanID,LoanDate;



/*
41.Business Scenario Q41
			Analyse Customer Investment Trends
			The bank management wants to analyse customer investment trends, Year-over-Year 
			Growth in Investments: This includes understanding how customers are investing over 
			time, identifying popular investment types, and tracking the total investment amounts. 
			This information is crucial for developing investment products, marketing strategies, 
			and providing personalised investment advice.
*/


WITH YOYTREND 
AS 
	(
		SELECT CustomerID, YEar(InvestmentDate) As [Year], Investment = (Amount) FROM FB.Investments
	)
	SELECT Y1.CustomerID,Y1.Year, Round(Sum(Isnull(Y1.Investment,0)),2) As currentYear_Investment,Round(Sum(Isnull(Y2.Investment,0)),2) As previousYear_Investment,
	Round((Round(Sum(Isnull(Y1.Investment,0)),2) - Round(Sum(Isnull(Y2.Investment,0)),2)),2) As Diff_Investment,
	Round(((Round(Sum(Isnull(Y1.Investment,0)),2) - Round(Sum(Isnull(Y2.Investment,0)),2))/ Round(Sum(NULLIF(Y2.Investment,0)),2)*100),2) as Growth
	FROM YOYTREND Y1, YOYTREND Y2
	WHERE Y1.Year = Y2.Year + 1
	GROUP BY Y1.CustomerID,Y1.Year

/*
42. Business Scenario Q42
		Credit Card Expiry Notification
		The bank management wants to identify credit cards that are set to expire in the next 
		three months (from January 2022) and list their holders. This information is crucial for 
		customer service, allowing the bank to notify customers about the impending expiration 
		of their credit cards and facilitate timely renewals or replacements.
*/

SELECT C.CustomerID, CONCAT(c.FirstName, ' ', c.LastName) As FullName, C.Email,CC.ExpirationDate 
FROM FB.Credit_cards CC JOIN FB.Customers C On CC.CustomerID = C.CustomerID
WHERE ExpirationDate BETWEEN '2022-01-01' AND DATEADD(MONTH,3,'2022-01-01')
Order By CC.ExpirationDate 


