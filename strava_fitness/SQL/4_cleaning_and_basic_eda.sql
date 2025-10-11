/*
================================================================================
DATA QUALITY ASSESSMENT COMPLETE - SUMMARY RESULTS
================================================================================

DATASET VALIDATION STATUS:
- All 15 tables successfully validated and cleaned
- Total records processed: 5.3+ million across all granularity levels
- Data collection period: 31 days (April 12 - May 12, 2016)
- User base: 33 unique users identified

================================================================================
TABLE CATEGORIES SUMMARY:
================================================================================

-- DAILY TABLES (4): Perfect consistency across all metrics
-- daily_activity, daily_calories, daily_intensities, daily_steps
-- 33 users, 28.5 avg tracking days per user (92% daily engagement)
-- 940 records each, 0 NULL values, 0 duplicates
-- Business Insight: High core engagement indicates strong product-market fit

-- HOURLY TABLES (3): Complete granular data 
-- hourly_calories, hourly_intensities, hourly_steps  
-- 22,099+ records each, 0 NULL values, 0 duplicates
-- Business Insight: Enables premium time-based analytics and peak activity identification

-- MINUTE TABLES (4): Massive datasets with excellent integrity
-- minute_calories_narrow, minute_intensities_narrow, minute_mets_narrow, minute_steps_narrow
-- 1.3+ million records each, 0 NULL values, 0 duplicates  
-- Business Insight: Real-time tracking capability for advanced coaching features

-- HEALTH TABLES (4): Varying adoption rates revealing business opportunities
-- heartrate_seconds, minute_sleep, sleep_day, weight_log_info
-- Data cleaned and validated, adoption gaps identified
-- Business Insight: Major expansion opportunities in health tracking engagement

================================================================================
KEY BUSINESS FINDINGS:
================================================================================

-- HIGH CORE ENGAGEMENT: 92% daily activity tracking (28.5/31 days average)
-- HEART RATE OPPORTUNITY: Only 42% user adoption (14/33 users)  
-- SLEEP TRACKING GAP: 73% tracking rate (24/33 users)
-- WEIGHT TRACKING OPPORTUNITY: Only 24% adoption (8/33 users)
-- SEDENTARY BEHAVIOR: Average 16.5 hours sedentary time per day
-- LOW ACTIVITY INTENSITY: Only 21 minutes very active time daily

================================================================================
DATA QUALITY ISSUES RESOLVED:
================================================================================

-- SLEEP DATA DUPLICATES: 
-- minute_sleep: 543 duplicates removed (188,521 to 187,978 records)
-- sleep_day: 3 duplicates removed (413 to 410 records)
-- Solution: Used SERIAL row_id primary keys, cleaned with ROW_NUMBER()

-- WEIGHT DATA MISSING VALUES:
-- Fat percentage: 97% missing (65/67 records NULL)  
-- Solution: Documented as business opportunity, kept NULLs for analysis
-- Business Value: Major opportunity for body composition tracking expansion
*/

/* 
Basic EDA:
1. daily_activity:
*/

-- Check for NULL values in all columns
SELECT 
    COUNT(*) as total_rows,
    COUNT(id) as id_count,
    COUNT(activity_date) as date_count,
    COUNT(total_steps) as steps_count,
    COUNT(total_distance) as distance_count,
    COUNT(tracker_distance) as tracker_distance_count,
    COUNT(logged_activities_distance) as logged_activities_count,
    COUNT(very_active_distance) as very_active_distance_count,
    COUNT(moderately_active_distance) as moderately_active_distance_count,
    COUNT(light_active_distance) as light_active_distance_count,
    COUNT(sedentary_active_distance) as sedentary_active_distance_count,
    COUNT(very_active_minutes) as very_active_minutes_count,
    COUNT(fairly_active_minutes) as fairly_active_minutes_count,
    COUNT(lightly_active_minutes) as lightly_active_minutes_count,
    COUNT(sedentary_minutes) as sedentary_minutes_count,
    COUNT(calories) as calories_count
