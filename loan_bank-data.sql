select * from bank_loan

-- The below query displays the number of total loan applications
select count(id) as Total_loan_applications from bank_loan

--The below query displays the Month to Date total loan applications
Select count(id) as MTD_Total_loan_applications from bank_loan
where Month(issue_date)=12

--The below query displays the Previous Month to date Total loan applications
Select count(id) as PMTD_total_loan_applications from bank_loan
where month(issue_date)=11

--The below query displays the total amount of money disbursed 
select sum(loan_amount) as Total_funded_amount from bank_loan

--The below query displays the Month to date total funded amount
Select sum(loan_amount) as MTD_total_funded_amount from bank_loan
where Month(issue_date)=12

-- The below query displays the previous month to date total funded amount
Select sum(loan_amount) as PMTD_total_funded_amount from bank_loan
where Month(issue_date)=11

--The below query displays the total amount received 
Select sum(total_payment) as Total_amount_received from bank_loan

--The below query displays Month to date total amount received 
Select sum(total_payment) as MTD_total_amount_received from bank_loan
where month(issue_date)=12

--The below query displays the previous month to date total amount received 
Select sum(total_payment) as PMTD_total_amount_received from bank_loan
where month(issue_date) =11

--The below query displays the average Interest rate 
Select round(avg(int_rate),4)*100 as Avg_Interest_rate from bank_loan

--The below query displays the month to date average Interest rate
Select round(avg(int_rate),4)*100 as MTD_Avg_Interest_rate from bank_loan
where month(issue_date)=12

--The below query displays the previous month to date average Interest rate
Select round(avg(int_rate),4)*100 as PMTD_Avg_Interest_rate from bank_loan
where month(issue_date)=11

--The below query displays the average debt to income ratio 
Select round(avg(dti),4)*100 as Avg_debt_to_Income_ratio from bank_loan

--The below query displays the average month to date average debt to income ratio
Select round(avg(dti),4)*100 as MTD_Avg_debt_to_Income_ratio from bank_loan
where month(issue_date)=12

--The below query displays the average previous month to date average debt to income ratio
Select round(avg(dti),4)*100 as PMTD_Avg_debt_to_Income_ratio from bank_loan
where month(issue_date)=11

--The below query displays the good loan applications 
Select count(loan_status)as good_loan_applications from bank_loan
where loan_status IN ('Fully Paid','Current')

--The below query displays the bad loan applications
Select count(loan_status) as bad_loan_applicstions from bank_loan
where loan_status='Charged Off'

--The below query displays the total good loan percentage 
Select 
(count(case when loan_status in ('fully Paid','Current') then id end)*100)
/
count(id)as Good_Loan_Percentage from bank_loan

--The below query displays the total bad loan percentage
Select 
(count(case when loan_status='Charged off' then id end)*100)
/
count(id) as bad_loan_percentage from bank_loan

-- The below query display the total funded amount for good Loans
Select sum(loan_amount)as good_loan_funded_amount from bank_loan
where loan_status in ('Fully Paid','Current')

--The below query displays the total amount received for good loans
Select sum(total_payment) as total_amount_received from bank_loan
where loan_status in ('Current','Fully Paid')

--The below query displays the total funded amount for bad loans
Select sum(loan_amount) as bad_loan_funded_amount from bank_loan
where loan_status='Charged Off'

--The below query displays the total amount received for bad loans
select sum(total_payment)as total_amount_received from bank_loan
where loan_status='Charged Off'

--The below query displays the grid view of the total loan applications,total funded amount,
--total amount received, average Interest rate, average debt to Income ratio
Select loan_status, count(id) as total_loan_applications, sum(loan_amount) as Total_funded_amount, 
sum(total_payment) as total_amount_received,
round(avg(int_rate),4)*100 as Avg_interest_rate, round(avg(dti),4)*100 as Avg_debt_to_Income_ratio from bank_loan
group by loan_status

--The below query displays the grid view of the loan status, sum of month to date funded amount,
--sum of month to total amount received 
Select loan_status, sum(loan_amount) as MTD_total_funded_amount, 
sum(total_payment) as MTD_total_amount_received from bank_loan
where month(issue_date)=12
group by loan_status

--The below query displays the grid view of the loan status, sum of previous month to date funded amount,
--sum of previous month to total amount received 
Select loan_status, sum(loan_amount) as PMTD_total_funded_amount, 
sum(total_payment) as PMTD_total_amount_received from bank_loan
where month(issue_date)=11
group by loan_status

--The below query displays the grid view of the month number,month name, total applications,
--total funded amount, total amount received 
Select month(issue_date) as Month_number,DATENAME(month, issue_date)as Month_name,
count(id) as total_loan_applications, sum(loan_amount) as Total_funded_amount, 
sum(total_payment) as total_amount_received from bank_loan
group by month(issue_date), DATENAME(month, issue_date)
order by month (issue_date)

-- The below query displays the grid view of the top 10 address state with its corresponding 
--total loan applications, total funded amount, total amount received
Select Top 10 address_state, count(id) as total_loan_applications, sum(loan_amount) as Total_funded_amount,
sum(total_payment) as total_amount_received  from bank_loan
group by address_state
order by count(id) desc

-- The below query displays the grid view of the loan term with its corresponding 
--total loan applications, total funded amount, total amount received
Select term, count(id) as total_loan_applications, sum(loan_amount) as Total_funded_amount,
sum(total_payment) as total_amount_received from bank_loan
group by term
order by term

-- The below query displays the grid view of the employee length with its corresponding 
--total loan applications, total funded amount, total amount received
Select emp_length, count(id) as total_loan_applications, sum(loan_amount) as Total_funded_amount,
sum(total_payment) as total_amount_received,
round(avg(int_rate),4)*100 as Avg_interest_rate, round(avg(dti),4)*100 as Avg_debt_to_Income_ratio from bank_loan
group by emp_length
order by emp_length

-- The below query displays the grid view of the loan purpose with its corresponding 
--total loan applications, total funded amount, total amount received
Select purpose, count(id) as total_loan_applications, sum(loan_amount) as Total_funded_amount,
sum(total_payment) as total_amount_received from bank_loan
group by purpose
order by count(id) desc

-- The below query displays the grid view of the home ownwership with its corresponding 
--total loan applications, total funded amount, total amount received
Select home_ownership, count(id) as total_loan_applications, sum(loan_amount) as Total_funded_amount, 
sum(total_payment) as total_amount_received
from bank_loan
group by home_ownership
order by count(id) desc