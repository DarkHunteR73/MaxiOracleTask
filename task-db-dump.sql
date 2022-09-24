--------------------------------------------------------
--  File created - воскресенье-сентября-25-2022   
--------------------------------------------------------
DROP TABLE "ADDRESS";
DROP TABLE "RESIDENTS";
--------------------------------------------------------
--  DDL for Table ADDRESS
--------------------------------------------------------

  CREATE TABLE "ADDRESS" 
   (	"ID" NUMBER(*,0), 
	"ADDRESS" VARCHAR2(50 BYTE)
   ) ;
--------------------------------------------------------
--  DDL for Table RESIDENTS
--------------------------------------------------------

  CREATE TABLE "RESIDENTS" 
   (	"ID" NUMBER(*,0), 
	"NAME" VARCHAR2(50 BYTE), 
	"ADDR_ID" NUMBER(*,0)
   ) ;
REM INSERTING into ADDRESS
SET DEFINE OFF;
Insert into ADDRESS (ID,ADDRESS) values ('1','Некрасова 72');
Insert into ADDRESS (ID,ADDRESS) values ('2','Гагарина 66');
Insert into ADDRESS (ID,ADDRESS) values ('3','Ленинградская 100');
Insert into ADDRESS (ID,ADDRESS) values ('4','Костромская 10');
REM INSERTING into RESIDENTS
SET DEFINE OFF;
Insert into RESIDENTS (ID,NAME,ADDR_ID) values ('3','Петров Иван','1');
Insert into RESIDENTS (ID,NAME,ADDR_ID) values ('4','Жуковский Пётр','4');
Insert into RESIDENTS (ID,NAME,ADDR_ID) values ('5','Тараканова Дарья','4');
Insert into RESIDENTS (ID,NAME,ADDR_ID) values ('6','Сергеева Анна','1');
Insert into RESIDENTS (ID,NAME,ADDR_ID) values ('7','Панов Николай','1');
Insert into RESIDENTS (ID,NAME,ADDR_ID) values ('8','Павлов Павел','1');
Insert into RESIDENTS (ID,NAME,ADDR_ID) values ('9','Судаков Алексей','1');
Insert into RESIDENTS (ID,NAME,ADDR_ID) values ('10','Петухов Евгений','3');
Insert into RESIDENTS (ID,NAME,ADDR_ID) values ('1','Баранов Алексей','3');
Insert into RESIDENTS (ID,NAME,ADDR_ID) values ('2','Иванов Сергей','3');
--------------------------------------------------------
--  DDL for Index ADDRESS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "ADDRESS_PK" ON "ADDRESS" ("ID") 
  ;
--------------------------------------------------------
--  DDL for Index ADDRESS_UK1
--------------------------------------------------------

  CREATE UNIQUE INDEX "ADDRESS_UK1" ON "ADDRESS" ("ADDRESS") 
  ;
--------------------------------------------------------
--  DDL for Index RESIDENTS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "RESIDENTS_PK" ON "RESIDENTS" ("ID") 
  ;
--------------------------------------------------------
--  Constraints for Table ADDRESS
--------------------------------------------------------

  ALTER TABLE "ADDRESS" MODIFY ("ADDRESS" NOT NULL ENABLE);
  ALTER TABLE "ADDRESS" ADD CONSTRAINT "ADDRESS_PK" PRIMARY KEY ("ID")
  USING INDEX  ENABLE;
  ALTER TABLE "ADDRESS" ADD CONSTRAINT "ADDRESS_UK1" UNIQUE ("ADDRESS")
  USING INDEX  ENABLE;
--------------------------------------------------------
--  Constraints for Table RESIDENTS
--------------------------------------------------------

  ALTER TABLE "RESIDENTS" MODIFY ("NAME" NOT NULL ENABLE);
  ALTER TABLE "RESIDENTS" MODIFY ("ADDR_ID" NOT NULL ENABLE);
  ALTER TABLE "RESIDENTS" ADD CONSTRAINT "RESIDENTS_PK" PRIMARY KEY ("ID")
  USING INDEX  ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table RESIDENTS
--------------------------------------------------------

  ALTER TABLE "RESIDENTS" ADD CONSTRAINT "RESIDENTS_FK1" FOREIGN KEY ("ADDR_ID")
	  REFERENCES "ADDRESS" ("ID") ENABLE;