FROM 
    daily_activity;
-- Insight: No NULL values - daily_activity is clean

-- Check for duplicate user/date combinations
SELECT 
    id, activity_date, 
    COUNT(*) as duplicate_count
FROM 
    daily_activity
GROUP BY 
    id, activity_date
HAVING 
    COUNT(*) > 1;
-- Insight: No duplicates found

-- Check for unrealistic values and date range
SELECT 
    MIN(total_steps) as min_steps,
    MAX(total_steps) as max_steps,
    AVG(total_steps)::INT as avg_steps,
    MIN(calories) as min_calories,
    MAX(calories) as max_calories,
    AVG(calories)::INT as avg_calories,
    MIN(total_distance) as min_distance,
    MAX(total_distance) as max_distance,
    MIN(activity_date) as first_date,
    MAX(activity_date) as last_date,
    COUNT(DISTINCT activity_date) as unique_dates
FROM 
    daily_activity;
-- Insight: Data spans exactly 31 days (April 12 - May 12, 2016) with realistic ranges - average user takes 7,638 steps and burns 2,304 calories daily, though some days show zero activity indicating device non-usage periods.

-- How many unique users and their activity patterns
SELECT 
    COUNT(DISTINCT id) as unique_users,
    COUNT(*) as total_records,
    ROUND(COUNT(*)::DECIMAL / COUNT(DISTINCT id), 1) as avg_days_per_user
FROM 
    daily_activity;
-- Insight: We have 33 unique users with an average of 28.5 tracking days each (out of 31 possible days), indicating high user engagement with 92% daily usage consistency.

-- 2. daily_calories:

-- Check for NULL values in daily_calories
SELECT 
    COUNT(*) as total_rows,
    COUNT(id) as id_count,
    COUNT(activity_day) as date_count,
    COUNT(calories) as calories_count
FROM 
    daily_calories;
-- Insight: No Null values, daily_calories is clean

-- Check for duplicate user/date combinations in daily_calories
SELECT 
    id, activity_day, 
    COUNT(*) as duplicate_count
FROM 
    daily_calories
GROUP BY 
    id, activity_day
HAVING 
    COUNT(*) > 1;
-- Insight: No duplicates found

-- Check calorie ranges and date span for daily_calories
SELECT 
    MIN(calories) as min_calories,
    MAX(calories) as max_calories,
    AVG(calories)::INT as avg_calories,
    MIN(activity_day) as first_date,
    MAX(activity_day) as last_date,
    COUNT(DISTINCT activity_day) as unique_dates
FROM 
    daily_calories;
-- Insight: Daily calories matches daily_activity perfectly - same date range (31 days), identical calorie ranges (0-4900, avg 2304), confirming data consistency across tables.

-- 3. daily_intensities:

-- Check for NULL values in daily_intensities
SELECT 
    COUNT(*) as total_rows,
    COUNT(id) as id_count,
    COUNT(activity_day) as date_count,
    COUNT(sedentary_minutes) as sedentary_count,
    COUNT(lightly_active_minutes) as lightly_active_count,
    COUNT(fairly_active_minutes) as fairly_active_count,
    COUNT(very_active_minutes) as very_active_count
FROM 
    daily_intensities;
-- Insight: No Null values, daily_intensities is clean

-- Check for duplicate user/date combinations in daily_intensities
SELECT 
    id, activity_day,  
    COUNT(*) as duplicate_count
FROM 
    daily_intensities
GROUP BY 
    id, activity_day
HAVING 
    COUNT(*) > 1;
-- Insight: No duplicates found

-- Check activity intensity ranges and patterns
SELECT 
    MIN(sedentary_minutes) as min_sedentary,
    MAX(sedentary_minutes) as max_sedentary,
    AVG(sedentary_minutes)::INT as avg_sedentary,
    MIN(very_active_minutes) as min_very_active,
    MAX(very_active_minutes) as max_very_active,
    AVG(very_active_minutes)::INT as avg_very_active,
    MIN(activity_day) as first_date,
    MAX(activity_day) as last_date
