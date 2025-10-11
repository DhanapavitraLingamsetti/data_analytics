# Strava Fitness Data Analysis

**PostgreSQL | Python | Power BI**

## 📌 Project Overview

This comprehensive data analytics project analyzes Strava fitness app data across 33 users and 940+ activity records to identify strategic growth opportunities and user behavior patterns. The project demonstrates end-to-end data pipeline capabilities, from database management to executive-level business intelligence insights.

## 📂 Project Background

**Strava Fitness Dataset**: Multi-dimensional fitness tracking data spanning April-May 2016, including daily activity metrics, sleep patterns, heart rate monitoring, and weight logs across 18 comprehensive datasets representing real user engagement with fitness technology platforms.

## 📁 Project File Structure

**[SQL Pipeline](./SQL/)**: Data extraction, cleaning, and preprocessing scripts establishing the analytical foundation through database setup, table creation, data validation, and initial business logic implementation.

**[Python Analytics](./Python/)**: Advanced exploratory data analysis and statistical modeling using Jupyter notebooks to uncover correlation patterns, user segmentation insights, and temporal behavior analysis with custom visualizations.

**[Power BI Intelligence](./Power%20BI/)**: Executive-level dashboard creation transforming cleaned data into interactive business intelligence reports featuring market overview, user engagement metrics, health insights, and strategic recommendations.

**[Reports Documentation](./Reports/)**: Comprehensive analysis documentation for each tool phase, providing detailed methodology explanations, key findings summaries, and business implications for stakeholder review.

## 📈 Problem Statement & Business Context

This project explores insights by analyzing Strava fitness data using SQL, Python, and Power BI to unlock growth opportunities for fitness technology platforms in an increasingly competitive wellness market.

* How can user activity patterns inform optimal engagement timing and campaign strategies?
* What feature adoption gaps represent the highest-value expansion opportunities?
* Which user segments drive platform loyalty and how can coaching interventions improve retention?
* What correlations between health metrics enable predictive modeling for personalized experiences?
* How do temporal behavior patterns create actionable business intelligence for revenue optimization?

## 🛠️ Tools & Technologies Used

* **PostgreSQL** – Used for data storage, cleaning, and initial analysis with complex queries handling 15 datasets and 940+ records
* **pgAdmin4** – Served as the database interface to manage table relationships, execute cleaning scripts, and validate data integrity
* **Python** – Used for advanced statistical analysis, correlation modeling, user segmentation, and creating 7 custom visualizations
* **Power BI** – Designed interactive dashboards to transform analytical findings into executive-level business intelligence with 4-page strategic reports
* **VS Code** – For writing, organizing, and documenting the codebase across SQL scripts, Python notebooks, and project documentation
* **Git & GitHub** – Facilitated version control and management of all scripts, notebooks, and dashboards for professional portfolio presentation

## 🧮 [SQL Data Preparation & Analysis](./SQL/)

* **[Data Import & Setup](./SQL/3_modify_table.sql)**: Successfully imported and validated 15 out of 18 datasets (83% coverage) into PostgreSQL with proper schema design and relationship establishment
* **Data Selection Rationale**: Excluded minute-level granular tables and wide-format datasets to optimize performance while maintaining analytical depth for strategic insights
* **[Data Cleaning](./SQL/4_cleaning_and_basic_eda.sql)**: Removed 546 duplicate sleep records, standardized date formats, handled 97% NULL values in weight data, and resolved column naming inconsistencies
* **[Core Analysis](./SQL/5_analysis.sql)**: Identified 32.2% goal achievement rate, 16.5-hour daily sedentary patterns, and 5-7 PM peak activity windows through comprehensive user behavior analysis
* **Integration Note**: Cleaned SQL outputs provide validated foundation for Power BI dashboard creation and Python statistical modeling with consistent data integrity

## 📊 [Power BI Dashboard](./Power%20BI/)

