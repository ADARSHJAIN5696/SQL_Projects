 USE financial_db;
 -- A. BANK LOAN REPORT | SUMMARY
 
 -- 1. KPI’s:
 SELECT * FROM financial_loan;
/*
1) Number of Applications
a) Total Loan Applications
b) MTD Loan Applications(Month-To-Date i.e. Current Month)
c) PMTD Loan Applications(Previous Month)  */
 -- A) Total Loan Applications
 SELECT COUNT(*) as 'total_loan_application' FROM financial_loan;
 
-- B) MTD Loan Applications(Month-To-Date i.e. Current Month) 

 SELECT  COUNT(*) AS 'total_application' FROM financial_loan
 WHERE MONTH(issue_date) = MONTH(CURRENT_DATE());
 
-- C) PMTD Loan Applications(Previous Month)

SELECT COUNT(*) AS 'Pmtd' FROM financial_loan
WHERE MONTH(issue_date) = MONTH(CURRENT_DATE())-1;


/* 2.) Funded Amount (Total Loan Amount approved)
a) Total Funded Amount
b) MTD Total Funded Amount
c) PMTD Total Funded Amount
*/

-- a) Total Funded Amount
SELECT * FROM financial_loan;
SELECT SUM(loan_amount) FROM financial_loan;

-- B) MTD Total Funded Amount
SELECT SUM(loan_amount) AS 'MTD_TOTAL_FUNDED_AMOUNT' FROM financial_loan
WHERE MONTH(issue_date) = MONTH(CURRENT_DATE()); 

-- C) PMTD Total Funded Amount
 SELECT SUM(loan_amount) AS 'total_funded_amt' 
 FROM financial_loan WHERE MONTH(issue_date) = MONTH(CURRENT_DATE())-1;
 
 /* 3) Amount Received(Loan Amount paid)
a) Total Amount Received
b) MTD Total Amount Received
c) PMTD Total Amount Received */
SELECT * FROM financial_loan; 

-- A) Total Amount Received

SELECT SUM(loan_amount) AS 'loan_amount_paid'
FROM financial_loan;

-- B)  MTD Total Amount Received
SELECT SUM(loan_amount) AS 'MTD total_amount_received' 
FROM financial_loan
WHERE MONTH(issue_date) = MONTH(CURRENT_DATE());

-- C)  PMTD Total Amount Received 
 SELECT SUM(loan_amount) AS 'PMTD total_amount_received' 
FROM financial_loan
WHERE MONTH(issue_date) = MONTH(CURRENT_DATE())-1;

 /* 4) Interest Rate
a) Average Interest Rate
b) MTD Average Interest
c) PMTD Average Interest */

SELECT * FROM financial_loan;
-- A)  Average Interest Rate
SELECT AVG(int_rate) AS 'AVERAGE INTEREST RATE' FROM financial_loan;

-- B) MTD Average Interest
SELECT AVG(int_rate) AS 'MTD_average_Rate' FROM financial_loan
WHERE MONTH(issue_date) = MONTH(CURRENT_DATE());

-- C)  PMTD Average Interest
SELECT AVG(int_Rate) AS 'PMTD_average_Rate' FROM financial_loan
WHERE MONTH(issue_date) = MONTH(CURRENT_DATE())-1;

/* 5) DTI (Debt to Income ratio)
a) Avg DTI
b) MTD Avg DTI
c) PMTD Avg DTI  */

-- a) Avg DTI
SELECT ROUND(AVG(dti),2) AS 'AVERAGE DTI' FROM financial_loan 
WHERE MONTH(issue_date) = MONTH(CURRENT_DATE());


-- b) MTD Avg DTI
SELECT ROUND(AVG(dti),2) AS 'MTD_AVG_DTI' FROM financial_loan 
WHERE MONTH(issue_date) = MONTH(CURRENT_DATE())-1;

-- c) PMTD Avg DTI
SELECT ROUND(AVG(dti),2) AS 'PMTD_AVG_DTI' FROM financial_loan
WHERE MONTH(issue_date) = MONTH(CURRENT_DATE())-1;

/* 2. GOOD LOAN ISSUED
1. Good Loan Percentage
2. Good Loan Applications
3. Good Loan Funded Amount
4. Good Loan Amount Received  */ 