FROM 
    daily_intensities;
-- Insight: Users are highly sedentary (avg 991 min = 16.5 hours/day) with minimal very active time (avg 21 min/day), revealing significant opportunities for Strava to increase user engagement and activity levels.

-- Check unique users and consistency for daily_intensities
SELECT 
    COUNT(DISTINCT id) as unique_users,
    COUNT(*) as total_records,
    ROUND(COUNT(*)::DECIMAL / COUNT(DISTINCT id), 1) as avg_days_per_user
FROM 
    daily_intensities;
-- Insight: Daily intensities shows identical user engagement as daily_activity - 33 users with 28.5 avg tracking days, confirming perfect data consistency across daily tables.

-- 4. daily_steps: 

-- Check for NULL values in daily_steps
SELECT 
    COUNT(*) as total_rows,
    COUNT(id) as id_count,
    COUNT(activity_day) as date_count,
    COUNT(step_total) as steps_count
FROM 
    daily_steps;
-- Insight: No Null values, daily_steps is clean

-- Check for duplicate user/date combinations in daily_steps
SELECT 
    id, activity_day, 
    COUNT(*) as duplicate_count
FROM 
    daily_steps
GROUP BY 
    id, activity_day
HAVING 
    COUNT(*) > 1;
-- Insight: No duplicates found

-- Check step ranges and date span for daily_steps
SELECT 
    MIN(step_total) as min_steps,
    MAX(step_total) as max_steps,
    AVG(step_total)::INT as avg_steps,
    MIN(activity_day) as first_date,
    MAX(activity_day) as last_date,
    COUNT(DISTINCT activity_day) as unique_dates
FROM 
    daily_steps;
-- Insight: Daily steps perfectly matches daily_activity step data - same ranges (0-36,019, avg 7,638) and date coverage, confirming excellent data consistency across daily tables.

-- Check unique users and consistency for daily_steps
SELECT 
    COUNT(DISTINCT id) as unique_users,
    COUNT(*) as total_records,
    ROUND(COUNT(*)::DECIMAL / COUNT(DISTINCT id), 1) as avg_days_per_user
FROM 
    daily_steps;
-- Insight: Daily steps shows identical user engagement pattern - 33 users with 28.5 avg tracking days, confirming perfect consistency across all daily-level tables.

-- 5. hourly_calories:

-- Check for NULL values in hourly_calories
SELECT 
    COUNT(*) as total_rows,
    COUNT(id) as id_count,
    COUNT(activity_hour) as hour_count,
    COUNT(calories) as calories_count
FROM 
    hourly_calories;
-- Insight: No Null values, hourly_calories is clean

-- Check for duplicate user/hour combinations in hourly_calories
SELECT 
    id, activity_hour, 
    COUNT(*) as duplicate_count
FROM 
    hourly_calories
GROUP BY 
    id, activity_hour
HAVING 
    COUNT(*) > 1;
-- Insight: No duplicates found

-- Check hourly calorie ranges and time span
SELECT 
    MIN(calories) as min_calories,
    MAX(calories) as max_calories,
    AVG(calories)::INT as avg_calories,
    MIN(activity_hour) as first_hour,
    MAX(activity_hour) as last_hour,
    COUNT(DISTINCT DATE(activity_hour)) as unique_dates,
    COUNT(DISTINCT id) as unique_users
FROM 
    hourly_calories;
-- Insight: Hourly calories shows realistic hourly burn rates (42-948, avg 97 cal/hour) with 33 users tracked across 31 days, indicating granular tracking capability that could enable premium time-based analytics features for Strava.

-- 6. hourly_intensities:

-- Check for NULL values in hourly_intensities
SELECT 
    COUNT(*) as total_rows,
    COUNT(id) as id_count,
    COUNT(activity_hour) as hour_count,
    COUNT(total_intensity) as total_intensity_count,
    COUNT(average_intensity) as avg_intensity_count
