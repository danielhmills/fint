import pandas as pd
import numpy as np
from faker import Faker
import random
import os

fake = Faker()

# Define the number of records for each CSV file
num_records = 1000
num_files = 20

# Generate fixed sets of accounts for more controlled cycles and flows
fixed_accounts = [fake.iban() for _ in range(100)]

# Function to generate synthetic transaction data
def generate_transaction_data(num_records):
    transactions = []
    
    # Generate a proportion of transactions to form cycles and circular flows
    for _ in range(int(num_records * 0.1)):
        account1, account2, account3 = random.sample(fixed_accounts, 3)
        transactions.append([
            fake.uuid4(), fake.date_time_this_year(), round(random.uniform(10.0, 10000.0), 2),
            account1, account2, 'Credit', 'Completed'
        ])
        transactions.append([
            fake.uuid4(), fake.date_time_this_year(), round(random.uniform(10.0, 10000.0), 2),
            account2, account3, 'Credit', 'Completed'
        ])
        transactions.append([
            fake.uuid4(), fake.date_time_this_year(), round(random.uniform(10.0, 10000.0), 2),
            account3, account1, 'Credit', 'Completed'
        ])
    
    # Generate remaining random transactions
    for _ in range(int(num_records * 0.9)):
        transaction_id = fake.uuid4()
        timestamp = fake.date_time_this_year()
        amount = round(random.uniform(10.0, 10000.0), 2)
        sender_account = random.choice(fixed_accounts)
        receiver_account = random.choice(fixed_accounts)
        transaction_type = random.choice(['Credit', 'Debit'])
        status = random.choice(['Completed', 'Pending', 'Failed'])
        transactions.append([transaction_id, timestamp, amount, sender_account, receiver_account, transaction_type, status])
    
    return pd.DataFrame(transactions, columns=['TransactionID', 'Timestamp', 'Amount', 'SenderAccount', 'ReceiverAccount', 'TransactionType', 'Status'])

# Function to generate synthetic customer data
def generate_customer_data(num_records):
    customers = []
    for _ in range(num_records):
        customer_id = fake.uuid4()
        name = fake.name()
        street_address = fake.street_address()
        city = fake.city()
        state = fake.state()
        zip_code = fake.zipcode()
        account_number = random.choice(fixed_accounts)
        risk_score = round(random.uniform(0.0, 1.0), 2)
        customers.append([customer_id, name, street_address, city, state, zip_code, account_number, risk_score])
    return pd.DataFrame(customers, columns=['CustomerID', 'Name', 'StreetAddress', 'City', 'State', 'ZipCode', 'FintAccountNumber', 'RiskScore'])

# Function to generate synthetic account data
def generate_account_data(num_records):
    accounts = []
    for account_number in fixed_accounts:
        balance = round(random.uniform(100.0, 1000000.0), 2)
        account_type = random.choice(['Savings', 'Checking', 'Business'])
        linked_customer_id = fake.uuid4()
        accounts.append([account_number, balance, account_type, linked_customer_id])
    return pd.DataFrame(accounts, columns=['FintAccountNumber', 'Balance', 'AccountType', 'LinkedCustomerID'])

# Function to generate synthetic fraud label data
def generate_fraud_label_data(num_records):
    fraud_labels = []
    for _ in range(num_records):
        transaction_id = fake.uuid4()
        is_fraud = random.choice([True, False])
        fraud_labels.append([transaction_id, is_fraud])
    return pd.DataFrame(fraud_labels, columns=['TransactionID', 'IsFraud'])

# Create a directory to store the CSV files
os.makedirs('synthetic_data', exist_ok=True)
os.makedirs('synthetic_data/accounts', exist_ok=True)
os.makedirs('synthetic_data/customers', exist_ok=True)
os.makedirs('synthetic_data/fraud_labels', exist_ok=True)
os.makedirs('synthetic_data/transactions', exist_ok=True)

# Generate and save the synthetic data to CSV files
for i in range(1, num_files + 1):
    transactions_df = generate_transaction_data(num_records)
    customers_df = generate_customer_data(num_records)
    accounts_df = generate_account_data(num_records)
    fraud_labels_df = generate_fraud_label_data(num_records)

    transactions_df.to_csv(f'synthetic_data/transactions/{i}.csv', index=False)
    customers_df.to_csv(f'synthetic_data/customers/{i}.csv', index=False)
    accounts_df.to_csv(f'synthetic_data/accounts/{i}.csv', index=False)
    fraud_labels_df.to_csv(f'synthetic_data/fraud_labels/{i}.csv', index=False)

print(f"Generated {num_files} sets of synthetic data CSV files.")
