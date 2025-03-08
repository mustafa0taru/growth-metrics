# Growth Metrics Analytics

## Overview
This dbt project implements a comprehensive analytics pipeline for tracking and analyzing growth metrics, user behaviour and business performance. The project transforms raw data into actionable insights through well-structured data models.

## Project Structure
The project follows a three-layer architecture:
![Frame 1 (1)](https://github.com/user-attachments/assets/777523cc-7327-4f81-84cf-a064e8414bd2)

### Staging Layer
Raw data models that implement basic cleaning and standardization:
- `stg_market.sql`: Market related data staging
- `stg_referrals.sql`: User referral program data
- `stg_transactions.sql`: Financial transactions
- `stg_users.sql`: Core user data

### Intermediate Layer
Dimensional models and enriched datasets:
- Dimension Tables:
  - `dim_market.sql`: Market dimension
  - `dim_referrals.sql`: Referral program dimension
  - `dim_transactions.sql`: Transaction dimension
  - `dim_users.sql`: User dimension
- Enriched Models:
  - `int_enriched_transactions.sql`: Enhanced transaction data
  - `int_enriched_users.sql`: Enhanced user profiles

### Marts Layer
Final analytical models focused on specific business domains:
- User Analytics:
  - `fct_user_metrics.sql`: Core user metrics
![Screenshot 2025-03-08 124820](https://github.com/user-attachments/assets/6e935c77-379a-4599-a6bc-3eda1f8f6b69)
  - `fct_user_engagement.sql`: User engagement analysis
![Screenshot 2025-03-08 124938](https://github.com/user-attachments/assets/645e1a24-6a1b-4411-a6af-83305d3d5d73)
  - `fct_user_retention.sql`: Retention metrics
![Screenshot 2025-03-08 125046](https://github.com/user-attachments/assets/503ccf78-e441-483f-98b0-f1c620402b95)
  - `fct_users_acquisition.sql`: User acquisition analytics
- Transaction Analytics:
  - `fct_transaction_metrics.sql`: Transaction performance metrics
![Screenshot 2025-03-08 125243](https://github.com/user-attachments/assets/df1af371-c239-4f43-87cf-6861af454508)
  - `fct_token_metrics.sql`: Token-specific analytics
![Screenshot 2025-03-08 125347](https://github.com/user-attachments/assets/d077a4ee-c2cf-4a39-b344-3810f0bff49f)
- Referral Analytics:
  - `fct_referrals_performance.sql`: Referral program performance
![Screenshot 2025-03-08 125455](https://github.com/user-attachments/assets/fca40d17-70e2-4388-a481-e1acafdf4dbd)


## The Dashboard
The dashboard tracks key growth metrics such as user insights, transaction patterns, and token performance, all powered by the dbt data models. You can interact with the Dashboard [here](https://app.powerbi.com/view?r=eyJrIjoiYzhjMGZjMTktNDQ4ZS00MTIwLTg1ZTItMTUwZjliNzQ2ZjQzIiwidCI6IjY1OTNhMWIwLTIyMTctNGYwMS05YzdmLTMwNTQ1YTYzYmQ2OSJ9).
### 1. User Insights
<img width="459" alt="Screenshot 2025-01-15 190412" src="https://github.com/user-attachments/assets/b346bf71-e282-41eb-bc99-696d5e13715d" />

### 2. Transactions Pattern
<img width="457" alt="Screenshot 2025-01-15 190334" src="https://github.com/user-attachments/assets/7b1e69f5-db87-4502-bdbf-5c5b4665c9e2" />

### 3. Token Performance
<img width="459" alt="Screenshot 2025-01-15 190447" src="https://github.com/user-attachments/assets/e685bd72-adfc-4973-87b4-6466897231f5" />

## Getting Started

### Tools used
- dbt
- Postgres Database
- Python
- Power BI

### Installation
1. Clone this repository
```bash
git clone https://github.com/mustafa0taru/growth-metrics.git
```

2. Install dependencies
```bash
dbt deps
```

3. Configure your `profiles.yml` file with your data warehouse credentials

4. Test the connection
```bash
dbt debug
```

### Running the Models
To run all models:
```bash
dbt run
```

To run specific layers:
```bash
dbt run --models staging
dbt run --models intermediate
dbt run --models marts
```

### Testing
Run the test suite:
```bash
dbt test
```

## Documentation
Generated documentation can be accessed by running:
```bash
dbt docs generate
dbt docs serve
```

## Project Dependencies
- dbt-core
- Required dbt packages are listed in `packages.yml`
