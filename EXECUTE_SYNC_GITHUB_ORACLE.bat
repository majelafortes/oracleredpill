cls
@echo off

Rem -- Variables Enviroment
SET USER=mercadogov
SET PASS=oracle123
SET SID=mercadogov
SET VPATH=D:\ORACLEREDPILL\

ECHO Carga Execução Mgage- Objetcs Database AMIDALA

sqlplus -s  %USER%/%PASS%@%SID% @SQLPLUS_Oracle_amidala.sql

rem -- Add Amidala
git add "oracle_table_amidala.csv"
git add "oracle_synonym_amidala.csv"
git add "oracle_procedure_amidala.csv"
git add "oracle_db_link_amidala.csv"
git add "oracle_sequence_amidala.csv"


rem -- Commit Amidala
git commit -m "oracle_table_amidala.log"
git commit -m "oracle_synonym_amidala.log"
git commit -m "oracle_procedure_amidala.log"
git commit -m "oracle_db_link_amidala.log"
git commit -m "oracle_sequence_amidala.log"


rem - Push GitHub
git push -u origin master

