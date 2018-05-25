select * from PAS_ConditionDetail with(NOLOCK) 



SELECT * FROM (select 'Open' AS Status, RCA.ConditionId, RCA.MemberId, RCA.SiteId , RCA.LastStatusDate As Date, RCA.AlertId, 
RM.SiteCode, RM.ResFriendlyName, RM.ResourceName, RM.OS 
from [dbo].[PAS_ReqCons] RCA with(NOLOCK) inner join 
[dbo].[RegMain] RM with(NOLOCK) on RCA.ParentRegId = RM.RegId
where ConditionId = 30003--CONVERT(date, RCA.LastStatusDate) >= CONVERT(date, GETDATE()-1)
AND RCA.MemberId NOT IN ( '17051', '9394', '142')
union
select 'Closed' AS Status, RCA.ConditionId, RCA.MemberId, RCA.SiteId, RCA.LastStatusDate As Date, RCA.AlertId, 
RM.SiteCode, RM.ResFriendlyName, RM.ResourceName, RM.OS 
from [dbo].[PAS_ReqConsArchive] RCA with(NOLOCK) inner join 
[dbo].[RegMain] RM with(NOLOCK) on RCA.ParentRegId = RM.RegId
where ConditionId = 30003-- CONVERT(date, RCA.LastStatusDate) >= CONVERT(date, GETDATE()-1)
AND RCA.MemberId NOT IN ( '17051', '9394', '142')) results
--ORDER BY LastStatusDate

SELECT GETDATE(), CONVERT(date, GETDATE()-1)
