-- 1. Daily Activity Summary - Overall Statistics
-- What are the overall activity statistics across all users?
SELECT 
    COUNT(*) as total_activity_records,
    COUNT(DISTINCT id) as total_users,
    -- Step Statistics
    MIN(total_steps) as min_daily_steps,
    MAX(total_steps) as max_daily_steps,
    ROUND(AVG(total_steps)) as avg_daily_steps,
    -- Calorie Statistics
    MIN(calories) as min_daily_calories,
    MAX(calories) as max_daily_calories,
    ROUND(AVG(calories)) as avg_daily_calories,
    -- Distance Statistics
    ROUND(MIN(total_distance), 2) as min_daily_distance_km,
    ROUND(MAX(total_distance), 2) as max_daily_distance_km,
    ROUND(AVG(total_distance), 2) as avg_daily_distance_km,
    -- Activity Minutes
    ROUND(AVG(very_active_minutes)) as avg_very_active_minutes,
    ROUND(AVG(fairly_active_minutes)) as avg_fairly_active_minutes,
    ROUND(AVG(lightly_active_minutes)) as avg_lightly_active_minutes,
    ROUND(AVG(sedentary_minutes)) as avg_sedentary_minutes
FROM 
    daily_activity;
/* Insights: 
- Average 7,638 steps vs 10K target = 24% shortfall, huge motivation opportunity.
- 991 minutes (16.5 hours) sedentary daily = prime target for activity prompts.
- Only 35 minutes combined active time = major engagement challenge.
*/

-- 2. Most Active vs Least Active Users Analysis
-- Top 5 Most Active Users
SELECT 
    id,
    ROUND(AVG(total_steps)) as avg_daily_steps,
    ROUND(AVG(calories)) as avg_daily_calories,
    COUNT(*) as tracking_days
FROM 
    daily_activity
GROUP BY 
    id
ORDER BY 
    avg_daily_steps DESC
LIMIT 5;
/*  Insights:
- Power User Profile: Top user averages 16K steps (60% above 10K goal) with perfect 31-day tracking
- Calorie Burn Leaders: Most active users burn 1,816-3,420 calories daily vs 2,304 average
- Consistency Champions: 4 of 5 have perfect tracking (31 days) = ideal engagement models
*/
-- Bottom 5 Least Active Users
SELECT 
    id,
    ROUND(AVG(total_steps)) as avg_daily_steps,
    ROUND(AVG(calories)) as avg_daily_calories,
    COUNT(*) as tracking_days
FROM
    daily_activity
GROUP BY
    id
ORDER BY
    avg_daily_steps ASC
LIMIT 5;
/* Insights:
- Severe Activity Gap: Least active user averages only 916 steps (91% below 10K goal) = urgent intervention needed
- Engagement Paradox: Low-step users still track consistently (26-31 days) = engaged but inactive, perfect coaching targets
- Calorie Mystery: Some low-step users burn normal calories (2,173 vs 2,304 avg) = potential device issues or different activity types
*/

-- 3. Step Goal Achievement Analysis
-- How many users achieve 10,000+ steps daily and what percentage is that?
SELECT 
    COUNT(*) as total_activity_days,
    COUNT(
        CASE 
        WHEN total_steps >= 10000 THEN 1 
        END
    ) as days_with_10k_steps,
    ROUND(
        COUNT(
            CASE 
            WHEN total_steps >= 10000 THEN 1 
            END
        ) * 100.0 / COUNT(*), 1
    ) as percentage_10k_days,
    COUNT(
        DISTINCT CASE 
        WHEN total_steps >= 10000 THEN id 
        END
    ) as users_who_hit_10k,
    COUNT(DISTINCT id) as total_users,
    ROUND(
        COUNT(
            DISTINCT CASE 
            WHEN total_steps >= 10000 THEN id 
            END
        ) * 100.0 / COUNT(DISTINCT id), 1
    ) as percentage_users_hit_10k
