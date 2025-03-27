# NYC Traffic Data Analysis
This project focuses on analyzing traffic data in New York City to help solve traffic congestion problems. The data comes from the NYC Open Data platform, provided by the Department of Transportation (DOT). It includes over 100,000 records of traffic volume collected by Automated Traffic Recorders (ATR) across different streets and times.
The data captures traffic volume in 15-minute intervals and contains detailed information such as date, time, borough, street names, directions, and traffic counts. It also includes geolocation fields and street segment IDs, which help identify where the traffic was recorded.
To process and analyze this data efficiently, we used AWS EC2 to execute the Python Script, AWS S3 to store the CSV file fetched from the website, AWS Glue for data cleaning, and AWS Athena for querying. We built a dashboard using Amazon Quick Sight to visualize traffic trends, such as peak hours and high-traffic streets.

# Business Goal
The core business logic of this project is to transform raw traffic data into actionable insights that can improve transportation management and city planning in New York City. Based on our analysis, the main objectives are:
1.	Traffic Pattern Insights:
o	What are the peak traffic hours, days, and months across NYC, and how do these patterns vary by borough?
o	How do seasonal trends influence traffic volumes across different boroughs?

2.	Geospatial Traffic Analysis:
o	Which streets and boroughs experience the highest traffic congestion, and how can this data inform targeted infrastructure improvements?

3.	Historical Trends:
o	How have traffic volumes evolved over the years, and what external factors (e.g., events, policies) might explain significant changes?

4.	Commuter Behavior:
o	How do daily traffic patterns differ between weekdays and weekends, and what does this reveal about commuter behavior?

5.	Infrastructure Planning:
o	Which boroughs and streets should be prioritized for road expansions or signal timing optimizations based on traffic volume data?

6.	Congestion Management: 
o	What are the hourly traffic patterns across NYC boroughs, and how can this data inform congestion management strategies?


## 🚀 Features

- **Automated Data Extraction**: Python script fetches data from an external API and uploads it to an S3 bucket.
- **AWS Glue Crawler**: Automatically detects and catalogs the data stored in S3.
- **Data Transformation**: Clean and prepare the data using Athena queries and store the cleaned dataset back into S3.
- **Data Analysis**: Query raw and cleaned datasets using AWS Athena.
- **Visualization**: Create interactive dashboards using Amazon QuickSight.
- **Infrastructure as Code (IaC)**: Use Terraform to provision and manage AWS resources.

---

## 📂 Project Structure

```
.
├── scripts/                         # Python scripts
│    ├── fetch_data.py               # Fetches data from the external API
│    └── data_cleansing.sql          # SQL script for data cleaning
├── terraform/                       # Terraform scripts to deploy AWS resources
│    ├── main.tf                     # Main configuration file
│    ├── variables.tf                # Input variables
│    ├── outputs.tf                  # Output variables
│    └── provider.tf                 # AWS provider configuration
├── data/                            # Sample datasets (if applicable)
├── dashboards/                      # Amazon QuickSight dashboards
└── README.md                        # Project documentation
```

---

## ⚙️ How It Works

### 1. **Data Extraction**

- Python script (`fetch_data.py`) fetches data from an external API.
- Data is uploaded to a specified S3 bucket.

### 2. **Data Cataloging**

- AWS Glue crawler detects new data in the S3 bucket and updates the Glue Data Catalog.

### 3. **Data Transformation & Cleaning**

- Use AWS Athena to clean and preprocess the raw data.
- Store the cleaned dataset back into a separate S3 location.

### 4. **Data Analysis**

- Perform SQL-like queries on both raw and cleaned datasets using AWS Athena.

### 5. **Data Visualization**

- Use Amazon QuickSight to create interactive dashboards and visualize key metrics.

---

## 🛠️ Setup and Deployment

### Prerequisites

- AWS account with permissions for EC2, S3, Glue, Athena, and QuickSight.
- Terraform installed ([Install Terraform](https://developer.hashicorp.com/terraform/docs/cli/install/overview))


## 📊 Example Athena Query

```sql
SELECT COUNT(*) AS record_count, category
FROM cleaned_data
GROUP BY category;
```

---

## 📈 Future Enhancements

1. Automate the pipeline using AWS Lambda and EventBridge.
2. Add monitoring with AWS CloudWatch for logs and metrics.
3. Enhance data cleaning with advanced transformation logic.
4. Implement automated alerts for data inconsistencies.

---