# 2. GOOD LOAN ISSUED

 -- 1.Good Loan Percentage
  SELECT (SELECT COUNT(id) AS `good loan`
 FROM financial_loan WHERE loan_status = "Fully paid" OR loan_status = "current") /
 (SELECT COUNT(id) FROM financial_loan )* 100 AS percentage; 
 
 
 SELECT (SELECT COUNT(id) AS `GOOD LOAN`
  FROM financial_loan 
  WHERE loan_status = "Fully paid" OR loan_status = "current") / 
(SELECT COUNT(id) FROM financial_loan ) * 100 AS percentage;
  
 SELECT * FROM financial_loan;
 
 -- 2) Good Loan Applications
 
SELECT COUNT(id)  FROM financial_loan
 WHERE loan_status = "Fully paid"  OR loan_status = "current";

-- 3) good Loan Funded Amount
SELECT SUM(loan_amount)  AS `funded amount` FROM financial_loan 
WHERE loan_status = "Fully paid" OR loan_status = "current";
 
-- 4) Good Loan Amount Received
SELECT SUM(total_payment) AS `AMOUNT RECEIVED` FROM financial_loan
WHERE loan_status = "Fully paid"  OR loan_status = "current";

#3. BAD LOAN ISSUED

 /* 3. BAD LOAN ISSUED
1. Bad Loan Percentage
2. Bad Loan Applications
3. Bad Loan Funded Amount
4. Bad Loan Amount Received */

-- 1) Bad Loan Percentage
SELECT * FROM financial_loan;

 SELECT (SELECT COUNT(id) AS `bad loan percentage` FROM financial_loan WHERE loan_status = "Charged Off") /
 (SELECT COUNT(id) FROM financial_loan ) * 100 AS `PERCETAGE`;
 
 SELECT (SELECT COUNT(id) AS `bad loan percentage` FROM f l WHERE loan_status = "charged off") / ( SELECT COUNT(id) f_l ) * 100 AS `bad loan %` ; 

-- 2) 2. Bad Loan Applications
SELECT COUNT(id) FROM financial_loan WHERE loan_status = "Charged Off";

-- 3)  Bad Loan Funded Amount
SELECT SUM(loan_amount) AS `FUNDED AMOUNT` FROM financial_loan 
WHERE loan_status = "Charged Off";

-- 4) Bad Loan Amount Received
SELECT SUM(total_payment)  AS `AMOUNT RECEIVED` FROM financial_loan 
WHERE loan_status = "Charged Off"; 

 # 4. LOAN STATUS
 /* 1. Complete Loan Status Summary
2. MTD Loan Status Summary  */

-- 1) Complete Loan Status Summary

SELECT loan_status,
COUNT(id) AS `TOTAL_LOANS`,
SUM(loan_amount) AS `FUNDED AMOUNT`,
SUM(total_payment) AS `AMOUNT RECEIVED`,
 ROUND(AVG(dti),2) AS `AVERAGE DTI`,
ROUND(AVG(int_Rate),2) AS `AVERAGE INTEREST RATE` FROM financial_loan 
GROUP BY loan_status;

-- 2.)  MTD Loan Status Summary
SELECT COUNT(id) AS `TOTAL_LOANS`,
SUM(loan_amount) AS `FUNDED AMOUNT`,
SUM(total_payment) AS `AMOUNT RECEIVED`,
ROUND(AVG(dti),2) AS `AVERAGE DTI`,
ROUND(AVG(int_Rate),2) AS `AVERAGE INTEREST RATE`
FROM financial_loan 
WHERE MONTH(issue_date) = MONTH(CURRENT_DATE());
  
SELECT * FROM financial_loan;

/* B. BANK LOAN REPORT | OVERVIEW
Showcase total number of applications, total loan amount and total amount received for the
following parameters. 
a. MONTH
b. STATE
c. TERM
d. EMPLOYEE LENGTH
e. PURPOSE
f. HOME OWNERSHIP */

-- A) MONTH
SELECT  
MONTH(issue_date) AS `month number`,
MONTHNAME(issue_date) AS `MONTH` ,
COUNT(id) AS ` MONTH WISE TOTAL_LOANS`,
SUM(loan_amount) AS `MONTH WISE FUNDED AMOUNT`,
SUM(total_payment) AS `MONTH WISE AMOUNT RECEIVED` FROM financial_loan
GROUP BY `MONTH`,`month number`
ORDER BY `month number`;

SELECT * FROM financial_loan;

