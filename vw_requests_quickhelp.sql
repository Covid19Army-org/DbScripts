create view vw_requests_quickhelp
as
select r.* , json_arrayagg(qhn.needid) as needs from (
select qh.quickhelpid, t.userid as requestownerid, qh.userid as volunteeruserid, qh.volunteerid, v.name as volunteername,
qh.state, qh.district, qh.availability_pincodes, qh.date_created, qh.comments
from quickhelp qh 
join
(select distinct userid, state, district, pincode from helprequests hrq where hrq.status not in (3,4) ) as t
on t.state = qh.state
and (qh.district is null or t.district = qh.district)
and (qh.availability_pincodes is null or  instr( qh.availability_pincodes , t.pincode))
join volunteers v on v.volunteerid = qh.volunteerid) as r
join quickhelpneeds qhn on qhn.quickhelpid = r.quickhelpid
group by r.quickhelpid

