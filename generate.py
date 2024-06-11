import pandas as pd
from faker import Faker
import random
import os

fake = Faker()

# Define the number of records for each CSV file
num_files = 20
num_accounts = 100  # total number of accounts
num_transactions_per_file = 1000  # number of transactions per file

# Function to generate synthetic customer data
def generate_customer_data(num_accounts):
    customers = []
    customer_ids = []
    for _ in range(num_accounts):
        customer_id = fake.uuid4()
        customer_ids.append(customer_id)
        name = fake.name()
        street_address = fake.street_address()
        city = fake.city()
        state = fake.state()
        zip_code = fake.zipcode()
        risk_score = round(random.uniform(0.0, 1.0), 2)
        customers.append([customer_id, name, street_address, city, state, zip_code, risk_score])
    return pd.DataFrame(customers, columns=['CustomerID', 'Name', 'StreetAddress', 'City', 'State', 'ZipCode', 'RiskScore']), customer_ids

# Function to generate synthetic account data using customer IDs
def generate_account_data(customer_ids):
    accounts = []
    for _ in range(num_accounts):
        account_number = fake.iban()
        balance = round(random.uniform(100.0, 1000000.0), 2)
        account_type = random.choice(['Savings', 'Checking', 'Business'])
        primary_holder_id = random.choice(customer_ids)
        # Ensure some accounts may have the same primary and secondary holders or different
        if random.random() > 0.5:
            secondary_holder_id = random.choice(customer_ids)
        else:
            secondary_holder_id = primary_holder_id
        accounts.append([account_number, balance, account_type, primary_holder_id, secondary_holder_id])
    return pd.DataFrame(accounts, columns=['FintAccountNumber', 'Balance', 'AccountType', 'PrimaryAccountHolderID', 'SecondaryAccountHolderID'])

# Function to generate synthetic transaction data
def generate_transaction_data(num_transactions, account_numbers):
    transactions = []
    for _ in range(num_transactions):
        transaction_id = fake.uuid4()
        timestamp = fake.date_time_this_year()
        amount = round(random.uniform(10.0, 10000.0), 2)
        sender_account, receiver_account = random.sample(account_numbers, 2)
        transaction_type = random.choice(['Credit', 'Debit'])
        status = random.choice(['Completed', 'Pending', 'Failed'])
        transactions.append([transaction_id, timestamp, amount, sender_account, receiver_account, transaction_type, status])
    return pd.DataFrame(transactions, columns=['TransactionID', 'Timestamp', 'Amount', 'SenderAccount', 'ReceiverAccount', 'TransactionType', 'Status'])

# Function to generate synthetic fraud label data
def generate_fraud_label_data(num_transactions):
    fraud_labels = []
    for _ in range(num_transactions):
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

# Generate customer data first to ensure consistent CustomerIDs
customers_df, customer_ids = generate_customer_data(num_accounts)
customers_df.to_csv('synthetic_data/customers/customers.csv', index=False)

# Generate account data using existing customer IDs
accounts_df = generate_account_data(customer_ids)
accounts_df.to_csv('synthetic_data/accounts/accounts.csv', index=False)
account_numbers = accounts_df['FintAccountNumber'].tolist()

# Generate and save the synthetic data to CSV files for transactions and fraud labels
for i in range(1, num_files + 1):
    transactions_df = generate_transaction_data(num_transactions_per_file, account_numbers)
    fraud_labels_df = generate_fraud_label_data(num_transactions_per_file)

    transactions_df.to_csv(f'synthetic_data/transactions/{i}.csv', index=False)
    fraud_labels_df.to_csv(f'synthetic_data/fraud_labels/{i}.csv', index=False)

print(f"Generated {num_files} sets of synthetic data CSV files.")
