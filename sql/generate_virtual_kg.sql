SPARQL CLEAR GRAPH <urn:kg:fint:data>;
SPARQL DROP QUAD MAP <urn:kg:fint:mapping> ;
SPARQL CLEAR GRAPH <urn:kg:fint:mapping>;

SPARQL 
prefix rr: <http://www.w3.org/ns/r2rml#> 
prefix DB: <http://demo.openlinksw.com/schemas/DB/> 
prefix db-stat: <http://demo.openlinksw.com/DB/stat#> 
prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> 
prefix void: <http://rdfs.org/ns/void#> 
prefix scovo: <http://purl.org/NET/scovo#> 
prefix aowl: <http://bblfish.net/work/atom-owl/2006-06-06/> 
prefix foaf: <http://xmlns.com/foaf/0.1/>
prefix schema: <http:/schema.org/>
@prefix fint: <http://www.openlinksw.com/ontology/fint#> .
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>

INSERT INTO GRAPH <urn:kg:fint:mapping>
    {
        <#AccountMappingPhysical>
            a rr:TriplesMap ;
            rr:logicalTable [ rr:tableSchema "Demo" ; rr:tableOwner "fint" ; rr:tableName "account" ] ;
            rr:subjectMap [
                rr:termType rr:IRI ;
                rr:template "http://demo.openlinksw.com/fint/Account/{FintAccountNumber}#this" ;
                rr:class fint:Account ;
                rr:graph <http://demo.openlinksw.com/fint#>
            ] ;
            rr:predicateObjectMap [
                rr:predicateMap [ rr:constant rdfs:label ] ;
                rr:objectMap [ rr:column "FintAccountNumber" ; rr:datatype xsd:string ] ;
            ] ;
            rr:predicateObjectMap [
                rr:predicateMap [ rr:constant fint:hasBalance ] ;
                rr:objectMap [ rr:termType rr:IRI; rr:template "http://demo.openlinksw.com/fint/Balance/{FintAccountNumber}#this" ] ;
            ] ;
            rr:predicateObjectMap [
                rr:predicateMap [ rr:constant fint:hasAccountType ] ;
                rr:objectMap [ rr:termType rr:IRI ; rr:template "http://demo.openlinksw.com/fint/{AccountType}Account" ] ;
            ] ;
            rr:predicateObjectMap [
                rr:predicateMap [ rr:constant fint:hasPrimaryAccountHolder ] ;
                rr:objectMap [ rr:termType rr:IRI; rr:template "http://demo.openlinksw.com/fint/Customer/{PrimaryAccountHolderID}#this" ] ;
            ];
            rr:predicateObjectMap [
            rr:predicateMap [ rr:constant fint:hasSecondaryAccountHolder ] ;
            rr:objectMap [ rr:termType rr:IRI; rr:template "http://demo.openlinksw.com/fint/Customer/{SecondaryAccountHolderID}#this" ] ;
            ].

        <#BalanceMappingPhysical>
            a rr:TriplesMap ;
            rr:logicalTable [ rr:tableSchema "Demo" ; rr:tableOwner "fint" ; rr:tableName "account" ] ;
            rr:subjectMap [
                rr:termType rr:IRI ;
                rr:template "http://demo.openlinksw.com/fint/Balance/{FintAccountNumber}#this" ;
                rr:class fint:Balance ;
                rr:graph <http://demo.openlinksw.com/fint#>
            ] ;
            rr:predicateObjectMap [
                rr:predicateMap [ rr:constant fint:hasBalanceAmount ] ;
                rr:objectMap [ rr:column "Balance" ; rr:datatype xsd:decimal ] ;
            ] ;
            rr:predicateObjectMap [
                rr:predicateMap [ rr:constant fint:hasCurrecny ] ;
                rr:objectMap [ rr:termType rr:IRI; rr:constant fint:USD] ;
            ] .

        <#CustomerPrimaryAccountMappingPhysical>
            a rr:TriplesMap ;
            rr:logicalTable [ rr:tableSchema "Demo" ; rr:tableOwner "fint" ; rr:tableName "account" ] ;
            rr:subjectMap [
                rr:termType rr:IRI ;
                rr:template "http://demo.openlinksw.com/fint/Customer/{PrimaryAccountHolderID}#this" ;
                rr:graph <http://demo.openlinksw.com/fint#>
            ] ;
            rr:predicateObjectMap [
                rr:predicateMap [ rr:constant fint:isPrimaryAccountHolderOf ] ;
                rr:objectMap [ rr:termType rr:IRI; rr:template "http://demo.openlinksw.com/fint/Account/{FintAccountNumber}#this" ;] ;
            ] .

        <#CustomerSecondaryAccountMappingPhysical>
        a rr:TriplesMap ;
        rr:logicalTable [ rr:tableSchema "Demo" ; rr:tableOwner "fint" ; rr:tableName "account" ] ;
        rr:subjectMap [
            rr:termType rr:IRI ;
            rr:template "http://demo.openlinksw.com/fint/Customer/{SecondaryAccountHolderID}#this" ;
            rr:graph <http://demo.openlinksw.com/fint#>
        ] ;
        rr:predicateObjectMap [
            rr:predicateMap [ rr:constant fint:isSecondaryAccountHolderOf ] ;
            rr:objectMap [ rr:termType rr:IRI; rr:template "http://demo.openlinksw.com/fint/Account/{FintAccountNumber}#this" ;] ;
        ] .


        <#CustomerMappingPhysical>
            a rr:TriplesMap ;
            rr:logicalTable [ rr:tableSchema "Demo" ; rr:tableOwner "fint" ; rr:tableName "customer" ] ;
            rr:subjectMap [
                rr:termType rr:IRI ;
                rr:template "http://demo.openlinksw.com/fint/Customer/{CustomerID}#this" ;
                rr:class fint:Customer ;
                rr:graph <http://demo.openlinksw.com/fint#>
            ] ;
            rr:predicateObjectMap [
                rr:predicateMap [ rr:constant rdfs:label ] ;
                rr:objectMap [ rr:column "CustomerID" ] ;
            ] ;
            rr:predicateObjectMap [
                rr:predicateMap [ rr:constant fint:name ] ;
                rr:objectMap [ rr:column "Name" ] ;
            ] ;
            rr:predicateObjectMap [
                rr:predicateMap [ rr:constant fint:hasStreetAddress ] ;
                rr:objectMap [ rr:column "StreetAddress" ] ;
            ] ;
            rr:predicateObjectMap [
                rr:predicateMap [ rr:constant fint:hasCity ] ;
                rr:objectMap [ rr:column "City" ] ;
            ] ;
            rr:predicateObjectMap [
                rr:predicateMap [ rr:constant fint:hasState ] ;
                rr:objectMap [ rr:column "State" ] ;
            ] ;
            rr:predicateObjectMap [
                rr:predicateMap [ rr:constant fint:hasZipCode ] ;
                rr:objectMap [ rr:column "ZipCode" ] ;
            ] ;
            rr:predicateObjectMap [
                rr:predicateMap [ rr:constant fint:hasRiskScore ] ;
                rr:objectMap [ rr:column "RiskScore" ; rr:datatype xsd:decimal ] ;
            ] .

        <#TransactionMappingPhysical>
            a rr:TriplesMap ;
            rr:logicalTable [ rr:tableSchema "Demo" ; rr:tableOwner "fint" ; rr:tableName "transaction" ] ;
            rr:subjectMap [
                rr:termType rr:IRI ;
                rr:template "http://demo.openlinksw.com/fint/Transaction/{TransactionID}#this" ;
                rr:class fint:Transaction ;
                rr:graph <http://demo.openlinksw.com/fint#>
            ] ;
            rr:predicateObjectMap [
                rr:predicateMap [ rr:constant rdfs:label ] ;
                rr:objectMap [ rr:column "TransactionID" ] ;
            ] ;
            rr:predicateObjectMap [
                rr:predicateMap [ rr:constant fint:hasTransactionTimestamp ] ;
                rr:objectMap [ rr:column "Timestamp" ; rr:datatype xsd:dateTime ] ;
            ] ;
            rr:predicateObjectMap [
                rr:predicateMap [ rr:constant fint:hasTransactionValue ] ;
                rr:objectMap [ rr:termType rr:IRI ; rr:template "http://demo.openlinksw.com/fint/TransactionAmount/{TransactionID}#this" ] ;
            ] ;
            rr:predicateObjectMap [
                rr:predicateMap [ rr:constant fint:hasSenderAccount ] ;
                rr:objectMap [ rr:termType rr:IRI; rr:template "http://demo.openlinksw.com/fint/Account/{SenderAccount}#this" ] ;
            ] ;
            rr:predicateObjectMap [
                rr:predicateMap [ rr:constant fint:hasReceiverAccount ] ;
                rr:objectMap [ rr:template "http://demo.openlinksw.com/fint/Account/{ReceiverAccount}#this" ] ;
            ] ;
            rr:predicateObjectMap [
                rr:predicateMap [ rr:constant fint:hasTransactionType ] ;
                rr:objectMap [ rr:column "TransactionType" ] ;
            ] ;
            rr:predicateObjectMap [
                rr:predicateMap [ rr:constant fint:hasTransactionStatus ] ;
                rr:objectMap [ rr:column "Status" ] ;
            ] .

        <#TransactionAmountMappingPhysical>
            a rr:TriplesMap ;
            rr:logicalTable [ rr:tableSchema "Demo" ; rr:tableOwner "fint" ; rr:tableName "transaction" ] ;
            rr:subjectMap [
                rr:termType rr:IRI ;
                rr:template "http://demo.openlinksw.com/fint/TransactionAmount/{TransactionID}#this" ;
                rr:class fint:TransactionValueAmount ;
                rr:graph <http://demo.openlinksw.com/fint#>
            ] ;
            rr:predicateObjectMap [
                rr:predicateMap [ rr:constant fint:hasTransactionValueAmount ] ;
                rr:objectMap [ rr:column "TransactionID"; rr:datatype xsd:decimal ] ;
            ] ;
            rr:predicateObjectMap [
            rr:predicateMap [ rr:constant fint:hasCurrecny ] ;
            rr:objectMap [ rr:termType rr:IRI; rr:constant fint:USD] ;
            ] .



        <#FraudLabelMappingPhysical>
            a rr:TriplesMap ;
            rr:logicalTable [ rr:tableSchema "Demo" ; rr:tableOwner "fint" ; rr:tableName "fraud_label" ] ;
            rr:subjectMap [
                rr:termType rr:IRI ;
                rr:template "http://demo.openlinksw.com/fint/FraudLabel/{TransactionID}#this" ;
                rr:class fint:FraudLabel ;
                rr:graph <http://demo.openlinksw.com/fint#>
            ] ;
            rr:predicateObjectMap [
                rr:predicateMap [ rr:constant fint:isFraud ] ;
                rr:objectMap [ rr:column "IsFraud" ; rr:datatype xsd:boolean ] ;
            ] ;
            rr:predicateObjectMap [
                rr:predicateMap [ rr:constant fint:relatedTransaction ] ;
                rr:objectMap [ rr:termType rr:IRI; rr:template "http://demo.openlinksw.com/fint/Transaction/{TransactionID}#this" ] ;
            ] .
    };

EXEC ('SPARQL ' || DB.DBA.R2RML_MAKE_QM_FROM_G ('urn:kg:fint:mapping','urn:kg:fint:default'));	