FROM 
    hourly_intensities;
-- Insight: No Null values, hourly_intensities is clean

-- Check for duplicate user/hour combinations in hourly_intensities
SELECT 
    id, activity_hour, 
    COUNT(*) as duplicate_count
FROM 
    hourly_intensities
GROUP BY 
    id, activity_hour
HAVING 
    COUNT(*) > 1;
-- Insight: No duplicates found

-- Check hourly intensity ranges and patterns
SELECT 
    MIN(total_intensity) as min_total_intensity,
    MAX(total_intensity) as max_total_intensity,
    AVG(total_intensity)::INT as avg_total_intensity,
    MIN(average_intensity) as min_avg_intensity,
    MAX(average_intensity) as max_avg_intensity,
    ROUND(AVG(average_intensity), 2) as avg_avg_intensity,
    MIN(activity_hour) as first_hour,
    MAX(activity_hour) as last_hour,
    COUNT(DISTINCT id) as unique_users
FROM 
    hourly_intensities;
-- Insight: Hourly intensities reveal low activity patterns (avg 12 total intensity, 0.20 average intensity) with significant variation (0-180 range), indicating most hours are sedentary with occasional high-intensity periods - valuable for Strava's activity optimization algorithms.

-- 7. hourly_steps:

-- Check for NULL values in hourly_steps
SELECT 
    COUNT(*) as total_rows,
    COUNT(id) as id_count,
    COUNT(activity_hour) as hour_count,
    COUNT(step_total) as steps_count
FROM 
    hourly_steps;
-- Insight: No Null values, hourly_steps is clean

-- Check for duplicate user/hour combinations in hourly_steps
SELECT 
    id, activity_hour, 
    COUNT(*) as duplicate_count
FROM 
    hourly_steps
GROUP BY 
    id, activity_hour
HAVING 
    COUNT(*) > 1;
-- Insight: No duplicates found

-- Check hourly_step ranges and patterns
SELECT 
    MIN(step_total) as min_steps,
    MAX(step_total) as max_steps,
    AVG(step_total)::INT as avg_steps,
    MIN(activity_hour) as first_hour,
    MAX(activity_hour) as last_hour,
    COUNT(DISTINCT id) as unique_users
FROM 
    hourly_steps;
-- Insight: Hourly steps show realistic patterns (0-10,554, avg 320 steps/hour) enabling peak activity time identification - critical data for Strava's engagement optimization and personalized workout timing recommendations.

-- 8. minute_calories_narrow:

-- Check for NULL values in minute_calories_narrow
SELECT 
    COUNT(*) as total_rows,
    COUNT(id) as id_count,
    COUNT(activity_minute) as minute_count,
    COUNT(calories) as calories_count
FROM 
    minute_calories_narrow;
-- Insight: No Null values, minute_calories_narrow is clean

-- Check for duplicate user/minute combinations in minute_calories_narrow
SELECT 
    id, activity_minute, 
    COUNT(*) as duplicate_count
FROM 
    minute_calories_narrow
GROUP BY 
    id, activity_minute
HAVING 
    COUNT(*) > 1;
-- Insight: No duplicates found

-- Check minute calorie ranges and patterns
SELECT 
    MIN(calories) as min_calories,
    MAX(calories) as max_calories,
    ROUND(AVG(calories), 2) as avg_calories,
    MIN(activity_minute) as first_minute,
    MAX(activity_minute) as last_minute,
    COUNT(DISTINCT DATE(activity_minute)) as unique_dates,
    COUNT(DISTINCT id) as unique_users
FROM 
    minute_calories_narrow;
-- Insight: Minute-level calories show realistic burn rates (0-19.75, avg 1.62 cal/min = 97 cal/hour) with complete 31-day coverage across 33 users, enabling precise real-time metabolism tracking for premium Strava features.

-- 9. minute_intensities_narrow:

-- Check for NULL values in minute_intensities_narrow
SELECT 
    COUNT(*) as total_rows,
    COUNT(id) as id_count,
    COUNT(activity_minute) as minute_count,
    COUNT(intensity) as intensity_count
FROM 
    minute_intensities_narrow;
-- Insight: No Null values, minute_intensities_narrow is clean

-- Check for duplicate user/minute combinations in minute_intensities_narrow
SELECT 
    id, activity_minute, 
    COUNT(*) as duplicate_count
FROM 
    minute_intensities_narrow
GROUP BY 
    id, activity_minute
HAVING 
    COUNT(*) > 1;
-- Insight: No duplicates found

-- Check minute intensity ranges and patterns
SELECT 
    MIN(intensity) as min_intensity,
    MAX(intensity) as max_intensity,
    ROUND(AVG(intensity), 2) as avg_intensity,
    MIN(activity_minute) as first_minute,
    MAX(activity_minute) as last_minute,
    COUNT(DISTINCT DATE(activity_minute)) as unique_dates,
    COUNT(DISTINCT id) as unique_users
FROM 
    minute_intensities_narrow;
-- Insight: Minute intensities reveal low activity levels (avg 0.20 on 0-3 scale) with complete temporal coverage, indicating most minutes are sedentary - perfect data for Strava's activity prompting and engagement algorithms.

-- 10. minute_mets_narrow:

-- Check for NULL values in minute_mets_narrow
SELECT 
    COUNT(*) as total_rows,
    COUNT(id) as id_count,
    COUNT(activity_minute) as minute_count,
    COUNT(mets) as mets_count
FROM 
    minute_mets_narrow;
-- Insight: No Null values, minute_mets_narrow is clean

-- Check for duplicate user/minute combinations in minute_mets_narrow
SELECT 
    id, activity_minute, 
    COUNT(*) as duplicate_count
FROM 
    minute_mets_narrow
GROUP BY 
    id, activity_minute
HAVING 
    COUNT(*) > 1;
-- Insight: No duplicates found

-- Check minute METs ranges and patterns
SELECT 
    MIN(mets) as min_mets,
    MAX(mets) as max_mets,
    ROUND(AVG(mets), 2) as avg_mets,
    MIN(activity_minute) as first_minute,
    MAX(activity_minute) as last_minute,
    COUNT(DISTINCT DATE(activity_minute)) as unique_dates,
    COUNT(DISTINCT id) as unique_users
FROM 
    minute_mets_narrow;
-- Insight: Minute METs show wide metabolic range (0-157, avg 14.69) indicating diverse activity intensities from rest to high-performance exercise - valuable for Strava's personalized training zone recommendations and calorie accuracy.

-- 11. minute_steps_narrow:

-- Check for NULL values in minute_steps_narrow
SELECT 
    COUNT(*) as total_rows,
    COUNT(id) as id_count,
    COUNT(activity_minute) as minute_count,
    COUNT(steps) as steps_count
FROM 
    minute_steps_narrow;
-- Insight: No Null values, minute_steps_narrow is clean

-- Check for duplicate user/minute combinations in minute_steps_narrow
SELECT 
    id, activity_minute, 
    COUNT(*) as duplicate_count
FROM 
    minute_steps_narrow
GROUP BY 
    id, activity_minute
HAVING 
    COUNT(*) > 1;
-- Insight: No duplicates found

-- Check minute step ranges and patterns
SELECT 
    MIN(steps) as min_steps,
    MAX(steps) as max_steps,
    ROUND(AVG(steps), 2) as avg_steps,
    MIN(activity_minute) as first_minute,
    MAX(activity_minute) as last_minute,
    COUNT(DISTINCT DATE(activity_minute)) as unique_dates,
    COUNT(DISTINCT id) as unique_users
FROM 
    minute_steps_narrow;
-- Insight: Minute steps show realistic patterns (0-220, avg 5.34 steps/min = 320 steps/hour) with complete temporal coverage, enabling precise activity burst detection and sedentary break recommendations for Strava users.