FROM 
    daily_activity;
/* Insights:
- Goal Achievement Gap: Only 32% of days meet 10K step target = 68% of days fall short, massive motivation opportunity
- User Capability: 76% of users (25/33) have hit 10K at least once = most users CAN achieve it, need consistency help
- Inconsistency Problem: Users hit goal only 1 in 3 days on average = perfect target for daily motivation features
*/

-- 4. Peak Activity Hours
-- What time of day do users burn the most calories?
-- Peak Activity Hours Analysis
SELECT 
    EXTRACT(HOUR FROM h.activity_hour) as hour_of_day,
    COUNT(*) as total_records,
    ROUND(
        AVG(calories)
    ) as avg_calories_per_hour,
    ROUND(
        AVG(step_total)
    ) as avg_steps_per_hour
FROM 
    hourly_calories h
JOIN 
    hourly_steps s ON h.id = s.id 
AND 
    h.activity_hour = s.activity_hour
GROUP BY 
    EXTRACT(HOUR FROM h.activity_hour)
ORDER BY 
    avg_calories_per_hour DESC
LIMIT 10;
/* Insights:
- Evening Peak: 5-7 PM (17-19h) are highest activity hours = prime time for workout notifications and social features
- Lunch Break Activity: 12-2 PM shows strong activity = target office workers with midday movement prompts
- After Work Surge: 6 PM (18h) is absolute peak with 599 steps/hour = optimal timing for group challenges and social engagement
*/

-- 5. Weekend vs Weekday Activity
-- Are users more active on weekends or weekdays?
-- Weekend vs Weekday Activity Comparison
SELECT 
    CASE 
        WHEN EXTRACT(DOW FROM activity_date) IN (0, 6) THEN 'Weekend'
        ELSE 'Weekday'
        END as day_type,
    COUNT(*) as total_days,
    ROUND(AVG(total_steps)) as avg_steps,
    ROUND(AVG(calories)) as avg_calories,
    ROUND(AVG(very_active_minutes)) as avg_very_active_minutes
FROM daily_activity
GROUP BY CASE 
    WHEN EXTRACT(DOW FROM activity_date) IN (0, 6) THEN 'Weekend'
    ELSE 'Weekday'
END
ORDER BY avg_steps DESC;
/* Insights:
- Minimal Activity Difference: Only 118 steps more on weekdays (7,669 vs 7,551) = users maintain consistent activity patterns
- Weekend Calorie Spike: Slightly higher weekend calories (2,310 vs 2,302) despite fewer steps = longer, leisure activities
- Consistent Intensity: Identical very active minutes (21) across both = users aren't "weekend warriors," they're consistently moderate
*/

-- 6. Sleep Tracking Adoption
-- How many users track sleep and what's their average sleep duration?
-- Sleep Tracking Adoption Analysis
SELECT 
    COUNT(DISTINCT id) as sleep_tracking_users,
    (SELECT COUNT(DISTINCT id) FROM daily_activity) as total_users,
    ROUND(COUNT(DISTINCT id) * 100.0 / (SELECT COUNT(DISTINCT id) FROM daily_activity), 1) as sleep_adoption_percentage,
    ROUND(AVG(total_minutes_asleep)) as avg_minutes_asleep,
    ROUND(AVG(total_minutes_asleep) / 60.0, 1) as avg_hours_asleep,
    ROUND(AVG(total_time_in_bed)) as avg_minutes_in_bed,
    ROUND(AVG(total_time_in_bed) / 60.0, 1) as avg_hours_in_bed
FROM sleep_day;
/* Insights:
- Good Sleep Adoption: 73% of users track sleep (24/33) = better than heart rate (42%) but room for 27% growth
- Healthy Sleep Duration: 7 hours average sleep meets recommended guidelines = users prioritize good sleep habits
- Sleep Efficiency Gap: 39 minutes difference between bed time and sleep time = opportunity for sleep optimization coaching
*/