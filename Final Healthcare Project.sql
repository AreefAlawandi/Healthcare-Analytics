create database healthcare_dialysisproject;
use healthcare_dialysisproject;
select * from dialysis_1;
select * from dialysis_2;

## 1.Number of Patients across various summaries
SELECT 
    SUM(Number_of_patients_included_in_the_transfusion_summary) AS Total_Patients_in_TS,
    SUM(Number_of_patients_in_hypercalcemia_summary) AS Total_Patients_in_HS,
    SUM(Number_of_patients_in_Serum_phosphorus_summary) AS Total_Patients_in_SPS,
    SUM(patients_included_hospitalization_summary) AS Total_Patients_in_HospS,
    SUM(Number_of_Patients_included_in_survival_summary) AS Total_Patients_in_SS,
    SUM(Number_of_Patients_included_in_fistula_summary) AS Total_Patients_in_FS,
    SUM(Number_of_patients_in_long_term_catheter_summary) AS Total_Patients_in_LT_Cat_Summary,
    SUM(Number_of_patients_in_nPCR_summary) AS Total_Patients_in_nPCR
FROM
    dialysis_1;
    
## 2.Profit Vs Non-Profit Stats
SELECT DISTINCT
    (Profit_or_NonProfit) AS Profit_Non_Profit,
    COUNT(*) AS Total_Facilities
FROM
    dialysis_1
WHERE
    Profit_or_NonProfit IN ('Profit' , 'Non-Profit')
GROUP BY Profit_or_NonProfit;

## 3.Chain Organizations w.r.t. Total Performance Score as No Score
SELECT DISTINCT
    (Chain_Organization),
    count(Total_Performance_Score) AS Total_Performance_Score
FROM
    dialysis_1 D1
         JOIN
    dialysis_2 D2 ON D1.Facility_Name = D2.Facility_Name
WHERE
    Total_Performance_Score = 'No Score'
GROUP BY Chain_Organization
ORDER BY count(Total_Performance_Score) DESC;

## 4.Dialysis Stations Stats
SELECT DISTINCT
    (city), COUNT('#_of_Dialysis_Stations') AS Dialysis_Stations
FROM
    dialysis_1
GROUP BY city
ORDER BY COUNT('#_of_Dialysis_stations') DESC
LIMIT 10;

## 5.# of Category Text  - As Expected
SELECT 
    SUM(CASE WHEN Patient_Transfusion_category_text = 'As Expected' THEN 1 ELSE 0 END) AS Transfusion_As_Expected_Count,
    SUM(CASE WHEN Patient_hospitalization_category_text = 'As Expected' THEN 1 ELSE 0 END) AS Hospitalization_As_Expected_Count,
    SUM(CASE WHEN Patient_Hospital_Readmission_Category = 'As Expected' THEN 1 ELSE 0 END) AS Hospital_Readmission_As_Expected_Count,
    SUM(CASE WHEN Patient_Survival_Category_Text = 'As Expected' THEN 1 ELSE 0 END) AS Survival_As_Expected_Count,
    SUM(CASE WHEN Patient_Infection_category_text = 'As Expected' THEN 1 ELSE 0 END) AS Infection_As_Expected_Count,
    SUM(CASE WHEN Fistula_Category_Text = 'As Expected' THEN 1 ELSE 0 END) AS Fistula_As_Expected_Count,
    SUM(CASE WHEN SWR_category_text = 'As Expected' THEN 1 ELSE 0 END) AS SWR_As_Expected_Count,
    SUM(CASE WHEN PPPW_category_text = 'As Expected' THEN 1 ELSE 0 END) AS PPPW_As_Expected_Count
FROM dialysis_1;

## 6.Average Payment Reduction Rate
SELECT 
AVG(CAST(Payment_Reduction_Percentage AS DECIMAL(10, 2)))
 AS Average_Payment_Reduction_rate
FROM dialysis_2;
