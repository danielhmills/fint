ATTACH_FROM_CSV_DIR('demo.fint.account','financial-transactions-demo/synthetic_data/accounts',',','\n',null,1,VECTOR(1));
ATTACH_FROM_CSV_DIR('demo.fint.customer','financial-transactions-demo/synthetic_data/customers',',','\n',null,1,VECTOR(1));
ATTACH_FROM_CSV_DIR('demo.fint.transaction','financial-transactions-demo/synthetic_data/transactions',',','\n',null,1,VECTOR(1));
ATTACH_FROM_CSV_DIR('demo.fint.fraud_label','financial-transactions-demo/synthetic_data/fraud_labels',',','\n',null,1,VECTOR(1));

DROP TABLE demo.fint.account;
DROP TABLE demo.fint.customer;
DROP TABLE demo.fint.transaction;
DROP TABLE demo.fint.fraud_label;