--Select *
--From CIAMachineDataset

Select Product_ID, Type, Air_temperature_K, Process_temperature_K, 
Rotational_speed_rpm, Torque_Nm, Vibration_Levels, Operational_Hours, Failure_Type
From CIAMachineDataset


Select Product_ID, Type, Failure_Type
From CIAMachineDataset
Group by  Product_ID, Type, Failure_Type

--Count of the Different Machine Types Based on There Performance and Failures

Select Type, Failure_Type, Count("Failure_Type") As Failure_Type_Count
From CIAMachineDataset
Group by Type, Failure_Type
Order by Failure_Type_Count DESC

--Root Cause Analysis

Select Failure_Type, ROUND(AVG(Air_temperature_K),3) AS avg_air_temp,
   ROUND(AVG(Process_temperature_K),2) AS avg_process_temp,
    AVG(Rotational_speed_rpm) AS avg_Rotational_speed_rpm,
   ROUND(AVG(Torque_Nm),2) AS avg_torque,
   ROUND(AVG(Vibration_Levels),2) AS avg_vibration
From CIAMachineDataset
Group by Failure_Type

--Failures

Select Failure_Type, ROUND(AVG(Air_temperature_K),3) AS avg_air_temp,
   ROUND(AVG(Process_temperature_K),2) AS avg_process_temp,
    AVG(Rotational_speed_rpm) AS avg_Rotational_speed_rpm,
   ROUND(AVG(Torque_Nm),2) AS avg_torque,
   ROUND(AVG(Vibration_Levels),2) AS avg_vibration
From CIAMachineDataset
 Where Failure_Type <> 'No Failure' 
Group by Failure_Type

--Engine Life Span base on Age

Select Operational_Hours,Failure_Type,Machine_Age
From (Select Operational_Hours, Failure_Type,
Case 
    When Operational_Hours < 50 Then 'New'
    When Operational_Hours < 110 Then 'Mid Life'
    Else 'Old'
    End AS Machine_Age
    From CIAMachineDataset)t
     Group by Operational_Hours, Failure_Type, Machine_Age

     --*/

Select Failure_Type, Machine_Age, Count(Machine_Age) As Total_Machine
From (Select Operational_Hours, Failure_Type,
Case 
    When Operational_Hours < 50 Then 'New'
    When Operational_Hours < 110 Then 'Mid Life'
    Else 'Old'
    End AS Machine_Age
    From CIAMachineDataset)t
     Group by  Failure_Type, Machine_Age
     Order by Failure_Type

--Average performance per engine type

     SELECT 
    Type,
    AVG(Rotational_speed_rpm) AS avg_Rotational_speed_rpm,
    ROUND(AVG(Torque_Nm),3) AS Avg_Torque_Nm,
   ROUND(AVG(Rotational_speed_rpm * Torque_Nm),3) AS Performance_Score
FROM CIAMachineDataset
GROUP BY Type

--Engine Type Efficiency comparison

Select
    Type,
   ROUND(AVG(Vibration_Levels),3) As Avg_Vibration_Levels,
     ROUND(AVG(Process_temperature_K),3) As Avg_Process_temperature_K,
    COUNT(Failure_Type) AS total_failures
From CIAMachineDataset
Group by Type

--Efficiency Score

Select
    Type,
ROUND(AVG(Rotational_speed_rpm * Torque_Nm),3) /
NULLIF(AVG(Vibration_Levels), 0) As Efficiency_Score
From CIAMachineDataset
Group by Type

                                        --VIEW
--Machine_DataSet

Create View Machine_DataSet As

Select Product_ID, Type, Air_temperature_K, Process_temperature_K, 
Rotational_speed_rpm, Torque_Nm, Vibration_Levels, Operational_Hours, Failure_Type
From CIAMachineDataset
Go

--AllEngineTypeFailure

Create View AllEngineTypeFailure As

Select Product_ID, Type, Failure_Type
From CIAMachineDataset
Group by  Product_ID, Type, Failure_Type
Go

--Different Machine Types Based on There Performance and Failures


Create View machinePerformancesAndFailures As

Select Type, Failure_Type, Count("Failure_Type") As Failure_Type_Count
From CIAMachineDataset
Group by Type, Failure_Type
--Order by Failure_Type_Count DESC
Go

--Root Cause Analysis

Create View RootCauseAnalysis As

Select Failure_Type, ROUND(AVG(Air_temperature_K),3) AS avg_air_temp,
   ROUND(AVG(Process_temperature_K),2) AS avg_process_temp,
    AVG(Rotational_speed_rpm) AS avg_Rotational_speed_rpm,
   ROUND(AVG(Torque_Nm),2) AS avg_torque,
   ROUND(AVG(Vibration_Levels),2) AS avg_vibration
From CIAMachineDataset
Group by Failure_Type
Go

--Failures

Create View EngineFailures As

Select Failure_Type, ROUND(AVG(Air_temperature_K),3) AS avg_air_temp,
   ROUND(AVG(Process_temperature_K),2) AS avg_process_temp,
    AVG(Rotational_speed_rpm) AS avg_Rotational_speed_rpm,
   ROUND(AVG(Torque_Nm),2) AS avg_torque,
   ROUND(AVG(Vibration_Levels),2) AS avg_vibration
From CIAMachineDataset
 Where Failure_Type <> 'No Failure' 
Group by Failure_Type
Go

--Engine Life Span base on Age

Create View EngineLifeSpan As

Select Failure_Type, Machine_Age, Count(Machine_Age) As Total_Machine
From (Select Operational_Hours, Failure_Type,
Case 
    When Operational_Hours < 50 Then 'New'
    When Operational_Hours < 110 Then 'Mid Life'
    Else 'Old'
    End AS Machine_Age
    From CIAMachineDataset)t
     Group by  Failure_Type, Machine_Age
     --Order by Failure_Type

     
--Average performance per engine type

Create View AvgPerformancePerEngineType As

     SELECT 
    Type,
    AVG(Rotational_speed_rpm) AS avg_Rotational_speed_rpm,
    ROUND(AVG(Torque_Nm),3) AS Avg_Torque_Nm,
   ROUND(AVG(Rotational_speed_rpm * Torque_Nm),3) AS Performance_Score
FROM CIAMachineDataset
GROUP BY Type
Go

--Engine Type Efficiency comparison

Create View EngineTypeEfficiencyComparison As

Select
    Type,
   ROUND(AVG(Vibration_Levels),3) As Avg_Vibration_Levels,
     ROUND(AVG(Process_temperature_K),3) As Avg_Process_temperature_K,
    COUNT(Failure_Type) AS total_failures
From CIAMachineDataset
Group by Type
Go

--Efficiency Score

Create View EfficiencyScore As

Select
    Type,
ROUND(AVG(Rotational_speed_rpm * Torque_Nm),3) /
NULLIF(AVG(Vibration_Levels), 0) As Efficiency_Score
From CIAMachineDataset
Group by Type
Go