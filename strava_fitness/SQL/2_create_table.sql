-- Create daily_activity table with composite primary key
CREATE TABLE public.daily_activity
(
    id BIGINT,
    activity_date DATE,
    total_steps INT,
    total_distance DECIMAL(10,2),
    tracker_distance DECIMAL(10,2),
    logged_activities_distance DECIMAL(10,2),
    very_active_distance DECIMAL(10,2),
    moderately_active_distance DECIMAL(10,2),
    light_active_distance DECIMAL(10,2),
    sedentary_active_distance DECIMAL(10,2),
    very_active_minutes INT,
    fairly_active_minutes INT,
    lightly_active_minutes INT,
    sedentary_minutes INT,
    calories INT,
    PRIMARY KEY (id, activity_date)
);

-- Create daily_calories table with composite primary key
CREATE TABLE public.daily_calories
(
    id BIGINT,
    activity_day DATE,
    calories INT,
    PRIMARY KEY (id, activity_day)
);

-- Create daily_intensities table with composite primary key
CREATE TABLE public.daily_intensities
(
    id BIGINT,
    activity_day DATE,
    sedentary_minutes INT,
    lightly_active_minutes INT,
    fairly_active_minutes INT,
    very_active_minutes INT,
    sedentary_active_distance DECIMAL(10,2),
    light_active_distance DECIMAL(10,2),
    moderately_active_distance DECIMAL(10,2),
    very_active_distance DECIMAL(10,2),
    PRIMARY KEY (id, activity_day)
);

-- Create daily_steps table with composite primary key
CREATE TABLE public.daily_steps
(
    id BIGINT,
    activity_day DATE,
    step_total INT,
    PRIMARY KEY (id, activity_day)
);

-- Create hourly_calories table with composite primary key
CREATE TABLE public.hourly_calories
(
    id BIGINT,
    activity_hour TIMESTAMP,
    calories INT,
    PRIMARY KEY (id, activity_hour)
);

-- Create hourly_intensities table with composite primary key
CREATE TABLE public.hourly_intensities
(
    id BIGINT,
    activity_hour TIMESTAMP,
    total_intensity INT,
    average_intensity DECIMAL(10,2),
    PRIMARY KEY (id, activity_hour)
);

-- Create hourly_steps table with composite primary key
CREATE TABLE public.hourly_steps
(
    id BIGINT,
    activity_hour TIMESTAMP,
    step_total INT,
    PRIMARY KEY (id, activity_hour)
);

-- Create minute_calories_narrow table with composite primary key
CREATE TABLE public.minute_calories_narrow
(
    id BIGINT,
    activity_minute TIMESTAMP,
    calories DECIMAL(10,2),
    PRIMARY KEY (id, activity_minute)
);

-- Create minute_intensities_narrow table with composite primary key
CREATE TABLE public.minute_intensities_narrow
(
    id BIGINT,
    activity_minute TIMESTAMP,
    intensity INT,
    PRIMARY KEY (id, activity_minute)
);

-- Create minute_mets_narrow table with composite primary key
CREATE TABLE public.minute_mets_narrow
(
    id BIGINT,
    activity_minute TIMESTAMP,
    mets DECIMAL(10,1),
    PRIMARY KEY (id, activity_minute)
);

-- Create minute_steps_narrow table with composite primary key
CREATE TABLE public.minute_steps_narrow
(
    id BIGINT,
    activity_minute TIMESTAMP,
    steps INT,
    PRIMARY KEY (id, activity_minute)
);

-- Create heartrate_seconds table with composite primary key
CREATE TABLE public.heartrate_seconds
(
    id BIGINT,
    time TIMESTAMP,
    value INT,
    PRIMARY KEY (id, time)
);

-- Create minute_sleep table with simple primary key
CREATE TABLE public.minute_sleep
(
    row_id SERIAL PRIMARY KEY,
    id BIGINT,
    date TIMESTAMP,
    value INT,
    logid BIGINT
);

-- Create sleep_day table with simple primary key
CREATE TABLE public.sleep_day
(
    row_id SERIAL PRIMARY KEY,
    id BIGINT,
    sleep_day DATE,
    total_sleep_records INT,
    total_minutes_asleep INT,
    total_time_in_bed INT
);

-- Create weight_log_info table with composite primary key
CREATE TABLE public.weight_log_info
(
    id BIGINT,
    date TIMESTAMP,
    weight_kg DECIMAL(10,2),
    weight_pounds DECIMAL(10,2),
    fat DECIMAL(10,2),
    bmi DECIMAL(10,2),
    is_manual_report BOOLEAN,
    logid BIGINT,
    PRIMARY KEY (id, date, logid)
);

/*
Note: Excluding 3 datasets from analysis:
- minuteCaloriesWide_merged.csv (redundant with Narrow version)
- minuteIntensitiesWide_merged.csv (redundant with Narrow version) 
- minuteStepsWide_merged.csv (redundant with Narrow version)
Using 15 out of 18 total datasets
*/

-- Set ownership of the tables to the postgres user
ALTER TABLE public.daily_activity OWNER to postgres;
ALTER TABLE public.daily_calories OWNER to postgres;
ALTER TABLE public.daily_intensities OWNER to postgres;
ALTER TABLE public.daily_steps OWNER to postgres;
ALTER TABLE public.hourly_calories OWNER to postgres;
ALTER TABLE public.hourly_intensities OWNER to postgres;
ALTER TABLE public.hourly_steps OWNER to postgres;
ALTER TABLE public.minute_calories_narrow OWNER to postgres;
ALTER TABLE public.minute_intensities_narrow OWNER to postgres;
ALTER TABLE public.minute_mets_narrow OWNER to postgres;
ALTER TABLE public.minute_steps_narrow OWNER to postgres;
ALTER TABLE public.heartrate_seconds OWNER to postgres;
ALTER TABLE public.minute_sleep OWNER to postgres;
ALTER TABLE public.sleep_day OWNER to postgres;
ALTER TABLE public.weight_log_info OWNER to postgres;

-- Create indexes on id columns for better performance across all tables
CREATE INDEX idx_daily_activity_id ON public.daily_activity (id);
CREATE INDEX idx_daily_calories_id ON public.daily_calories (id);
CREATE INDEX idx_daily_intensities_id ON public.daily_intensities (id);
CREATE INDEX idx_daily_steps_id ON public.daily_steps (id);
CREATE INDEX idx_hourly_calories_id ON public.hourly_calories (id);
CREATE INDEX idx_hourly_intensities_id ON public.hourly_intensities (id);
CREATE INDEX idx_hourly_steps_id ON public.hourly_steps (id);
CREATE INDEX idx_minute_calories_narrow_id ON public.minute_calories_narrow (id);
CREATE INDEX idx_minute_intensities_narrow_id ON public.minute_intensities_narrow (id);
CREATE INDEX idx_minute_mets_narrow_id ON public.minute_mets_narrow (id);
CREATE INDEX idx_minute_steps_narrow_id ON public.minute_steps_narrow (id);
CREATE INDEX idx_heartrate_seconds_id ON public.heartrate_seconds (id);
CREATE INDEX idx_minute_sleep_id ON public.minute_sleep (id);
CREATE INDEX idx_sleep_day_id ON public.sleep_day (id);
CREATE INDEX idx_weight_log_info_id ON public.weight_log_info (id);