-- B) STATE
SELECT address_state, 
COUNT(id) AS ` STATE WISE TOTAL NO LOANS APPLICATION `,
SUM(loan_amount) AS `STATE WISE  TOTAL FUNDED AMOUNT`,
SUM(total_payment) AS `STATE WISE TOTAL AMOUNT RECEIVED` FROM financial_loan
GROUP BY address_state;

SELECT * FROM financial_loan;

-- C. TERM
SELECT term, 
COUNT(id) AS `TERM WISE TOTAL NO LOANS APPLICATION `,
SUM(loan_amount) AS `TERM WISE  TOTAL FUNDED AMOUNT`,
SUM(total_payment) AS `TERM WISE TOTAL AMOUNT RECEIVED` FROM financial_loan
GROUP BY term;

SELECT * FROM financial_loan;

-- D. EMPLOYEE LENGTH
SELECT emp_length, 
COUNT(id) AS `EMP LENGTH WISE TOTAL NO LOANS APPLICATION `,
SUM(loan_amount) AS `EMP LENGTH WISE TOTAL FUNDED AMOUNT`,
SUM(total_payment) AS `EMP LENGTH WISE TOTAL AMOUNT RECEIVED` FROM financial_loan
GROUP BY emp_length;

SELECT * FROM financial_loan;
-- E)  PURPOSE
SELECT purpose, 
COUNT(id) AS `PURPOSE WISE TOTAL NO LOANS APPLICATION `,
SUM(loan_amount) AS `PURPOSE WISE TOTAL FUNDED AMOUNT`,
SUM(total_payment) AS `PURPOSE WISE TOTAL AMOUNT RECEIVED` FROM financial_loan
GROUP BY purpose;

SELECT * FROM financial_loan;
-- F) HOME OWNERSHIP
SELECT home_ownership, 
COUNT(id) AS `HOME OWNERSHIP WISE TOTAL NO LOANS APPLICATION `,
SUM(loan_amount) AS `HOME OWNERSHIP WISE TOTAL FUNDED AMOUNT`,
SUM(total_payment) AS `HOME OWNERSHIP TOTAL AMOUNT RECEIVED` FROM financial_loan
GROUP BY home_ownership;

SELECT * FROM financial_loan; 

/* C. Miscellaneous | OVERVIEW
1. MoM Loan Application growth rate
2. Mom Loan Amount Disbursed growth rate
3. Interest rate for various subgrade and grade loan type  */ 

-- 1) MoM Loan Application growth rate

WITH `ABC`AS 
(SELECT MONTH(issue_date) AS `month number`,
       MONTHNAME(issue_date) AS `month name`,
		COUNT(id) AS `CURRENT MONTH APPLICATION`
		FROM financial_loan 
GROUP BY `month number`,`month name`
ORDER BY `month number`) 

SELECT `month number`,
`month name`,
  (`CURRENT MONTH APPLICATION` - 
  LAG(`CURRENT MONTH APPLICATION`) -- PREVIOUS MONTH , LEAD - NEXT MONTH 
  OVER( ORDER BY `month number`)) / 
  (`CURRENT MONTH APPLICATION`) * 100 AS `growth rate` 
  FROM `ABC`;   

-- 2)  Mom Loan Amount Disbursed growth rate 
SELECT * FROM financial_loan;

 WITH `MONTHLY LOAN` AS 
 (SELECT MONTH(issue_date) AS `MONTH NUMBER`,
MONTHNAME(issue_date) AS `MONTH NAME`,
SUM(loan_amount) AS `CURRENT MONTH LOAN AMOUNT`
FROM financial_loan
GROUP BY `MONTH NUMBER` , `MONTH NAME`
ORDER BY `MONTH NUMBER`)

SELECT `MONTH NUMBER`,
`MONTH NAME`,
`CURRENT MONTH LOAN AMOUNT`,
ROUND((`CURRENT MONTH LOAN AMOUNT` - LAG(`CURRENT MONTH LOAN AMOUNT`)
OVER(ORDER BY `MONTH NUMBER`))  / 
  (`CURRENT MONTH LOAN AMOUNT`) * 100,2) AS `disbursed growth rate` 
  FROM `MONTHLY LOAN`; 

-- 3) Interest rate for various subgrade and grade loan type

SELECT DISTINCT sub_grade,
grade,
ROUND(AVG(int_rate) OVER (PARTITION BY grade),2) AS `GRADE INTREST RATE`,
ROUND(AVG(int_rate) OVER (PARTITION BY sub_grade),2) AS `SUBGRADE INTREST RATE`
FROM financial_loan ;