-- 12. heartrate_seconds: 

-- Check for NULL values in heartrate_seconds
SELECT 
    COUNT(*) as total_rows,
    COUNT(id) as id_count,
    COUNT(time) as time_count,
    COUNT(value) as heartrate_count
FROM 
    heartrate_seconds;
-- Insight: No Null values, heartrate_seconds is clean

-- Check for duplicate user/time combinations in heartrate_seconds
SELECT 
    id, time, 
    COUNT(*) as duplicate_count
FROM 
    heartrate_seconds
GROUP BY 
    id, time
HAVING 
    COUNT(*) > 1;
-- Insight: No duplicates found

-- Check heart rate ranges and patterns
SELECT 
    MIN(value) as min_heartrate,
    MAX(value) as max_heartrate,
    ROUND(AVG(value), 1) as avg_heartrate,
    MIN(time) as first_timestamp,
    MAX(time) as last_timestamp,
    COUNT(DISTINCT DATE(time)) as unique_dates,
    COUNT(DISTINCT id) as unique_users
FROM 
    heartrate_seconds;
-- Insight: Heart rate data covers realistic ranges (36-203 BPM, avg 77.3) but only 14 of 33 users have heart rate tracking, revealing significant opportunity for Strava to increase wearable device adoption and premium heart rate analytics features.

-- 13. minute_sleep:

-- Check for NULL values in minute_sleep
SELECT 
    COUNT(*) as total_rows,
    COUNT(id) as id_count,
    COUNT(date) as date_count,
    COUNT(value) as value_count,
    COUNT(logid) as logid_count
FROM 
    minute_sleep;
-- Insight: No Null values, minute_sleep is clean

-- Check for duplicate user/date/logid combinations in minute_sleep
SELECT 
    id, date, logid, 
    COUNT(*) as duplicate_count
FROM 
    minute_sleep
GROUP BY 
    id, date, logid
HAVING 
    COUNT(*) > 1;
-- Insight: 543 duplicate records found in minute_sleep. 

-- Removing duplicates
-- Delete duplicates keeping only the first occurrence
DELETE FROM minute_sleep
WHERE row_id IN (
    SELECT row_id
    FROM (
        SELECT row_id,
               ROW_NUMBER() OVER (PARTITION BY id, date, value, logid ORDER BY row_id) as rn
        FROM minute_sleep
    ) ranked
    WHERE rn > 1
);

-- Check how many records remain
SELECT 
    COUNT(*) as records_after_cleanup 
FROM 
    minute_sleep;
-- Insight: Minute sleep data cleaned - removed 543 duplicate records, now have 187,978 unique minute-level sleep records for accurate analysis.

-- Check sleep value ranges and patterns
SELECT 
    MIN(value) as min_sleep_value,
    MAX(value) as max_sleep_value,
    ROUND(AVG(value), 2) as avg_sleep_value,
    MIN(date) as first_timestamp,
    MAX(date) as last_timestamp,
    COUNT(DISTINCT DATE(date)) as unique_dates,
    COUNT(DISTINCT id) as unique_users,
    COUNT(DISTINCT logid) as unique_sleep_sessions
FROM 
    minute_sleep;
-- Insight: Clean sleep data shows sleep states (1-3 scale, avg 1.10) for 24 of 33 users across 32 days with 459 sleep sessions, indicating 73% user adoption but revealing opportunity for Strava to expand sleep tracking engagement.

-- 14. sleep_day:

-- Check for NULL values in sleep_day
SELECT 
    COUNT(*) as total_rows,
    COUNT(id) as id_count,
    COUNT(sleep_day) as sleep_day_count,
    COUNT(total_sleep_records) as sleep_records_count,
    COUNT(total_minutes_asleep) as minutes_asleep_count,
    COUNT(total_time_in_bed) as time_in_bed_count
FROM 
    sleep_day;
-- Insight: No Null values, sleep_day is clean

