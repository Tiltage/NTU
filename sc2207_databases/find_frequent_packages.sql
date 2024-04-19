/*
Find all families that frequently shop together
Find all families that frequently dine together
Union these families together (A)
Find all purchase transactions where the entire family was present and which day package was used
Find all dine transactions where the entire family was present and which day package was used
Union these families together (B)
Perform a LEFT JOIN to find out families that shopped/dined together using which day package (else NULL)
*/
WITH first_purchase AS (
  /*
  Joining the relationship table with purchase table
  Find number of users grouped by family, date of transaction, shop ID
  This shows us how many pax from each functional group shopped together in the same instance
  */
  SELECT r.functional_group, DATE_TIME_IN, p.SID, COUNT(DISTINCT r.UID) AS UserCount
  FROM relationship r
  JOIN purchase p ON r.UID = p.UID
  GROUP BY r.functional_group, DATE_TIME_IN, p.SID
),
functional_group_pax_purchase AS (
  /*
  Grouping the relationship table by family
  Find out how many users per functional group
  */
  SELECT r.functional_group, COUNT(*) AS GroupPax
  FROM relationship r
  GROUP BY functional_group
),
third_purchase AS (
  /*
  Join the two tables together based on same family and when all users in a family are present, extracting only families
  Find out the instances when the whole family is shopping together
  */
  SELECT fp.*, fgp.GroupPax
  FROM first_purchase fp
  JOIN functional_group_pax_purchase fgp ON fp.functional_group = fgp.functional_group AND fp.UserCount = fgp.GroupPax
  WHERE fp.functional_group LIKE 'F%'
),
fourth_purchase AS (
  /*
  Sum all the times when the family is shopping together
  */
  SELECT functional_group, SUM(UserCount) AS TotalUserCountTogether
  FROM third_purchase
  GROUP BY functional_group
),
fifth_purchase AS (
  /*
  Sum all the times when users from a family is shopping, regardless of being together or not
  */
  SELECT functional_group, SUM(UserCount) AS TotalUserCount
  FROM first_purchase
  GROUP BY functional_group
),
final_purchase AS (
  /*
  Compare number of times when the family is shopping together with the number of times when individuals of the family is shopping
  Extract out families where the ratio is 0.5, which will determine that they shop frequently together
  */
  SELECT fourth_purchase.functional_group
  FROM fourth_purchase
  JOIN fifth_purchase ON fourth_purchase.functional_group = fifth_purchase.functional_group
  WHERE fourth_purchase.TotalUserCountTogether > 0.5 * fifth_purchase.TotalUserCount
),
first_dine AS (
  /*
  Joining the relationship table with dine table
  Find number of users grouped by family, date of transaction, restaurant outlet ID
  This shows us how many pax from each functional group dined together in the same instance
  */
  SELECT r.functional_group, DATE_TIME_IN, d.OID, COUNT(DISTINCT r.UID) AS UserCount
  FROM relationship r
  JOIN dine d ON r.UID = d.UID
  GROUP BY r.functional_group, DATE_TIME_IN, d.OID
),
functional_group_pax_dine AS (
  /*
  Grouping the relationship table by family
  Find out how many users per functional group
  */
  SELECT r.functional_group, COUNT(*) AS GroupPax
  FROM relationship r
  GROUP BY functional_group
),
third_dine AS (
  /*
  Join the two tables together based on same family and when all users in a family are present, extracting only families
  Find out the instances when the whole family is dining together
  */
  SELECT fd.*, fgp.GroupPax
  FROM first_dine fd
  JOIN functional_group_pax_dine fgp ON fd.functional_group = fgp.functional_group AND fd.UserCount = fgp.GroupPax
  WHERE fd.functional_group LIKE 'F%'
),
fourth_dine AS (
  /*
  Sum all the times when the family is dining together
  */
  SELECT functional_group, SUM(UserCount) AS TotalUserCountTogether
  FROM third_dine
  GROUP BY functional_group
),
fifth_dine AS (
  /*
  Sum all the times when users from a family is dining, regardless of being together or not
  */
  SELECT functional_group, SUM(UserCount) AS TotalUserCount
  FROM first_dine
  GROUP BY functional_group
),
final_dine AS (
  /*
  Compare number of times when the family is dining together with the number of times when individuals of the family is shopping
  Extract out families where the ratio is 0.5, which will determine that they dine frequently together
  */
  SELECT fourth_dine.functional_group
  FROM fourth_dine
  JOIN fifth_dine ON fourth_dine.functional_group = fifth_dine.functional_group
  WHERE fourth_dine.TotalUserCountTogether > 0.5 * fifth_dine.TotalUserCount
),
functional_groups_together AS (
  /*
  Union the families who shop frequently together with the families who dine frequently together
  */
SELECT functional_group FROM final_purchase
UNION
SELECT functional_group FROM final_dine
),
all_fgs AS ( 
  /*
  Union the instances where families who shop frequently together with the families who dine frequently together
  */
SELECT functional_group, DATE_TIME_IN FROM third_dine
UNION
SELECT functional_group, DATE_TIME_IN FROM third_purchase
),


positive_results_purchase as (
	/*
	Find all families that purchased items together and what day package they used
	Ensure the whole family is present by checking the count(*) of the people involved and the actual number of people in the family
	*/
	select functional_group, DID, date_of_use
	from (
		/*
		Group all transactions by their functional groups that are families, date of transaction and day package voucher
		*/
		select functional_group, date_of_use, dpuu.DID, count(*) as number_of_uses
		from (
			/*
			Find all transactions where a day package was used, and which package voucher was involved
			*/
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
		where fgs.functional_group = relationship.functional_group)
),
positive_results_dine as (
	/*
	Find all families that dined together and what day package they used
	Ensure the whole family is present by checking the count(*) of the people involved and the actual number of people in the family
	*/
	select functional_group, DID, date_of_use
	from (
		/*
		Group all transactions by their functional groups that are families, date of transaction and day package voucher
		*/
		select functional_group, date_of_use, dpuu.DID as DID, count(*) as number_of_uses
		from (
			/*
			Find all meals where a day package was used, and which package voucher was involved
			*/
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
		where fgs.functional_group = relationship.functional_group)
),
positive_results AS (
/*
Union these 2 groups together to find all transactions of families that used a day package when they dine / purchase together
*/
SELECT * FROM positive_results_dine
UNION
SELECT * FROM positive_results_purchase
)
/*
LEFT JOIN to match all instances where families purchase / dine together, with what day package they used if any, else NULL
*/
select all_fgs.functional_group, all_fgs.DATE_TIME_IN, positive_results.DID
from all_fgs
left join positive_results on all_fgs.functional_group = positive_results.functional_group
	AND all_fgs.DATE_TIME_IN = positive_results.date_of_use