* **Data Pipeline**: Connected Power BI directly to PostgreSQL using native connector with star schema modeling and daily_activity as central hub for optimized performance
* **[Dashboard](./Power%20BI/Dashboard%20Pages/)**: 
  - **[Market Overview](./Power%20BI/Dashboard%20Pages/Strava_Dash_Page1.png)**: High-level platform performance metrics showcasing user base health, activity levels, and goal achievement patterns for strategic decision-making
  - **[User Behavior & Engagement](./Power%20BI/Dashboard%20Pages/Strava_Dash_Page2.png)**: Activity timing analysis and behavioral characteristics revealing optimal campaign windows and engagement optimization opportunities
  - **[Health & Wellness Insights](./Power%20BI/Dashboard%20Pages/Strava_Dash_Page3.png)**: Feature adoption rates and sleep quality patterns identifying expansion opportunities in wellness tracking and premium analytics services
  - **[Strategic Recommendations](./Power%20BI/Dashboard%20Pages/Strava_Dash_Page4.png)**: Actionable business strategy with quantified impact projections and prioritized implementation roadmap for platform growth
* **Business Takeaways**: 75.8% weight tracking expansion opportunity, 6-7 PM optimal engagement window, and 68% goal failure rate requiring systematic motivation intervention

## 🐍 [Python Data Analysis](./Python/strava_eda_dataviz.ipynb)

* **Data Pipeline**: Imported 8 strategically selected datasets from PostgreSQL using psycopg2 and SQLAlchemy for advanced statistical analysis and correlation modeling
* **Data Validation**: Verified data consistency post-SQL cleaning with shape verification, missing value analysis, and cross-table relationship validation
* **Exploratory Analysis**: Discovered perfect steps-distance correlation (0.99), weight tracker performance advantage (1,457 additional daily steps), and three distinct user engagement segments
* **User Behavior Analysis**: Identified 6-7 PM peak activity windows (599 steps/hour), temporal patterns showing Saturday highest activity (8,153 steps), and sleep impact on next-day performance with optimal 6-8 hour sleep duration
* **Business Insights**: Quantified 75.8% weight tracking expansion opportunity, 67.8% goal failure rate requiring systematic gamification, and competitive differentiation through sedentary intervention market (16.5 hours daily)
* **[Visualizations](./Python/Visualisations/)**: 
  - **Feature Adoption Rates**: Shows 75.8% weight tracking gap representing massive expansion opportunity and 42.4% heart rate adoption indicating mid-tier premium partnership potential
  - **Hourly Activity Patterns**: Reveals clear 6-7 PM peak (599 steps/hour) for optimal campaign timing and secondary 12-2 PM lunch break opportunity for workplace wellness programs
  - **Activity Intensity Breakdown**: Exposes sedentary dominance at 81% (16.5 hours) highlighting major health intervention need and only 1.7% very active time showing huge fitness coaching potential

## 📄 [Reference Reports](./Reports/)

Separate, detailed reports for each phase — **[SQL](./Reports/Strava%20SQL%20Cleaning%20and%20Analysis%20Report.pdf)**, **[Python](./Reports/Strava%20Python%20Analysis%20Report.pdf)**, and **[Power BI](./Reports/Strava%20PowerBI%20Dashboard%20Analysis%20Report.pdf)** — are available for deeper review, containing comprehensive methodology documentation, technical implementation details, and quantified business impact analysis.

## 🔚 Conclusion

* **Key Insights**: Platform demonstrates exceptional 92% tracking consistency with systematic opportunities across motivation systems (68% goal failure), feature expansion (76% weight tracking gap), and wellness positioning (16.5-hour sedentary intervention market)
* **Final Thoughts**: This multi-tool analysis successfully transforms raw fitness data into actionable business intelligence, demonstrating technical proficiency while delivering quantified revenue opportunities and strategic recommendations essential for competitive fitness platform growth