# Comprehensive Banking Data Analysis for Strategic Decision-Making


### PROJECT OVERVIEW

The primary objective of this project is to analyze a banking database to extract actionable insights that support strategic decision-making for bank management. The analysis covers various aspects of the bank's operations, including customer accounts, transactions, loans, investments, and employee data. The goal is to provide a holistic view of the bank's performance, customer behavior, and operational efficiency to drive targeted marketing, risk management, and resource optimization.

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### Key Business Goals
1.  #### Customer Insights:
     -  Identify high-value customers and their account balances.
     -  Understand customer transaction behavior and investment preferences.
     -  Segment customers based on account activity, balances, and investment amounts.
2.  #### Operational Efficiency:
     -  Analyze transaction volumes and patterns to optimize resource allocation.
     -  Monitor loan repayment status and identify potential defaults.
     -  Assess branch-specific performance and staffing needs.
3.  #### Risk Management:
     -  Evaluate credit risk by analyzing outstanding loan amounts and repayment trends
     -  Identify dormant accounts and inactive customers for reactivation strategies.
4.  #### Product and Service Optimization:
     -  Understand the popularity of different account types, loan products, and investment options.
     -  Tailor financial products and services based on customer segments and preferences.
5.  #### Strategic Planning:
     -  Track Year-over-Year growth in investments and loans.
     -  Plan marketing campaigns and customer retention strategies based on transaction and investment trends.
  
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

### Scope of Analysis:

The analysis covers the following key areas of the banking database:
1.  #### Customer Accounts:
      -  Account balances, types, and activity.
      -  High-value customers and low-balance accounts.
2.  #### Transactions:
      -  Monthly transaction volumes and trends.
      -  Deposits, withdrawals, and credit card transactions.
3.  ####  Loans:
      -  Loan approvals, repayment status, and outstanding amounts.
      -  Interest rates and loan types.
4.  #### Investments:
      -  Customer investment profiles and trends.
      -  Popular investment types (e.g., stocks, mutual funds, bonds).
5.  #### Employees:
      - Branch-specific employee lists and roles.
      - Hiring trends and workforce composition.
6.  #### Credit Cards:
      -  Total credit cards issued and average credit limits.
      -  Expiring credit cards and customer notifications.
  
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#### Methodology:
The analysis is performed using SQL queries to extract, aggregate, and analyze data from the banking database. Key methodologies include:
-    **Data Aggregation**:Summarizing data (e.g., total deposits, average balances, transaction counts).
-    **Filtering and Segmentation**: Identifying specific customer segments (e.g., high-value customers, inactive accounts).
-    **Trend Analysis**: Tracking Year-over-Year growth in investments and loans.
-    **Conditional Logic**: Using CASE statements for customer segmentation and loan repayment status.
-    **Joins and Subqueries**: Combining data from multiple tables (e.g., customers, accounts, transactions).

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

### Data source:

The database, Table  are found here [FianceDB](https://github.com/Idris-lawal/ABC-Bank/blob/main/Finance%20and%20bank.sql). Containing the codes of creating the database, tables and inserting values into the tables.


![ERD](Capture.PNG)



------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

### Tools and Technologies:
- **Database**: Relational database ( Microsoft SQL Server)
- **SQL**: For querying and analyzing data.

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### EXPLORATORY DATA ANALYSIS

1. ### Business Scenario Q1
     **Customer Account Balances Overview**
  The bank management wants to have a comprehensive view of all customers along with their account details and current balances. This information is crucial for identifying high-value customers, understanding the distribution of account balances,and planning targeted marketing campaigns. 

```sql
          SELECT C.CustomerID,CONCAT(C.FirstName,' ',C.LastName) As Fullname,a.AccountType,Round(Sum(isnull(a.Balance,0)),2) as current_balance
          ,DATEDIFF(YY,A.OpenDate,GETDATE()) as Years_of_account
          FROM FB.Customers C
          JOIN FB.Accounts A ON A.CustomerID = C.CustomerID
          GROUP BY C.CustomerID,C.FirstName,C.LastName,a.AccountType,DATEDIFF(YY,A.OpenDate,GETDATE())
          ORDER BY Fullname

```
### Below is the output of the query
#### Customer Account Details

| CustomerID | Fullname      | AccountNumber | AccountType | Current Balance | Years of Account |
|------------|---------------|---------------|-------------|-----------------|------------------|
| C0056      | Alex Brown    | A0645         | Checking    | 7897.81         | 22               |
| C0058      | Alex Brown    | A0543         | Savings     | 8961.45         | 14               |
| C0058      | Alex Brown    | A0248         | Savings     | 8611.61         | 15               |
| C0058      | Alex Brown    | A0608         | Checking    | 6862.93         | 6                |
| C0061      | Alex Brown    | A0230         | Credit      | 7967.77         | 4                |
| C0061      | Alex Brown    | A0290         | Credit      | 1455.61         | 23               |
| C0227      | Alex Brown    | A0026         | Checking    | 3568.44         | 12               |
| C0299      | Alex Brown    | A0382         | Checking    | 6980.09         | 22               |
| C0326      | Alex Brown    | A0476         | Savings     | 2335.95         | 13               |
| C0326      | Alex Brown    | A0309         | Credit      | 9176.24         | 14               |
| C0399      | Alex Brown    | A0899         | Credit      | 640.57          | 17               |
| C0399      | Alex Brown    | A0390         | Checking    | 1813.41         | 15               |
| C0416      | Alex Brown    | A0435         | Checking    | 2445.44         | 10               |
| C0482      | Alex Brown    | A0208         | Credit      | 6257.7          | 11               |
| C0489      | Alex Brown    | A0542         | Credit      | 5766.21         | 23               |
| C0514      | Alex Brown    | A0461         | Credit      | 0               | 4                |
| C0493      | Alex Brown    | A1000         | Savings     | 3316.5          | 8                |
| C0653      | Alex Brown    | A0633         | Savings     | 8601.05         | 14               |
| C0653      | Alex Brown    | A0926         | Savings     | 5067.67         | 5                |
| C0778      | Alex Brown    | A0568         | Savings     | 2122.08         | 19               |
| C0779      | Alex Brown    | A0984         | Savings     | 7962.09         | 8                |
| C0865      | Alex Brown    | A0859         | Checking    | 1697.22         | 21               |
| C0867      | Alex Brown    | A0457         | Credit      | 5280.83         | 17               |
| C0875      | Alex Brown    | A0748         | Credit      | 7209.57         | 8                |
| C0875      | Alex Brown    | A0894         | Savings     | 7421.53         | 9                |
| C0890      | Alex Brown    | A0420         | Checking    | 8992.96         | 17               |
| C0973      | Alex Brown    | A0215         | Credit      | 0               | 14               |
| C0973      | Alex Brown    | A0381         | Savings     | 2813.72         | 14               |
| C0973      | Alex Brown    | A0374         | Savings     | 8569.21         | 24               |
| C0973      | Alex Brown    | A0854         | Savings     | 3608.57         | 3                |
| C0978      | Alex Davis    | A0821         | Credit      | 8497.97         | 23               |
| C0978      | Alex Davis    | A0164         | Savings     | 7932.66         | 16               |
| C0863      | Alex Davis    | A0082         | Savings     | 5616.07         | 5                |
| C0912      | Alex Davis    | A0163         | Savings     | 3645.78         | 6                |
| C0931      | Alex Davis    | A0443         | Savings     | 4318.73         | 7                |
| C0934      | Alex Davis    | A0524         | Checking    | 9137.8          | 13               |
| C0799      | Alex Davis    | A0781         | Savings     | 6536.3          | 16               |
| C0788      | Alex Davis    | A0232         | Savings     | 7163.46         | 5                |
| C0667      | Alex Davis    | A0031         | Credit      | 494.4           | 19               |
| C0667      | Alex Davis    | A0254         | Checking    | 6996.3          | 5                |
| C0667      | Alex Davis    | A0451         | Credit      | 1312.22         | 5                |
| C0637      | Alex Davis    | A0724         | Credit      | 1475.07         | 17               |
| C0637      | Alex Davis    | A0915         | Credit      | 6644.16         | 18               |
| C0637      | Alex Davis    | A0105         | Credit      | 4219.4          | 18               |
| C0681      | Alex Davis    | A0076         | Credit      | 7838.76         | 9                |
| C0681      | Alex Davis    | A0338         | Checking    | 8190.03         | 5                |
| C0488      | Alex Davis    | A0768         | Checking    | 1331.68         | 22               |
| C0554      | Alex Davis    | A0653         | Savings     | 6564.11         | 12               |
| C0618      | Alex Davis    | A0803         | Checking    | 6773.5          | 9                |
| C0632      | Alex Davis    | A0301         | Checking    | 0               | 8                |
| C0632      | Alex Davis    | A0008         | Savings     | 9679.44         | 19               |
| C0632      | Alex Davis    | A0715         | Checking    | 9477.21         | 15               |
| C0632      | Alex Davis    | A0827         | Credit      | 3952.23         | 24               |
| C0632      | Alex Davis    | A0957         | Credit      | 6655.87         | 18               |
| C0417      | Alex Davis    | A0389         | Credit      | 473.66          | 8                |
| C0470      | Alex Davis    | A0363         | Checking    | 5776.09         | 23               |
| C0470      | Alex Davis    | A0222         | Credit      | 3669.54         | 17               |
| C0389      | Alex Davis    | A0998         | Credit      | 3761.47         | 4                |
| C0391      | Alex Davis    | A0891         | Checking    | 5059.52         | 12               |
| C0307      | Alex Davis    | A0716         | Credit      | 2853.26         | 12               |
| C0252      | Alex Davis    | A0820         | Checking    | 6145.95         | 20               |
| C0228      | Alex Davis    | A0108         | Credit      | 8904.21         | 25               |
| C0228      | Alex Davis    | A0155         | Checking    | 4633.21         | 14               |
| C0228      | Alex Davis    | A0243         | Checking    | 1804.43         | 7                |
| C0228      | Alex Davis    | A0263         | Credit      | 1807.25         | 10               |
| C0032      | Alex Davis    | A0351         | Savings     | 2693.28         | 7                |
| C0011      | Alex Doe      | A0486         | Savings     | 5868.02         | 21               |
| C0082      | Alex Doe      | A0120         | Savings     | 4486.49         | 9                |
| C0082      | Alex Doe      | A0532         | Credit      | 3593.75         | 10               |
| C0082      | Alex Doe      | A0851         | Savings     | 4906.1          | 12               |
| C0106      | Alex Doe      | A0769         | Credit      | 4451.89         | 5                |
| C0106      | Alex Doe      | A0850         | Credit      | 0               | 9                |
| C0154      | Alex Doe      | A0357         | Credit      | 601.97          | 5                |
| C0154      | Alex Doe      | A0143         | Checking    | 241.72          | 7                |
| C0170      | Alex Doe      | A0638         | Savings     | 5029.28         | 15               |
| C0170      | Alex Doe      | A0399         | Credit      | 2014.85         | 5                |
| C0170      | Alex Doe      | A0283         | Credit      | 1592.37         | 6                |
| C0174      | Alex Doe      | A0799         | Checking    | 9629.15         | 13               |
| C0184      | Alex Doe      | A0523         | Credit      | 1818.23         | 8                |
| C0293      | Alex Doe      | A0593         | Credit      | 4600.82         | 21               |
| C0318      | Alex Doe      | A0332         | Credit      | 1079.47         | 6                |
| C0318      | Alex Doe      | A0152         | Credit      | 820.98          | 22               |
| C0335      | Alex Doe      | A0012         | Credit      | 2666.09         | 17               |
| C0335      | Alex Doe      | A0160         | Savings     | 4003.93         | 20               |
| C0335      | Alex Doe      | A0247         | Savings     | 8484.82         | 9                |
| C0335      | Alex Doe      | A0708         | Checking    | 5756.83         | 13               |
| C0335      | Alex Doe      | A0958         | Checking    | 1808.18         | 15               |
| C0341      | Alex Doe      | A0517         | Checking    | 9541.36         | 7                |
| C0345      | Alex Doe      | A0872         | Savings     | 660.1           | 13               |
| C0345      | Alex Doe      | A0994         | Checking    | 2973.82         | 19               |
| C0364      | Alex Doe      | A0118         | Credit      | 2072.6          | 9                |
| C0566      | Alex Doe      | A0245         | Savings     | 6831.89         | 22               |
| C0566      | Alex Doe      | A0836         | Checking    | 0               | 4                |
| C0672      | Alex Doe      | A0315         | Savings     | 8207.42         | 18               |
| C0672      | Alex Doe      | A0940         | Checking    | 2366.42         | 14               |
| C0661      | Alex Doe      | A0185         | Credit      | 4771.49         | 4                |
| C0713      | Alex Doe      | A0917         | Credit      | 7944.85         | 6                |
| C0809      | Alex Doe      | A0166         | Savings     | 5420.62         | 17               |
| C0972      | Alex Doe      | A0094         | Savings     | 455.7           | 7                |
| C0972      | Alex Doe      | A0167         | Savings     | 5765.72         | 18               |
| C0964      | Alex Doe      | A0564         | Credit      | 1182.8          | 16               |
| C0964      | Alex Doe      | A0784         | Savings     | 2708.56         | 20               |
| C0987      | Alex Smith    | A0657         | Checking    | 8567.2          | 7                |
| C0987      | Alex Smith    | A0369         | Credit      | 4598.34         | 25               |
| C0987      | Alex Smith    | A0471         | Savings     | 5249.67         | 4                |
| C0836      | Alex Smith    | A0291         | Checking    | 4494.53         | 4                |
| C0922      | Alex Smith    | A0749         | Credit      | 430.62          | 8                |
| C0721      | Alex Smith    | A0668         | Checking    | 1697.97         | 17               |
| C0769      | Alex Smith    | A0577         | Checking    | 6801.04         | 11               |
| C0622      | Alex Smith    | A0003         | Checking    | 1473.64         | 15               |
| C0535      | Alex Smith    | A0787         | Credit      | 8097.98         | 14               |
| C0510      | Alex Smith    | A0085         | Credit      | 4370.89         | 9                |
| C0510      | Alex Smith    | A0735         | Credit      | 541.97          | 11               |
| C0340      | Alex Smith    | A0651         | Checking    | 6516.68         | 20               |
| C0306      | Alex Smith    | A0782         | Checking    | 247.76          | 15               |
| C0298      | Alex Smith    | A0737         | Checking    | 9599.05         | 17               |
| C0295      | Alex Smith    | A0502         | Credit      | 341.46          | 7                |
| C0296      | Alex Smith    | A0397         | Checking    | 9050.94         | 19               |
| C0296      | Alex Smith    | A0919         | Savings     | 8140.29         | 8                |
| C0186      | Alex Smith    | A0395         | Credit      | 3191.99         | 3                |
| C0195      | Alex Smith    | A0042         | Savings     | 1291.44         | 22               |
| C0195      | Alex Smith    | A0767         | Credit      | 220.87          | 3                |
| C0237      | Alex Taylor   | A0882         | Checking    | 1426.58         | 8                |
| C0034      | Alex Taylor   | A0438         | Credit      | 6996.64         | 3                |
| C0034      | Alex Taylor   | A0180         | Savings     | 0               | 21               |
| C0062      | Alex Taylor   | A0434         | Savings     | 520.57          | 8                |
| C0495      | Alex Taylor   | A0681         | Savings     | 3510.18         | 6                |
| C0609      | Alex Taylor   | A0045         | Savings     | 3030.1          | 19               |
| C0585      | Alex Taylor   | A0534         | Credit      | 8086.35         | 23               |
| C0694      | Alex Taylor   | A0818         | Savings     | 6622.74         | 8                |
| C0735      | Alex Taylor   | A0779         | Savings     | 6171.65         | 20               |
| C0735      | Alex Taylor   | A0498         | Savings     | 7800.9          | 19               |
| C0662      | Alex Taylor   | A0691         | Savings     | 8163.13         | 11               |
| C0662      | Alex Taylor   | A0992         | Checking    | 1117.13         | 8                |
| C0631      | Alex Taylor   | A0387         | Checking    | 5149.77         | 6                |
| C0648      | Alex Taylor   | A0956         | Credit      | 1953.75         | 12               |
