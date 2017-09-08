/*
   --------------------------------------------------------------------------
   Project  : mGage
   Company  : Red Pill
   Module   : Database ORCL- Tables and Partitions tables
   --------------------------------------------------------------------------
   Goal        : Extraction Objects from the database amidala
   Author      : Majela Fortes - majela.fortes@redpillanalytics.com
   Mob Brazil  : +55 1 61 99879 9000
   Date        : 06/09/2017
   --------------------------------------------------------------------------
   History of changes

   person      Date      Comments
   ---------   ------    ----------------------------------------------------

   spool E:\git\mgage-redpill-migration-inventory\bos\oracle_table_amidala.csv 

*/



/* -----------------------------------------------------
   --  Amidala--
*/ -----------------------------------------------------

/* Enviroment */


SET PAGESIZE 50000
SET LINESIZE 900
SET NUMWIDTH 30
SET FEEDBACK OFF
set echo off
set heading on
set headsep off
set wrap off
set colsep ,


alter session set nls_date_format='yyyy/mm/dd'


/*  -- Tables ------------------------------------------*/
Column server_name         format a14
column owner               format a20
column table_name          format a40
column date_ast_analyzed   format a40
column size_mb             format 999999999
column rows_count    	   format 999999999
spool %VPATH%oracle_table_amidala.csv
rem @Query_Oracle_table_amidala.sql 

   SELECT (SELECT * FROM GLOBAL_NAME) server_name,
       a.owner,
       b.table_name,
       b.last_analyzed,
       SUM (c.bytes) / 1048576 size_mb,
       a.num_rows
   FROM dba_tables a, user_tables b, dba_segments c
   WHERE     a.table_name = b.table_name
        AND b.table_name = c.segment_name
        AND a.owner = 'MERCADOGOV'
   GROUP BY 
         a.owner,
         b.table_name,
         c.tablespace_name,
         b.last_analyzed,
         a.num_rows
    ORDER BY 1,2,3;

spool off

/* ---End Tables---------------------------------------*/


/*  -- Synonym ------------------------------------------*/
Column server_name  format a14
column owner        format a15
Column synonym_name format a30
Column table_owner  format a15
Column table_name   format a30
Column db_link      format a15
spool %VPATH%oracle_synonym_amidala.csv
rem @Query_Oracle_synonym_amidala.sql

  select 
     (SELECT * FROM GLOBAL_NAME) server_name,
     a.owner,
     a.synonym_name,
     a.table_owner,
     a.table_name,
     a.db_link
  from dba_synonyms a
  Order by 1,2;

spool off

/* ---End Synonyn---------------------------------------*/



/*  -- Procedures ------------------------------------------*/
Column server_name         format a14
column owner               format a20
Column object_name         format a50
column object_type         format a20
column last_ddl_time       format a35
column status              format a10
spool %VPATH%oracle_procedure_amidala.csv
rem @Query_Oracle_procedure_amidala.sql

   SELECT
      (SELECT * FROM GLOBAL_NAME) server_name,
       a.owner,
       b.object_name,
       a.object_type,
       a.last_ddl_time,
       a.status
   FROM dba_objects a, dba_procedures b
   WHERE     a.owner = b.owner
       AND a.object_id = b.object_id
       AND a.object_type = 'PROCEDURE'
       AND a.owner = 'MERCADOGOV'
   order by
        a.owner;

spool off

/* ---End Procedures---------------------------------------*/


/*  -- DB_LINK ------------------------------------------*/
column servername       format a14
column owner            format a20
Column db_link          format a50
column username         format a20
spool %VPATH%oracle_db_link_amidala.csv
rem @Query_Oracle_db_link_amidala.sql

  SELECT        
     (SELECT * FROM GLOBAL_NAME) server_name,
     a.owner,
     a.db_link, 
     a.username
   FROM dba_db_links a;

spool off

/* ---End DB_LINK---------------------------------------*/



/*  -- SEQUENCES ------------------------------------------*/
column servername       format a14
column owner            format a20
Column object_name      format a50
column object_type      format a20
column last_ddl_time    format a40
column status           format a10
spool %VPATH%oracle_sequence_amidala.csv
rem @Query_Oracle_sequence_amidala.sql

   SELECT 
       (SELECT * FROM GLOBAL_NAME) server_name,
       a.owner,
       a.object_name,
       a.object_type,
       a.last_ddl_time,
       a.status
    FROM dba_objects a
    WHERE a.object_type = 'SEQUENCE';

spool off
/* ---End SEQUENCES---------------------------------------*/


/*  -- INDEX ------------------------------------------*/
column servername      format a14
column owner           format a20
Column index_name      format a50
column index_type      format a20
column table_name      format a40
column table_owner     format a10
column table_type      format a20
column num_rows        format a20
column sample_size_mb  format a10
column status          format a10
column last_analyzed   format a30

spool D:\oracleredpill\oracle_index_amidala.csv
rem @Query_Oracle_index_amidala.sql

  SELECT 
       (SELECT * FROM GLOBAL_NAME) server_name,
       a.owner,
       a.index_name,
       a.index_type,
       a.table_name,
       a.table_owner,
       a.table_type,
       a.num_rows,
       ROUND(SUM(a.sample_size) / 1048576) sample_size_mb,
       a.status,
       a.last_analyzed
  FROM dba_indexes a
  WHERE a.table_owner = 'MERCADOGOV'
  group by 
        a.owner,
        a.index_name,
        a.index_type,
        a.table_name,
        a.table_owner,
        a.table_type,
        a.num_rows,
        a.status,
        a.last_analyzed;

spool off
/* ---INDEX---------------------------------------*/



exit