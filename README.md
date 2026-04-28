*  Machine Performance & Failure Analysis (SQL Project)

This project analyzes industrial machine data using SQL views to understand engine performance, 
failures, efficiency, and life span.

*  Project Overview

The dataset is explored through multiple SQL views to:

Analyze engine failures and reliability
Measure performance and efficiency by engine type
Identify root causes of failures
Study machine life span based on operational hours
* Key Views Created
1. Data Overview
Machine_DataSet – Core machine dataset view
2. Failure Analysis
AllEngineTypeFailure – Failure types per engine
machinePerformancesAndFailures – Failure count by engine type
EngineFailures – Average metrics for failed engines only
3. Root Cause Analysis
RootCauseAnalysis – Average sensor conditions per failure type
4. Life Span Analysis
EngineLifeSpan – Machine age (New, Mid Life, Old) vs failure
5. Performance & Efficiency
AvgPerformancePerEngineType – Average performance per engine type
EngineTypeEfficiencyComparison – Efficiency vs failures comparison
EfficiencyScore – Final efficiency score per engine type

*
The analysis helps identify which engine types perform best, which fail most frequently, 
and how operational conditions affect machine reliability and life span.
