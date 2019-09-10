-- Table : DEMO_ID 
----------------------------------------------------------
-- Clear table  
----------------------------------------------------------
DROP TABLE "STU046"."DEMO_ID";
DROP SEQUENCE "STU046"."DI_PK";
----------------------------------------------------------
-- Create Table and dependents
-- Table Info:
-- ID       | NUMBER (10) Primary Key
-- Content  | VARCHAR (100) NOT NULL
----------------------------------------------------------
-- Dependents:
-- DI_PK    | Primary Key Sequence
-- DI_BI    | Before Insert Trigger
-- For auto_increment Primary Key
----------------------------------------------------------
CREATE SEQUENCE "STU046"."DI_PK";

CREATE TABLE "STU046"."DEMO_ID" 
( "ID" NUMBER(10,0), 
  "CONTENT" VARCHAR2(100) NOT NULL ENABLE, 
  PRIMARY KEY ("ID") ENABLE
);

CREATE OR REPLACE TRIGGER "STU046"."DI_BI" 
BEFORE INSERT ON DEMO_ID
FOR EACH ROW
BEGIN
  SELECT DI_PK.NEXTVAL
  INTO   :new.ID
  FROM   dual;
END;
/

ALTER TRIGGER "STU046"."DI_BI" ENABLE;
----------------------------------------------------------
-- Data Insert format: 
-- (CONTENT)
----------------------------------------------------------
INSERT INTO DEMO_ID (CONTENT) VALUES ('new content 1');
INSERT INTO DEMO_ID (CONTENT) VALUES ('new content 2');
INSERT INTO DEMO_ID (CONTENT) VALUES ('new content 3');
INSERT INTO DEMO_ID (CONTENT) VALUES ('new content 4');
INSERT INTO DEMO_ID (CONTENT) VALUES ('new content 5');
INSERT INTO DEMO_ID (CONTENT) VALUES ('new content 6');
INSERT INTO DEMO_ID (CONTENT) VALUES ('new content 7');
----------------------------------------------------------
-- End
SELECT * FROM DEMO_ID;
