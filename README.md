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
  - `fct_user_engagement.sql`: User engagement analysis
  - `fct_user_retention.sql`: Retention metrics
  - `fct_users_acquisition.sql`: User acquisition analytics
- Transaction Analytics:
  - `fct_transaction_metrics.sql`: Transaction performance metrics
  - `fct_token_metrics.sql`: Token-specific analytics
- Referral Analytics:
  - `fct_referrals_performance.sql`: Referral program performance

## The Dashboard
### The dashboard track growth metrics like user insight, transaction patterns and token performance, all powered by the dbt data models created. You can interact with the Dashboard here [Link with title](https://app.powerbi.com/view?r=eyJrIjoiYzhjMGZjMTktNDQ4ZS00MTIwLTg1ZTItMTUwZjliNzQ2ZjQzIiwidCI6IjY1OTNhMWIwLTIyMTctNGYwMS05YzdmLTMwNTQ1YTYzYmQ2OSJ9
 "Link title")


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
