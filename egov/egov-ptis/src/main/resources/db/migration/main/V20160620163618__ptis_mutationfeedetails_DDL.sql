/* Master table for mutation fee calculation */

CREATE SEQUENCE SEQ_EGPT_MUTATION_FEE_DETAILS;

CREATE TABLE EGPT_MUTATION_FEE_DETAILS
(
	ID BIGINT NOT NULL, -- PRIMARY KEY
	LOW_LIMIT DOUBLE PRECISION, -- LOW LIMIT AMOUNT FOR DOCUMENT VALUE
	HIGH_LIMIT DOUBLE PRECISION, -- HIGH LIMIT AMOUNT FOR DOCUMENT VALUE
	FROMDATE TIMESTAMP WITHOUT TIME ZONE, -- PERC VALIDITY START DATE
	TODATE TIMESTAMP WITHOUT TIME ZONE, -- PERC VALIDITY END DATE
	PERCENTAGE DOUBLE PRECISION, -- TAX PERC TO BE APPLICABLE
	FLAT_AMOUNT DOUBLE PRECISION, -- FLAT AMOUNT TO BE APPLICABLE
	IS_RECURSIVE CHARACTER VARYING(20) DEFAULT 'N'::character varying,
	RECURSIVE_FACTOR DOUBLE PRECISION, -- RECURSIVE FACTOR TO BE APPLIED
	RECURSIVE_AMOUNT DOUBLE PRECISION, -- RECURSIVE AMOUNT TO BE APPLIED
	CREATEDBY BIGINT NOT NULL,
	LASTMODIFIEDBY BIGINT NOT NULL,
	CREATEDDATE TIMESTAMP WITHOUT TIME ZONE NOT NULL,
	LASTMODIFIEDDATE TIMESTAMP WITHOUT TIME ZONE NOT NULL,
	VERSION BIGINT,
	CONSTRAINT PK_EGPT_MUT_FEE_DETAILS_ID PRIMARY KEY (ID ),
	CONSTRAINT FK_EGPT_MUT_FEE_DETAILS_CREATEDBY FOREIGN KEY (CREATEDBY) REFERENCES EG_USER (ID),
	CONSTRAINT FK_EGPT_MUT_FEE_DETAILS_LASTMODIFIEDBY FOREIGN KEY (LASTMODIFIEDBY) REFERENCES EG_USER (ID)
);


