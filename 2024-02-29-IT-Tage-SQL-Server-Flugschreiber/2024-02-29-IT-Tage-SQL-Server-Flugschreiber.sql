-- Wann wurde denn auf was am längsten gewartet?
SELECT * 
  FROM dbo.BlitzWaitStats_Deltas
 ORDER BY wait_time_minutes_per_minute DESC


-- Nur die relevanten Spalten und die relevanten Wartetypen anzeigen:
SELECT CheckDate, wait_type, WaitCategory, wait_time_minutes_per_minute
  FROM dbo.BlitzWaitStats_Deltas
 WHERE wait_type NOT IN ('CXPACKET', 'CXCONSUMER', 'BACKUPIO')
 ORDER BY wait_time_minutes_per_minute DESC


-- Nur die relevanten Zeiträume betrachten
SELECT CheckDate, wait_type, WaitCategory, wait_time_minutes_per_minute
  FROM dbo.BlitzWaitStats_Deltas
 WHERE wait_type NOT IN ('CXPACKET', 'CXCONSUMER', 'BACKUPIO')
   AND CAST(CheckDate AS TIME) BETWEEN '07:00:00' AND '19:00:00'
 ORDER BY wait_time_minutes_per_minute DESC


-- Die Wartezeiten in Relation setzen
SELECT CheckDate, wait_type, WaitCategory, wait_time_minutes_per_minute
     , SUM(wait_time_minutes_per_minute) OVER (PARTITION BY CheckDate) AS CheckDate_SUM
     , SUM(wait_time_minutes_per_minute) OVER (PARTITION BY wait_type) AS wait_type_SUM
  FROM dbo.BlitzWaitStats_Deltas
 WHERE wait_type NOT IN ('CXPACKET', 'CXCONSUMER', 'BACKUPIO', 'BACKUPBUFFER')
   AND CAST(CheckDate AS TIME) BETWEEN '07:00:00' AND '19:00:00'
 ORDER BY wait_time_minutes_per_minute DESC


-- Soviel zu den Wartezeiten


-- Was sagt denn sp_BlitzFirst generell?
SELECT FindingsGroup, COUNT(*) AS Anzahl 
  FROM dbo.BlitzFirst 
 GROUP BY FindingsGroup 
 ORDER BY 2 DESC


-- Welche Probleme gibt es denn mit den Abfragen?
SELECT Finding, COUNT(*) AS Anzahl 
  FROM dbo.BlitzFirst 
 WHERE FindingsGroup = 'Query Problems' 
 GROUP BY Finding 
 ORDER BY 2 DESC


-- sp_BlitzFirst liefert auch allgemeine Informationen
/*
19 = Batch Requests per Sec
20 = Wait Time per Core per Sec
21 = Database Size, Total GB
22 = Database Count
23 = CPU Utilization
40 = Memory Grant/Workspace info
*/
SELECT CheckDate, Finding, Details 
  FROM dbo.BlitzFirst
 WHERE CheckId = 19
 ORDER BY CheckDate


-- Gerade die "Batch Requests per Sec" können aber auch aus den PerfmonStats genommen werden
SELECT * FROM dbo.BlitzPerfmonStats WHERE counter_name = 'Batch Requests/sec' ORDER BY CheckDate

-- Das sind zunächst nur Messwerte zur Messzeit, bzw. wenigen Sekunden zuvor
SELECT 2703756723 - 2701656857            -- 2.099.866
SELECT (2703756723 - 2701656857)/(15*60)  --     2.333


-- Die "echten" Durchschnittswerte über den gesamten Zeitraum gibt es wieder über die "_Deltas"-View
SELECT CheckDate, cntr_delta_per_second AS BatchRequestsPerSec 
  FROM dbo.BlitzPerfmonStats_Deltas 
 WHERE counter_name = 'Batch Requests/sec' 
 ORDER BY CheckDate
