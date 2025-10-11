/*
Loading Strava datasets using the PSQLTool in pgAdmin4
1. Open pgAdmin
2. In Object Explorer (left-hand pane), navigate to `strava` database
3. Right-click `strava` and select `PSQL Tool`
    - This opens a terminal window to write the following code
4. Get the absolute file path of your csv files
    - Find path by right-clicking a CSV file in VS Code and selecting "Copy Path"
5. Paste the following into `PSQL Tool` (with the CORRECT file path):

SET datestyle = 'MDY';

-- Daily Activity Data
\copy daily_activity FROM 'C:\Work\Labmentix\Labmentix - Strava Data Analysis\Datasets\dailyActivity_merged.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8', NULL 'NULL');

-- Daily Calories Data
\copy daily_calories FROM 'C:\Work\Labmentix\Labmentix - Strava Data Analysis\Datasets\dailyCalories_merged.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8', NULL 'NULL');

-- Daily Intensities Data
\copy daily_intensities FROM 'C:\Work\Labmentix\Labmentix - Strava Data Analysis\Datasets\dailyIntensities_merged.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8', NULL 'NULL');

-- Daily Steps Data
\copy daily_steps FROM 'C:\Work\Labmentix\Labmentix - Strava Data Analysis\Datasets\dailySteps_merged.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8', NULL 'NULL');

-- Hourly Calories Data
\copy hourly_calories FROM 'C:\Work\Labmentix\Labmentix - Strava Data Analysis\Datasets\hourlyCalories_merged.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8', NULL 'NULL');

-- Hourly Intensities Data
\copy hourly_intensities FROM 'C:\Work\Labmentix\Labmentix - Strava Data Analysis\Datasets\hourlyIntensities_merged.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8', NULL 'NULL');

-- Hourly Steps Data
\copy hourly_steps FROM 'C:\Work\Labmentix\Labmentix - Strava Data Analysis\Datasets\hourlySteps_merged.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8', NULL 'NULL');

-- Minute Calories Narrow Data
\copy minute_calories_narrow FROM 'C:\Work\Labmentix\Labmentix - Strava Data Analysis\Datasets\minuteCaloriesNarrow_merged.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8', NULL 'NULL');

-- Minute Intensities Narrow Data
\copy minute_intensities_narrow FROM 'C:\Work\Labmentix\Labmentix - Strava Data Analysis\Datasets\minuteIntensitiesNarrow_merged.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8', NULL 'NULL');

-- Minute METs Narrow Data
\copy minute_mets_narrow FROM 'C:\Work\Labmentix\Labmentix - Strava Data Analysis\Datasets\minuteMETsNarrow_merged.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8', NULL 'NULL');

-- Minute Steps Narrow Data
\copy minute_steps_narrow FROM 'C:\Work\Labmentix\Labmentix - Strava Data Analysis\Datasets\minuteStepsNarrow_merged.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8', NULL 'NULL');

-- Heart Rate Seconds Data
\copy heartrate_seconds FROM 'C:\Work\Labmentix\Labmentix - Strava Data Analysis\Datasets\heartrate_seconds_merged.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8', NULL 'NULL');

-- Minute Sleep Data
\copy minute_sleep(id, date, value, logid) FROM 'C:\Work\Labmentix\Labmentix - Strava Data Analysis\Datasets\minuteSleep_merged.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8', NULL 'NULL');

-- Sleep Day Data
\copy sleep_day(id, sleep_day, total_sleep_records, total_minutes_asleep, total_time_in_bed) FROM 'C:\Work\Labmentix\Labmentix - Strava Data Analysis\Datasets\sleepDay_merged.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8', NULL 'NULL');

-- Weight Log Info Data
\copy weight_log_info(id, date, weight_kg, weight_pounds, fat, bmi, is_manual_report, logid) FROM 'C:\Work\Labmentix\Labmentix - Strava Data Analysis\Datasets\weightLogInfo_merged.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8', NULL '');

OR

Just run the following queries one by one:
*/

-- Daily Activity Data
\copy daily_activity 
FROM 'C:\Your\Path\To\Datasets\dailyActivity_merged.csv' -- Note: Replace with your actual path
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Daily Calories Data
\copy daily_calories 
FROM 'C:\Your\Path\To\Datasets\dailyCalories_merged.csv' -- Note: Replace with your actual path
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Daily Intensities Data
\copy daily_intensities 
FROM 'C:\Your\Path\To\Datasets\dailyIntensities_merged.csv' -- Note: Replace with your actual path
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Daily Steps Data
\copy daily_steps 
FROM 'C:\Your\Path\To\Datasets\dailySteps_merged.csv' -- Note: Replace with your actual path
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Hourly Calories Data
\copy hourly_calories 
FROM 'C:\Your\Path\To\Datasets\hourlyCalories_merged.csv' -- Note: Replace with your actual path
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Hourly Intensities Data
\copy hourly_intensities 
FROM 'C:\Your\Path\To\Datasets\hourlyIntensities_merged.csv' -- Note: Replace with your actual path
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Hourly Steps Data
\copy hourly_steps 
FROM 'C:\Your\Path\To\Datasets\hourlySteps_merged.csv' -- Note: Replace with your actual path
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Minute Calories Narrow Data
\copy minute_calories_narrow 
FROM 'C:\Your\Path\To\Datasets\minuteCaloriesNarrow_merged.csv' -- Note: Replace with your actual path
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Minute Intensities Narrow Data
\copy minute_intensities_narrow 
FROM 'C:\Your\Path\To\Datasets\minuteIntensitiesNarrow_merged.csv' -- Note: Replace with your actual path
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Minute METs Narrow Data
\copy minute_mets_narrow 
FROM 'C:\Your\Path\To\Datasets\minuteMETsNarrow_merged.csv' -- Note: Replace with your actual path
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Minute Steps Narrow Data
\copy minute_steps_narrow 
FROM 'C:\Your\Path\To\Datasets\minuteStepsNarrow_merged.csv' -- Note: Replace with your actual path
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Heart Rate Seconds Data
\copy heartrate_seconds 
FROM 'C:\Your\Path\To\Datasets\heartrate_seconds_merged.csv' -- Note: Replace with your actual path
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Minute Sleep Data
\copy minute_sleep 
FROM 'C:\Your\Path\To\Datasets\minuteSleep_merged.csv' -- Note: Replace with your actual path
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Sleep Day Data
\copy sleep_day 
FROM 'C:\Your\Path\To\Datasets\sleepDay_merged.csv' -- Note: Replace with your actual path
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Weight Log Info Data
\copy weight_log_info 
FROM 'C:\Your\Path\To\Datasets\weightLogInfo_merged.csv' -- Note: Replace with your actual path
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

/*
Note: If you get error:
'could not open file "[your file path]\[filename].csv" for reading: Permission denied.'
I highly recommend you to load the dataset using the PSQLTool in pgAdmin4
*/

/*
Data Quality Adjustments Made:
- minute_sleep: Changed from composite PK to SERIAL row_id due to duplicate entries in CSV
- sleep_day: Changed from composite PK to SERIAL row_id due to duplicate entries in CSV  
- weight_log_info: Used NULL '' in import to handle empty numeric values in CSV
These changes ensure successful data import while maintaining analytical integrity.
*/