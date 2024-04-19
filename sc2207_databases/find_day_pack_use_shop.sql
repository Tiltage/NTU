--How to do query

--Find all instances of where day package was used in purchase
/*
select *
from day_package_user dpu, day_package dp, day_package_mall dpm, purchase p
where dpu.DID = dp.DID
	AND dp.DID = dpm.DID
	AND date_of_use = p.DATE_TIME_IN
	AND dpu.UID = p.UID
order by dpu.DID;
*/
select functional_group, DID, date_of_use
from (
	select functional_group, date_of_use, dpuu.DID, count(*) as number_of_uses
	from (
		select dpu.DID, dpu.UID, functional_group, date_of_use, description, pack_vid
		from day_package_user dpu, day_package dp, day_package_mall dpm, purchase p, relationship rs
		where dpu.DID = dp.DID
			AND dp.DID = dpm.DID
			AND date_of_use = p.DATE_TIME_IN
			AND dpu.UID = p.UID
			AND dpu.UID = rs.UID) as dpuu --Add more data to demonstrate how data includes all uses of day packages
	where functional_group LIKE 'F%'
	group by functional_group, date_of_use, dpuu.DID) as fgs --Add more data to demonstrate filtering where not entire group used day package
where fgs.number_of_uses = (
	select count(*)
	from relationship
	where fgs.functional_group = relationship.functional_group);

	/*
select fgs.functional_group, DID, date_of_use
from (
	select functional_group, date_of_use, dpuu.DID, count(*) as number_of_uses
	from (
		select dpu.DID, dpu.UID, functional_group, date_of_use, description, pack_vid
		from day_package_user dpu, day_package dp, day_package_mall dpm, purchase p, relationship rs
		where dpu.DID = dp.DID
			AND dp.DID = dpm.DID
			AND date_of_use = p.DATE_TIME_IN
			AND dpu.UID = p.UID
			AND dpu.UID = rs.UID) as dpuu --Add more data to demonstrate how data includes all uses of day packages
	group by functional_group, date_of_use, dpuu.DID) as fgs, functional_groups_together --Add more data to demonstrate filtering where not entire group used day package
where fgs.number_of_uses = (
	select count(*)
	from relationship
	where fgs.functional_group = relationship.functional_group)
		AND fgs.functional_group IN (functional_groups_together.functional_group);
*/