-- Check for duplicate user/sleep_day combinations in sleep_day
SELECT 
    id, sleep_day, 
    COUNT(*) as duplicate_count
FROM 
    sleep_day
GROUP BY 
    id, sleep_day
HAVING 
    COUNT(*) > 1;
-- Insight: 3 duplicate daily sleep records found (6 total duplicate entries)

-- Clean sleep_day duplicates using the same approach
DELETE FROM sleep_day
WHERE row_id IN (
    SELECT row_id
    FROM (
        SELECT row_id,
               ROW_NUMBER() OVER (PARTITION BY id, sleep_day ORDER BY row_id) as rn
        FROM sleep_day
    ) ranked
    WHERE rn > 1
);

-- Check how many records remain
SELECT 
    COUNT(*) as records_after_cleanup 
FROM 
    sleep_day;
-- Insight: Sleep day data cleaned - removed 3 duplicate records, now have 410 unique daily sleep summaries for accurate analysis.

-- Check sleep day ranges and patterns
SELECT 
    MIN(total_sleep_records) as min_sleep_records,
    MAX(total_sleep_records) as max_sleep_records,
    ROUND(AVG(total_sleep_records), 1) as avg_sleep_records,
    MIN(total_minutes_asleep) as min_minutes_asleep,
    MAX(total_minutes_asleep) as max_minutes_asleep,
    ROUND(AVG(total_minutes_asleep), 1) as avg_minutes_asleep,
    MIN(total_time_in_bed) as min_time_in_bed,
    MAX(total_time_in_bed) as max_time_in_bed,
    ROUND(AVG(total_time_in_bed), 1) as avg_time_in_bed,
    COUNT(DISTINCT id) as unique_users
FROM 
    sleep_day;
-- Insight: Daily sleep shows healthy patterns (avg 7 hours asleep, 7.6 hours in bed) with 24 users tracked, revealing 39-minute average time to fall asleep - valuable data for Strava's sleep optimization and recovery recommendations.

-- 15. weight_log_info:

-- Check for NULL values in weight_log_info
SELECT 
    COUNT(*) as total_rows,
    COUNT(id) as id_count,
    COUNT(date) as date_count,
    COUNT(weight_kg) as weight_kg_count,
    COUNT(weight_pounds) as weight_pounds_count,
    COUNT(fat) as fat_count,
    COUNT(bmi) as bmi_count,
    COUNT(is_manual_report) as manual_report_count,
    COUNT(logid) as logid_count
FROM 
    weight_log_info;
-- Insights: Insight: Weight log info shows complete data except fat percentage (only 2 of 67 records) - indicates most users don't have body composition scales, revealing opportunity for Strava to promote advanced fitness tracking devices.

-- Check for duplicate user/date/logid combinations in weight_log_info
SELECT 
    id, date, logid, 
    COUNT(*) as duplicate_count
FROM 
    weight_log_info
GROUP BY 
    id, date, logid
HAVING 
    COUNT(*) > 1;
-- Insight: No duplicates found

-- Check weight and body composition ranges and patterns
SELECT 
    MIN(weight_kg) as min_weight_kg,
    MAX(weight_kg) as max_weight_kg,
    ROUND(AVG(weight_kg), 2) as avg_weight_kg,
    MIN(weight_pounds) as min_weight_pounds,
    MAX(weight_pounds) as max_weight_pounds,
    ROUND(AVG(weight_pounds), 2) as avg_weight_pounds,
    MIN(bmi) as min_bmi,
    MAX(bmi) as max_bmi,
    ROUND(AVG(bmi), 2) as avg_bmi,
    MIN(date) as first_date,
    MAX(date) as last_date,
    COUNT(DISTINCT id) as unique_users,
    COUNT(fat) as users_with_fat_data
FROM 
    weight_log_info;
-- Insight: Weight data shows realistic ranges (avg 72kg, BMI 25.19) but only 8 of 33 users track weight (24% adoption) with just 2 tracking body fat - major opportunity for Strava to expand health tracking engagement and premium wellness features.