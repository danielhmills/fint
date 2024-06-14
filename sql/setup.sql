-- Install ATTACH_FROM_CSV_DIR
DROP PROCEDURE file_dirlist_full IF NOT EXISTS;
CREATE PROCEDURE file_dirlist_full (IN a ANY)
    {
        DECLARE _inx integer;        
        DECLARE F VARCHAR;
        DECLARE L INT;

        F := file_dirlist(a,1);
        L := length(F);
        _inx := 0;

        
        While(_inx < L){
            DECLARE v any;
        F[_inx] := concat(a,'/',F[_inx]);
        _inx := _inx + 1;

        }

        return F;
    
    };

DROP PROCEDURE attach_from_csv_dir IF NOT EXISTS;
CREATE PROCEDURE attach_from_csv_dir (IN tb VARCHAR, IN dir ANY, in delimiter VARCHAR, in newline VARCHAR, in esc VARCHAR, in skip_rows int, in pkey_columns any := null)
    {
    declare f VARCHAR;

    f:= attach_from_csv(tb,file_dirlist_full(dir),delimiter,newline,esc,skip_rows,pkey_columns);

    return F;
    };

-- Cleanup

SPARQL CLEAR GRAPH  <urn:demo.openlinksw.com:fint>;

DROP TABLE demo.fint.account IF EXISTS;
DROP TABLE demo.fint.customer IF EXISTS;
DROP TABLE demo.fint.transaction IF EXISTS;
DROP TABLE demo.fint.fraud_label IF EXISTS;

DROP TABLE demo.fint.account_physical IF EXISTS;
DROP TABLE demo.fint.customer_physical IF EXISTS;
DROP TABLE demo.fint.transaction_physical IF EXISTS;
DROP TABLE demo.fint.fraud_label_physical IF EXISTS;

ATTACH_FROM_CSV_DIR('demo.fint.account','fint/synthetic_data/accounts',',','\n',null,1,VECTOR(1));
ATTACH_FROM_CSV_DIR('demo.fint.customer','fint/synthetic_data/customers',',','\n',null,1,VECTOR(1));
ATTACH_FROM_CSV_DIR('demo.fint.transaction','fint/synthetic_data/transactions',',','\n',null,1,VECTOR(1));
ATTACH_FROM_CSV_DIR('demo.fint.fraud_label','fint/synthetic_data/fraud_labels',',','\n',null,1,VECTOR(1));

GRANT SELECT ON demo.fint.account to SPARQL_SELECT;
GRANT SELECT ON demo.fint.customer to SPARQL_SELECT;
GRANT SELECT ON demo.fint.transaction to SPARQL_SELECT;
GRANT SELECT ON demo.fint.fraud_label to SPARQL_SELECT;


-- Optional Create SQL Tables Containing Physical Data

CREATE TABLE demo.fint.account_physical
AS SELECT * FROM demo.fint.account
WITH DATA;

CREATE TABLE demo.fint.customer_physical
AS SELECT * FROM demo.fint.customer
WITH DATA;

CREATE TABLE demo.fint.transaction_physical
AS SELECT * FROM demo.fint.transaction
WITH DATA;

CREATE TABLE demo.fint.fraud_label_physical
AS SELECT * FROM demo.fint.fraud_label
WITH DATA;

GRANT SELECT ON demo.fint.account_physical to SPARQL_SELECT;
GRANT SELECT ON demo.fint.customer_physical to SPARQL_SELECT;
GRANT SELECT ON demo.fint.transaction_physical to SPARQL_SELECT;
GRANT SELECT ON demo.fint.fraud_label_physical to SPARQL_SELECT;