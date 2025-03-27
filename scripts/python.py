import requests
import boto3
from botocore.exceptions import NoCredentialsError, ClientError

# AWS Configuration
REGION_NAME = "us-east-1"  # Adjust if necessary
BUCKET_NAME = "your-bucket-name"
S3_FILE_NAME = "filename.csv"

# NYC Open Data API URL
API_URL = "https://data.cityofnewyork.us/resource/7ym2-wayt.csv?$limit=10000&$offset=0"

def fetch_data():
    """Fetch data from the NYC Open Data API."""
    try:
        response = requests.get(API_URL)
        response.raise_for_status()  # Raise an error for bad responses
        return response.text  # CSV data as a string
    except requests.exceptions.RequestException as e:
        print(f"Error fetching data from API: {e}")
        return None

def upload_to_s3(data):
    """Upload data to an S3 bucket using IAM role or AWS CLI credentials."""
    try:
        s3 = boto3.client('s3', region_name=REGION_NAME)
        s3.put_object(Bucket=BUCKET_NAME, Key=S3_FILE_NAME, Body=data)
        print(f"Data successfully uploaded to S3 bucket '{BUCKET_NAME}' as '{S3_FILE_NAME}'.")
    except (NoCredentialsError, ClientError) as e:
        print(f"Error uploading to S3: {e}")

if __name__ == "__main__":
    data = fetch_data()
    if data:
        upload_to_s3(data)
