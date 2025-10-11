select * from uber_request_data_cleaned;

-- 2. Number of requests from pickup point
SELECT "Pickup point", COUNT(*) AS request_timestamp
FROM uber_request_data_cleaned
GROUP BY "Pickup point"
ORDER BY request_timestamp DESC;

-- 3. Most cancelled hour

SELECT 
    HOUR(`Request timestamp`) AS hour,
    COUNT(*) AS cancelled_count
FROM uber_request_data_cleaned
WHERE Status = 'Cancelled'
GROUP BY HOUR(`Request timestamp`)
ORDER BY cancelled_count DESC;

-- 4. Most "No Cars Available" hour

SELECT 
    HOUR(`Request timestamp`) AS HOUR,
    COUNT(*) AS no_cars_count
FROM uber_request_data_cleaned
WHERE Status = 'No Cars Available'
GROUP BY HOUR(`Request timestamp`)
ORDER BY no_cars_count DESC;

-- 5. Status count by pickup point

SELECT "Pickup point", Status, COUNT(*) AS status_count
FROM uber_request_data_cleaned
GROUP BY "Pickup point", Status
ORDER BY "Pickup point", status_count DESC;

-- 6. Peak request hours overall

SELECT 
    HOUR(`Request timestamp`) AS hour,
    COUNT(*) AS total_requests
FROM uber_request_data_cleaned
GROUP BY HOUR(`Request timestamp`)
ORDER BY total_requests DESC;



