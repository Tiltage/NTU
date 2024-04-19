select functional_group, date_of_use, DID
from (
	select functional_group, date_of_use, dpuu.DID as DID, count(*) as number_of_uses
	from (
		select dpu.DID, dpu.UID, functional_group, date_of_use, description, pack_vid
		from day_package_user dpu, day_package dp, day_package_mall dpm, dine d, relationship rs
		where dpu.DID = dp.DID
			AND dp.DID = dpm.DID
			AND date_of_use = d.DATE_TIME_IN
			AND dpu.UID = d.UID
			AND dpu.UID = rs.UID) as dpuu
	where functional_group LIKE 'F%'
	group by functional_group, date_of_use, dpuu.DID) as fgs
where fgs.number_of_uses = (
	select count(*)
	from relationship
	where fgs.functional_group = relationship.functional_group);