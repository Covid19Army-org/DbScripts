create view covid19army.vw_activitylog_stream
as
select  'help request' as entityname, a.* , at.activitytext,
case 
	when f.name is null then f.mobilenumber 
	else f.name
end as fromuser,
case 
	when t.name is null then t.mobilenumber 
	else t.name
end as touser, null as parententityid, null as parententityname
 from activitylog a join activitytype at on a.activitytypeid=at.activitytypeid
join helprequests hrq on hrq.requestid = a.entityid and a.entitytype = 'HRQ'
join users f on f.userid = a.from_userid
join users t on t.userid = a.to_userid
union
select  'request action' as entityname, a.* , at.activitytext,
case 
	when f.name is null then f.mobilenumber 
	else f.name
end as fromuser,
case 
	when t.name is null then t.mobilenumber 
	else t.name
end as touser, hrq.requestid as parententityid, 'help request' as parententityname
 from activitylog a join activitytype at on a.activitytypeid=at.activitytypeid
join requestactions rqa on rqa.requestionactionid = a.entityid and a.entitytype = 'RQA'
join helprequests hrq on hrq.requestid = rqa.requestid
join users f on f.userid = a.from_userid
join users t on t.userid = a.to_userid